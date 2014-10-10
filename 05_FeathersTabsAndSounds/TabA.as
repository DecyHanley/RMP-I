package {
	import feathers.controls.Panel;
	import feathers.contols.Button;
	import feathers.events.FeathersEventType;

	import starling.events.Event;

	import flash.media.Sound;
	import flash.media.SoundChannel;
	import starling.utils.AssetManager;

	public class TabA extends Panel {
		private var button: Button;
		private var theAssetsManager: AssetsManager;

		public function TabA() {
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		public function setAssetMananger(am: AssetManager): void {
			if (am is AssetManager) {
				this.theAssetManager = am;
			}
		}
		private function initilizeHandler(e: Event): void {
			this.button = new Button();
			this.button.label = "Play Me";

			this.button.addEventListener(Event.Triggered, button_triggeredHandler);

			this.addChild(this.button);

			this.button.validate();

			this.button.x = (this.stage.stageWidth - this.button.width) / 2;
			this.button.y = (this.stage.stageHeight - this.button.height) / 2;
		}
		private function button_triggeredHandler(e: Event): void {
			trace("Button Clicked");
			theAssetManager.playSound("");
		}
	}
}
