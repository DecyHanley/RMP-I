package {
	import feathers.controls.PanelScreen;
	import feathers.layout.VerticalLayout;
	import feathers.events.FeathersEventType;
	import feathers.controls.ScrollContainer;
	import feathers.controls.ScrollText;
	import feathers.controls.Button;
	import starling.events.Event;
	import Utils;
	import starling.display.Quad;

	public class ScreenA extends PanelScreen {

		public function ScreenA() {
			trace("An object of ScreenA has has created");
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		private function initializeHandler(): void {
			trace("ScreenA object initialized");
			this.removeEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			this.headerProperties.title = "ScreenA";
			var theLayout: VerticalLayout = new VerticalLayout();
			theLayout.gap = 10;
			theLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			theLayout.manageVisibility = true;
			this.layout = theLayout;
			this.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;
			this.snapScrollPositionsToPixels = true;
			for (var i: int = 0; i < 100; i++) {
				var size: Number = (44 + 88 * Math.random()) * this.dpiScale;
				var quad: Quad = new Quad(size, size, 0xff8800);
				this.addChild(quad);
			}
			var screenBButton: Button;
			screenBButton = new Button();
			screenBButton.label = "Screen B";
			this.addChild(screenBButton);
			screenBButton.addEventListener(Event.TRIGGERED, handlerScreenBButtonClick);
		}
		private function handlerScreenBButtonClick(e: Event): void {
			this.dispatchEventWith("showScreenB");
		}
	}
}
