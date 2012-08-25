package uk.co.zutty.ld24
{
    import net.flashpunk.Entity;
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    
    public class Base extends Building {

        [Embed(source = 'assets/baseanim.png')]
        private static const BASE_IMAGE:Class;

        public function Base(x:Number, y:Number) {
            super(BASE_IMAGE, 80, 64, 120, x, y);
            setHitbox(80, 32, 0, -32);
        }
    }
}