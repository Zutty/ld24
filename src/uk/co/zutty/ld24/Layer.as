package uk.co.zutty.ld24
{
    import net.flashpunk.Entity;
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    import net.flashpunk.graphics.Tilemap;
    import net.flashpunk.masks.Grid;
    
    public class Layer extends Entity {
        
        private var _tilemap:Tilemap;
        private var _grid:Grid;
        public var sad:Boolean = false;
        
        public function Layer(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) {
            super(x, y, graphic, mask);
            layer = 100;
        }
        
        public function get tilemap():Tilemap {
            return _tilemap;
        }
        
        public function set tilemap(t:Tilemap):void {
            _tilemap = t;
            graphic = _tilemap;
        }
        
        public function get grid():Grid {
            return _grid;
        }
        
        public function set grid(g:Grid):void {
            _grid = g;
            mask = _grid;
        }
    }
}