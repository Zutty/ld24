package uk.co.zutty.ld24
{
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    
    public class Creature extends Mob {
        
        [Embed(source = 'assets/rabbit.png')]
        public static const RABBIT_IMAGE:Class;
        
        public function Creature() {
            super(RABBIT_IMAGE, 2, FACTION_FRIENDLY, 1, 10);
        }
    }
}