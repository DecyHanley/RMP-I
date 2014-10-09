package {
	import flash.display.Sprite;
	import starling.core.Starling;
	import flash.events.Event;
	import flash.geom.Rectangle;
	public class FeathersPages extends Sprite {
		protected var _starling: Starling;
		public function FeathersPages() {
			_starling = new Starling(Main, this.stage);
			this._starling.enableErrorChecking = true;
			_starling.start();
		}
	}
}