package {
	import flash.display.Sprite;
	import starling.core.Starling;
	import flash.events.Event;
	import flash.geom.Rectangle;

	public class FeathersPages extends Sprite {
		private var starling: Starling;

		public function FeathersPages() {
			starling = new Starling(Main, this.stage);
			this.starling.enableErrorChecking = true;
			starling.start();
		}

	}

}
