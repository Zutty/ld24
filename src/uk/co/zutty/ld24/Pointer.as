package uk.co.zutty.ld24
{
    import net.flashpunk.Entity;
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.utils.Input;
    
    public class Pointer extends Entity {
        
        [Embed(source = 'assets/cursor.png')]
        public static const CURSOR_IMAGE:Class;
        
        private var _gfx:Spritemap;
        
        public function Pointer() {
            super();
            
            _gfx = new Spritemap(CURSOR_IMAGE, 16, 16);
            _gfx.add("pointer", [0], 0, false);
            _gfx.add("go", [1,2,3], 6, true);
            _gfx.add("attack", [4,5,6], 6, true);
            _gfx.play("pointer");
            _gfx.centerOrigin();
            graphic = _gfx;
        }
        
        override public function update():void {
            super.update();
            x = Input.mouseX;
            y = Input.mouseY;
        }
    }
}