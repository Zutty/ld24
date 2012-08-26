package uk.co.zutty.ld24
{
    import flash.geom.Point;
    
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;
    
    public class GameWorld extends World {
        
        private static const SCROLL_MARGIN:Number = 12;
        private static const SCROLL_SPEED:Number = 1.5;
        
        private var _marker:MoveMarker;
        
        private var _selection:Vector.<Mob>;
        
        private var _cursor:Cursor;
        private var _level:OgmoLevel;
        private var _ground:Layer;
        private var _water:Layer;
        
        private var _playerBase:Building;

        public function GameWorld() {
            super();
            
            _marker = new MoveMarker();
            add(_marker);
            
            loadLevel(new Level1());
            
            _cursor = new Cursor();
            add(_cursor);
            
            _selection = new Vector.<Mob>();
            reset();
        }
        
        private function buildUnit(builtFrom:Building):void {
            var mob:Mob = create(CatcherVan) as Mob;
            mob.x = builtFrom.x + 64;
            mob.y = builtFrom.y + 80;
        }
        
        private function buildBuilding(building:Building):void {
            add(new BuildMarker(building));
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

            var basePoint:Point = _level.getObjectPositions("objects", "base")[0];
            _playerBase = new Base();
            _playerBase.x = basePoint.x;
            _playerBase.y = basePoint.y; 
            add(_playerBase);
            
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
        
        public function deselect(mob:Mob):void {
            mob.selected = false;
            for(var idx:int = 0; idx < _selection.length; idx++) {
                if(_selection[idx] == mob) {
                    break;
                }
            }
            _selection.splice(idx, 1);
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

            var resetCursor:Boolean = true;
            
            // Mouse picking/orders
            var hover:Mob = collidePoint("mob", mouseX, mouseY) as Mob;
            if(_selection.length > 0) {
                if(hover && hover.faction == Mob.FACTION_ENEMY && _selection[0].stance == Mob.STANCE_AGGRESSIVE) {
                    _cursor.attack();
                    resetCursor = false;
                } else if(hover && hover.faction == Mob.FACTION_FRIENDLY) {
                    _cursor.pointer();
                    resetCursor = false;
                } else if(!hover) {
                    _cursor.move();
                    resetCursor = false;
                }
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
            
            // Scrolling
            if(FP.focused && Input.mouseX != 0 && Input.mouseY != 0) {
                if(Input.mouseX <= SCROLL_MARGIN) {
                    scrollx = camera.x - SCROLL_SPEED;
                    _cursor.scrollLeft();
                    resetCursor = false;
                } else if(Input.mouseX >= FP.screen.width - SCROLL_MARGIN) {
                    scrollx = camera.x + SCROLL_SPEED;
                    _cursor.scrollRight();
                    resetCursor = false;
                }
                if(Input.mouseY <= SCROLL_MARGIN) {
                    scrolly = camera.y - SCROLL_SPEED;
                    _cursor.scrollUp();
                    resetCursor = false;
                } else if(Input.mouseY >= FP.screen.height - SCROLL_MARGIN) {
                    scrolly = camera.y + SCROLL_SPEED;
                    _cursor.scrollDown();
                    resetCursor = false;
                }
            }

            // Reset the cursor
            if(resetCursor) {
                _cursor.pointer();
            }
            
            // Building
            if(Input.pressed(Key.SPACE)) {
                buildUnit(_playerBase);
            } else if(Input.pressed(Key.B)) {
                deselectAll();
                buildBuilding(create(CloningVat, false) as Building);
            }
        }
    }
}