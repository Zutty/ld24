package uk.co.zutty.ld24
{
    import net.flashpunk.Entity;
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    import net.flashpunk.graphics.Spritemap;
    
    public class Marker extends Entity {
        
        [Embed(source = 'assets/move_marker2.png')]
        private static const MOVE_MARKER_IMAGE:Class;
        
        private var _gfx:Spritemap;
        
        public function Marker() {
            super();
            
            _gfx = new Spritemap(MOVE_MARKER_IMAGE, 16, 16);
            _gfx.add("anim", [0,1,2,3,4], 30, false);
            _gfx.centerOrigin();
            _gfx.callback = hide;
            graphic = _gfx;
            hide();
            
            layer = -65535;
        }
        
        public function markPoint(x:Number, y:Number):void {
            this.x = x;
            this.y = y;
            visible = true;
            active = true;
            _gfx.play("anim", true);
        }
        
        public function hide():void {
            visible = false;
            active = false;
        }
    }
}