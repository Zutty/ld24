package uk.co.zutty.ld24
{
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
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
            _gfx.add("move", [1,2,3], 12, true);
            _gfx.add("attack", [4,5,6], 12, true);
            _gfx.play("pointer");
            _gfx.centerOrigin();
            graphic = _gfx;
        }
        
        public function pointer():void {
            _gfx.play("pointer");
        }
        
        public function move():void {
            _gfx.play("move");
        }
        
        public function attack():void {
            _gfx.play("attack");
        }
        
        override public function render():void {
            x = FP.camera.x + FP.screen.mouseX;
            y = FP.camera.y + FP.screen.mouseY;
            super.render();
        }
    }
}