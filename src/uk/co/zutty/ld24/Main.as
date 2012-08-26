package uk.co.zutty.ld24
{
    import flash.ui.Mouse;
    
    import net.flashpunk.Engine;
    import net.flashpunk.FP;
    import net.flashpunk.utils.Input;
    
    public class Main extends Engine {
        public function Main() {
            super(200, 150, 60, false);

            Mouse.hide();

            FP.screen.scale = 4;
            FP.console.enable();
            FP.console.debug = true;
            
            FP.world = new GameWorld();
        }
    }
}