package uk.co.zutty.ld24
{
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.Graphic;
    import net.flashpunk.graphics.TiledSpritemap;
    import net.flashpunk.utils.Input;
    
    public class BuildMarker extends Entity {
        
        [Embed(source = 'assets/build_marker.png')]
        private static const BUILD_MARKER_IMAGE:Class;
        
        private var _gfx:TiledSpritemap;
        private var _building:Building;
        
        public function BuildMarker(building:Building) {
            super();
            
            _building = building;
            
            _gfx = new TiledSpritemap(BUILD_MARKER_IMAGE, 16, 16, building.width, building.height);
            _gfx.add("yes", [0], 0, false);
            _gfx.add("no", [1], 0, false);
            graphic = _gfx;
            
            setHitbox(building.width, building.height, 0, 0);
            
            layer = -65535;
        }
        
        override public function render():void {
            x = FP.camera.x + Input.mouseX;
            x -= x % 16;
            y = FP.camera.y + Input.mouseY;
            y -= y % 16;
            
            super.render();
        }
        
        override public function update():void {
            super.update();
            
            var clear:Boolean = collideTypes(["building", "terrain", "mob"], x, y) == null;
            
            _gfx.play(clear ? "yes" : "no");
            
            if(clear && Input.mousePressed) {
                _building.x = x + _building.originX;
                _building.y = y + _building.originY;
                FP.world.add(_building);
                FP.world.recycle(this);
            }
        } 
    }
}