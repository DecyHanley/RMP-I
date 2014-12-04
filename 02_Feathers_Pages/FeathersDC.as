package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	
	public class FeathersDC extends Sprite {
		private var starling: Starling;

		public function FeathersDC() {
			starling = new Starling(AppController, this.stage);
			this.starling.enableErrorChecking = true;
			starling.start();
		}

	}

}
