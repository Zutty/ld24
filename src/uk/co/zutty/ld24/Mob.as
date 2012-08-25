package uk.co.zutty.ld24
{
    import flash.geom.Point;
    
    import net.flashpunk.Entity;
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    import net.flashpunk.graphics.Graphiclist;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Spritemap;
    
    public class Mob extends Suppliable {
        
        public static const FACTION_FRIENDLY:int = 1;
        public static const FACTION_ENEMY:int = 2;
        
        [Embed(source = 'assets/selected.png')]
        private static const SELECTOR_IMAGE:Class;

        private static const FRAMESIZE:Number = 16;
        
        private var _sprite:Spritemap;
        private var _selector:Image;
        private var _faction:int;
        private var _waypoint:Point;
        private var _moveToWaypoint:Boolean;
        private var _speed:Number;

        public function Mob(img:Class, frames:int, faction:int, speed:Number) {
            super();
            
            _faction = faction;
            _speed = speed;
            
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
            setHitbox(16, 16, 8, 8);
        }
        
        public function goTo(x:Number, y:Number):void {
            _waypoint.x = x;
            _waypoint.y = y;
            _moveToWaypoint = true;
        }
        
        public function get faction():int {
            return _faction;
        }
        
        public function get selected():Boolean {
            return _selector.visible;
        }
        
        public function set selected(s:Boolean):void {
            _selector.visible = s;
        }
        
        override public function update():void {
            super.update();
            
            if(_moveToWaypoint) {
                if(distanceToPoint(_waypoint.x, _waypoint.y) <= _speed) {
                    x = _waypoint.x;
                    y = _waypoint.y;
                    _moveToWaypoint = false;
                } else {
                    moveTowards(_waypoint.x, _waypoint.y, _speed);
                }
            }
        }
    }
}