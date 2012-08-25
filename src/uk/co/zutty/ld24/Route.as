package uk.co.zutty.ld24
{
    import flash.geom.Point;

    public class Route {
        
        private var _delegate:Vector.<Point>;
        private var _idx:int;
        
        public function Route() {
            _delegate = new Vector.<Point>();
        }
        
        public function addPoint(x:Number, y:Number):void {
            _delegate[_delegate.length] = new Point(x, y);
        }
        
        public function get first():Point {
            return _delegate[0];
        }
        
        public function get current():Point {
            return _delegate[_idx];
        }
        
        public function get next():Point {
            _idx = (_idx + 1) % _delegate.length;
            return _delegate[_idx];
        }
    }
}