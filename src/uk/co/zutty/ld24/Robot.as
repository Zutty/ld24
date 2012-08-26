package uk.co.zutty.ld24
{
    import flash.geom.Point;

    public class Robot extends Mob {
        
        private static const PATROL_WAIT:uint = 40;

        [Embed(source = 'assets/robot2a.png')]
        public static const ROBOT_IMAGE:Class;
        
        private var _route:Route;
        private var _patrolTimer:uint;

        public function Robot() {
            super(ROBOT_IMAGE, 2, FACTION_ENEMY, STANCE_AGGRESSIVE, 0.3, 8);
        }
        
        override public function added():void {
            super.added();
            _patrolTimer = 0;
        }
        
        public function set route(r:Route):void {
            _route = r;
            x = r.first.x;
            y = r.first.y;
            goToPoint(_route.next);
        }
        
        override protected function onWaypoint(w:Point):void {
            if(w.equals(_route.current)) {
                _patrolTimer = PATROL_WAIT;
            } else {
                goToPoint(_route.current);
            }
        } 
        
        override public function update():void {
            super.update();
            
            if(_patrolTimer > 0) {
                --_patrolTimer;
                if(_patrolTimer == 0) {
                    goToPoint(_route.next);
                }
            }
        }
    }
}