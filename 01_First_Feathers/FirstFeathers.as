package {
	import flash.display.Sprite;
	import starling.core.Starling;

	public class FirstFeathers extends Sprite {
		private var starling: Starling;

		public function FirstFeathers() {
			starling = new Starling(Main, this.stage);
			starling.start();
		}
		
	}
	
}
