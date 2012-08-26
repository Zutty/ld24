package uk.co.zutty.ld24
{
    public class CatcherVan extends Mob {
        
        [Embed(source = 'assets/catchervan.png')]
        public static const VAN_IMAGE:Class;

        public function CatcherVan() {
            super(VAN_IMAGE, 3, FACTION_FRIENDLY, 0.6, 4);
        }
    }
}