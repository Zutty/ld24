package uk.co.zutty.ld24
{
    import net.flashpunk.Entity;
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    import net.flashpunk.graphics.Spritemap;
    
    public class Building extends PhysicalEntity {
        
        private var _health:Number;
        private var _maxHealth:Number; 
        private var _sprite:Spritemap;
        
        public function Building(img:Class, frameW:Number, frameH:Number, health:Number) {
            super();
            
            _health = health;
            _maxHealth = _health;
            
            _sprite = new Spritemap(img, frameW, frameH);
            _sprite.add("idle", [0, 1, 2], 6, true);
            _sprite.play("idle");
            addGraphic(_sprite);
            
            type = "mob";
            sprHeight = frameH;
            setHitbox(frameW, frameH, 0, 0);
        }
    }
}