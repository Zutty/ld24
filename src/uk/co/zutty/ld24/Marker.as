package uk.co.zutty.ld24
{
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    import net.flashpunk.graphics.Spritemap;
    
    public class Marker extends Suppliable {
        
        [Embed(source = 'assets/move_marker2.png')]
        private static const MOVE_MARKER_IMAGE:Class;
        
        private var _gfx:Spritemap;
        
        public function Marker() {
            super();
            
            _gfx = new Spritemap(MOVE_MARKER_IMAGE, 16, 16);
            _gfx.add("anim", [0,1,2,3,4], 30, false);
            _gfx.centerOrigin();
            _gfx.callback = despawn;
            graphic = _gfx;
        }
        
        override public function spawn(x:Number, y:Number):void {
            super.spawn(x, y);
            _gfx.play("anim", true);
        }
        
        override public function despawn():void {
            super.despawn();
        }
    }
}