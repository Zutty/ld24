package uk.co.zutty.ld24
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Emitter;
	
	public class Level1 extends OgmoLevel {
		
		[Embed(source = 'assets/level1.oel', mimeType = 'application/octet-stream')]
		private const LEVEL1_OEL:Class;

		[Embed(source = 'assets/ground_tiles2.png')]
		private const GROUND_IMAGE:Class;

		[Embed(source = 'assets/water_tiles.png')]
		private const WATER_IMAGE:Class;

		public function Level1() {
			super(LEVEL1_OEL, {ground: GROUND_IMAGE, water:WATER_IMAGE}, 16, 16);
		}
	}
}