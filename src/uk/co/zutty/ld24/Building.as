package uk.co.zutty.ld24
{
    import net.flashpunk.Entity;
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    import net.flashpunk.graphics.Graphiclist;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Spritemap;
    
    public class Building extends PhysicalEntity implements Selectable {
        
        [Embed(source = 'assets/selector_corner.png')]
        private static const SELECTOR_CORNER_IMAGE:Class;

        private var _health:Number;
        private var _maxHealth:Number; 
        private var _sprite:Spritemap;
        private var _selector:Graphiclist;
        private var _faction:int;
        private var _stance:int;
        
        public function Building(img:Class, frameW:Number, frameH:Number, health:Number, faction:int, stance:int) {
            super();

            _faction = faction;
            _stance = stance;
            _health = health;
            _maxHealth = _health;
            
            _sprite = new Spritemap(img, frameW, frameH);
            _sprite.add("idle", [0, 1, 2], 6, true);
            _sprite.play("idle");
            addGraphic(_sprite);
            
            _selector = new Graphiclist();
            _selector.visible = false;
            
            var nw:Image = new Image(SELECTOR_CORNER_IMAGE);
            nw.centerOrigin();
            _selector.add(nw);
            
            var ne:Image = new Image(SELECTOR_CORNER_IMAGE);
            ne.x = frameW;
            ne.flipped = true;
            ne.centerOrigin();
            _selector.add(ne);
            
            var sw:Image = new Image(SELECTOR_CORNER_IMAGE);
            sw.y = frameH;
            sw.centerOrigin();
            sw.scaleY = -1;
            _selector.add(sw);

            var se:Image = new Image(SELECTOR_CORNER_IMAGE);
            se.x = frameW;
            se.y = frameH;
            se.scaleY = -1;
            se.flipped = true;
            se.centerOrigin();
            _selector.add(se);

            addGraphic(_selector);
            
            type = "mob";
            sprHeight = frameH;
            setHitbox(frameW, frameH, 0, 0);
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
    }
}