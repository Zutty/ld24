package uk.co.zutty.ld24
{
    import net.flashpunk.Entity;
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    
    public class CloningVat extends Building {

        [Embed(source = 'assets/cloning_vat.png')]
        private static const CLONING_VAT_IMAGE:Class;

        public function CloningVat() {
            super(CLONING_VAT_IMAGE, 64, 64, 80);
            setHitbox(64, 32, 0, -32);
        }
    }
}