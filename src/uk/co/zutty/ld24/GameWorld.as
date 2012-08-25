package uk.co.zutty.ld24
{
    import flash.geom.Point;
    
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.utils.Input;
    
    public class GameWorld extends World {
        
        private static const SCROLL_MARGIN:Number = 8;
        
        private var _marker:Marker;
        
        private var _selection:Vector.<Mob>;
        
        private var _pointer:Pointer;
        private var _level:OgmoLevel;
        private var _ground:Layer;
        private var _water:Layer;

        public function GameWorld() {
            super();
            
            _marker = new Marker();
            
            loadLevel(new Level1());
            
            _pointer = new Pointer();
            add(_pointer);
            
            _selection = new Vector.<Mob>();
            reset();
        }
        
        private function loadLevel(lvl:OgmoLevel):void {
            _level = lvl;
            _ground = lvl.getLayer("ground");
            add(_ground);
            _water = lvl.getLayer("water");
            add(_water);
            
            var p:Point;
            for each(p in _level.getObjectPositions("objects", "tree")) {
                add(new Tree(p.x, p.y));
            }
            for each(p in _level.getObjectPositions("objects", "base")) {
                add(new Base(p.x, p.y));
            }
            
            var spawnPoint:Point = _level.getObjectPositions("objects", "spawn")[0];
            scrollx = spawnPoint.x - FP.screen.width / 2;
            scrolly = spawnPoint.y - FP.screen.height / 2;

            for each(var route:Route in _level.getObjectRoutes("objects", "robot")) {
                var robot:Robot = create(Robot) as Robot;
                robot.route = route;
            }
        }
        
        public function reset():void {
            _selection.length = 0;
        }
        
        public function deselectAll():void {
            for each(var mob:Mob in _selection) {
                mob.selected = false;
            }
            _selection.length = 0;
        }
        
        public function select(mob:Mob):void {
            mob.selected = true;
            _selection[_selection.length] = mob;
        }
        
        public function set scrollx(x:Number):void {
            camera.x = FP.clamp(x, 0, _level.width - FP.screen.width);
        }
        
        public function set scrolly(y:Number):void {
            camera.y = FP.clamp(y, 0, _level.height - FP.screen.height);
        }

        override public function update():void {
            super.update();

            var hover:Mob = collidePoint("mob", mouseX, mouseY) as Mob;
            
            // Scrolling
            if(Input.mouseX <= SCROLL_MARGIN) {
                scrollx = camera.x - 1;
            } else if(Input.mouseX >= FP.screen.width - SCROLL_MARGIN) {
                scrollx = camera.x + 1;
            }
            
            FP.console.log(Input.mouseY);
            if(Input.mouseY <= SCROLL_MARGIN) {
                scrolly = camera.y - 1;
            } else if(Input.mouseY >= FP.screen.height - SCROLL_MARGIN) {
                scrolly = camera.y + 1;
            }
            
            if(_selection.length > 0) {
                if(hover && hover.faction == Mob.FACTION_ENEMY) {
                    _pointer.attack();
                } else if(hover && hover.faction == Mob.FACTION_FRIENDLY) {
                    _pointer.pointer();
                } else if(!hover) {
                    _pointer.move();
                }
            } else {
                _pointer.pointer();
            }
            
            if(Input.mousePressed) {
                if(hover != null && hover.faction == Mob.FACTION_FRIENDLY) {
                    deselectAll();
                    select(hover);
                } else if(_selection.length > 0) {
                    _marker.markPoint(mouseX, mouseY);
                    for each(var mob:Mob in _selection) {
                        mob.goTo(mouseX, mouseY);
                    }
                }
            }
        }
    }
}