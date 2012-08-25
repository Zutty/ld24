package uk.co.zutty.ld24
{
    import net.flashpunk.Entity;
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    import net.flashpunk.graphics.Image;
    
    public class Tree extends Entity {
        
        [Embed(source = 'assets/tree2.png')]
        private static const TREE_IMAGE:Class;

        public function Tree(x:Number, y:Number) {
            super(x, y, new Image(TREE_IMAGE));
            setHitbox(16, 16, -16, -32);
        }
    }
}