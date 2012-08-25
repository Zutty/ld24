package uk.co.zutty.ld24
{
    import net.flashpunk.Entity;
    import net.flashpunk.World;
    import net.flashpunk.utils.Input;
    
    public class GameWorld extends World {
        
        private var _creatures:Supplier = Supplier.newSupplier(32, function():Suppliable { return new Creature(); });
        private var _robots:Supplier = Supplier.newSupplier(32, function():Suppliable { return new Robot(); });
        private var _markers:Supplier = Supplier.newSupplier(4, function():Suppliable { return new Marker(); });
        
        private var _selection:Vector.<Mob>;
        
        private var _pointer:Pointer;

        public function GameWorld() {
            super();
            
            Supplier.initAll();
            
            _creatures.addAll(this);
            _robots.addAll(this);
            _markers.addAll(this);
            
            _creatures.spawnNext(20, 20);
            _robots.spawnNext(100, 20);
            
            _pointer = new Pointer();
            add(_pointer);
            
            _selection = new Vector.<Mob>();
            reset();
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
        
        override public function update():void {
            super.update();

            var hover:Mob = collidePoint("mob", mouseX, mouseY) as Mob;
            
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
                if(hover != null) {
                    if(hover.faction == Mob.FACTION_FRIENDLY) {
                        deselectAll();
                        select(hover);
                    }
                } else {
                    if(_selection.length > 0) {
                        _markers.spawnNext(mouseX, mouseY);
                        for each(var mob:Mob in _selection) {
                            mob.goTo(mouseX, mouseY);
                        }
                    }
                }
            }
        }
    }
}