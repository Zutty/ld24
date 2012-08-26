package uk.co.zutty.ld24
{
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.utils.Input;
    
    public class Cursor extends Entity {
        
        [Embed(source = 'assets/cursor.png')]
        public static const CURSOR_IMAGE:Class;
        
        private var _gfx:Spritemap;
        
        public function Cursor() {
            super();
            
            _gfx = new Spritemap(CURSOR_IMAGE, 16, 16);
            _gfx.add("pointer", [0], 0, false);
            _gfx.add("move", [1,2,3], 12, true);
            _gfx.add("attack", [4,5,6], 12, true);
            _gfx.add("up", [7], 0, false);
            _gfx.add("down", [9], 0, false);
            _gfx.add("left", [10], 0, false);
            _gfx.add("right", [8], 0, false);
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
        
        public function scrollUp():void {
            _gfx.play("up");
        }

        public function scrollDown():void {
            _gfx.play("down");
        }

        public function scrollLeft():void {
            _gfx.play("left");
        }

        public function scrollRight():void {
            _gfx.play("right");
        }

        override public function render():void {
            x = FP.camera.x + FP.clamp(FP.screen.mouseX, 8, FP.screen.width - 8);
            y = FP.camera.y + FP.clamp(FP.screen.mouseY, 8, FP.screen.height - 8);
            super.render();
        }
    }
}