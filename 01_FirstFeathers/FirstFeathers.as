package {
	import flash.display.Sprite;
	import starling.core.Starling;
	
	public class FirstFeathers extends Sprite {
		private var _starling: Starling;
		
		public function FirstFeathers() {
			_starling = new Starling(Main, this.stage);
			_starling.start();
		}
	}
}