package {
	import flash.display.Sprite;
	
	import starling.core.Starling;
	
	public class FeathersDC extends Sprite {
		private var starling: Starling;

		public function FeathersDC() {
			starling = new Starling(AppController, this.stage);
			starling.start();
		}
		
	}
	
}
