package {
	import feathers.controls.PanelScreen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.ScrollText;
	import feathers.layout.VerticalLayout;
	import feathers.events.FeathersEventType;
	import feathers.controls.Button;
	import Utils;
	import starling.events.Event;
	
	public class ScreenB extends PanelScreen {
		
		public function ScreenB() {
			trace("An object of ScreenB has been created");
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		protected function initializeHandler(): void {
			trace("ScreenB object initialized");
			this.removeEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			this.headerProperties.title = "ScreenB";
			
			var theLayout: VerticalLayout = new VerticalLayout();
			theLayout.gap = 10;
			theLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			this.layout = theLayout;
			this.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;
			this.snapScrollPositionsToPixels = true;
			
			var st1: ScrollText = new ScrollText();
			st1.text = Utils.LOREM_IPSUM;
			st1.height = 200;
			this.addChild(st1);
			
			var st2: ScrollText = new ScrollText();
			st2.text = Utils.LOREM_IPSUM;
			st2.height = 100;
			this.addChild(st2);
			
			var screenAButton: Button;
			screenAButton = new Button();
			screenAButton.label = "Screen A";
			this.addChild(screenAButton);
			screenAButton.addEventListener(Event.TRIGGERED, handleScreenAButtonClick);
		}
		protected function handleScreenAButtonClick(e: Event): void {
			this.dispatchEventWith("showScreenA");
		}
	}
}