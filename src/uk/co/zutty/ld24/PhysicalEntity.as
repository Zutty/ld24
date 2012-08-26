package uk.co.zutty.ld24
{
    import net.flashpunk.Entity;
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    
    public class PhysicalEntity extends Entity {
        
        protected var sprHeight:Number;
        
        public function PhysicalEntity(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) {
            super(x, y, graphic, mask);
        }
        
        override public function render():void {
            layer = -y - sprHeight;
            super.render();
        }
    }
}