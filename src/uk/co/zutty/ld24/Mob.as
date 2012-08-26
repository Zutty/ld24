package uk.co.zutty.ld24
{
    import flash.geom.Point;
    
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    import net.flashpunk.graphics.Graphiclist;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Spritemap;
    
    public class Mob extends PhysicalEntity implements Selectable {
        
        public static const FACTION_FRIENDLY:int = 1;
        public static const FACTION_ENEMY:int = 2;
        
        public static const STANCE_AGGRESSIVE:int = 1; 
        public static const STANCE_PASSIVE:int = 2; 
        
        [Embed(source = 'assets/selected.png')]
        private static const SELECTOR_IMAGE:Class;

        private static const FRAMESIZE:Number = 16;
        private static const AGGRO_RANGE:Number = 40;
        private static const ATTACK_RANGE:Number = 18;
        private static const ATTACK_TIME:uint = 30;
        private static const HURT_TIME:uint = 3;
        
        private var _sprite:Spritemap;
        private var _selector:Image;
        private var _faction:int;
        private var _stance:int;
        private var _waypoint:Point;
        private var _moveToWaypoint:Boolean;
        private var _speed:Number;
        private var _health:Number;
        private var _maxHealth:Number;
        
        private var _attackTimer:uint;
        private var _hurtTimer:uint;

        public function Mob(img:Class, frames:int, faction:int, stance:int, speed:Number, health:Number) {
            super();
            
            _faction = faction;
            _stance = stance;
            _speed = speed;
            _health = health;
            _maxHealth = health;
            
            _sprite = new Spritemap(img, FRAMESIZE, FRAMESIZE);
            _sprite.add("still", [0], 6, true);
            _sprite.add("moving", [1, 2], 6, true);
            _sprite.play("still");
            _sprite.centerOrigin();
            addGraphic(_sprite);
            
            _selector = new Image(SELECTOR_IMAGE);
            _selector.visible = false;
            _selector.centerOrigin();
            addGraphic(_selector);
            
            _waypoint = new Point();
            _moveToWaypoint = false;
            
            type = "mob";
            sprHeight = FRAMESIZE;
            setHitbox(16, 16, 8, 8);
        }
        
        override public function added():void {
            _health = _maxHealth;
            _attackTimer = 0;
        }
        
        public function goToPoint(p:Point):void {
            goTo(p.x, p.y);
        }

        public function goTo(x:Number, y:Number):void {
            _waypoint.x = x;
            _waypoint.y = y;
            _moveToWaypoint = true;
        }
        
        public function get faction():int {
            return _faction;
        }
        
        public function get stance():int {
            return _stance;
        }

        public function get selected():Boolean {
            return _selector.visible;
        }
        
        public function set selected(s:Boolean):void {
            _selector.visible = s;
        }
        
        public function attack(m:Mob):void {
            m.hurt(1);
        }
        
        public function hurt(dmg:Number):void {
            _health -= dmg;
            _hurtTimer = HURT_TIME;
            
            if(_health <= 0) {
                _health = 0;
                FP.world.recycle(this);
                (FP.world as GameWorld).deselect(this);
            }
        }
        
        protected function onWaypoint(w:Point):void {}
        
        override public function update():void {
            super.update();
            
            if(_attackTimer > 0) {
                --_attackTimer;
            }
            
            if(_hurtTimer > 0) {
                --_hurtTimer;
                _sprite.color = (_hurtTimer == 0) ? 0xFFFFFF : 0xCC0000;
            }
            
            if(_moveToWaypoint) {
                if(distanceToPoint(_waypoint.x, _waypoint.y) <= _speed) {
                    x = _waypoint.x;
                    y = _waypoint.y;
                    _moveToWaypoint = false;
                    _sprite.play("still");
                    onWaypoint(_waypoint);
                } else {
                    moveTowards(_waypoint.x, _waypoint.y, _speed, ["mob", "terrain"]);
                    _sprite.play("moving");
                    _sprite.flipped = (_waypoint.x - x) > 0;
                }
            }
            
            if(_stance == STANCE_AGGRESSIVE) {
                var m:Mob = FP.world.nearestToEntity("mob", this, true) as Mob;
                if(m && m.faction != _faction) {
                    var dist:Number = distanceFrom(m);
                    
                    if(dist <= ATTACK_RANGE && _attackTimer == 0) {
                        attack(m);
                        _attackTimer = ATTACK_TIME;
                    } else if(dist <= AGGRO_RANGE) {
                        _waypoint.x = m.x;
                        _waypoint.y = m.y;
                    }
                }
            }
        }
    }
}