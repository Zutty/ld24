package uk.co.zutty.ld24
{
    import net.flashpunk.Engine;
    import net.flashpunk.FP;
    
    public class Main extends Engine {
        public function Main() {
            super(160, 120, 60, false);
            FP.screen.scale = 4;
            //FP.console.enable();
            //FP.console.debug = true;
            
            //FP.world = new TitleWorld();
        }
    }
}