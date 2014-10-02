package {
	import starling.display.Sprite;
	import starling.events.Event;
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	//import feathers.themes.AeonDesktopTheme;
	import feathers.themes.MetalWorksMobileTheme;
	//import feathers.themes.MinimalMobileTheme;
	import starling.display.Button;
	public class Main extends Sprite {
		private var button: Button;
		public function Main() {
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		private function addedToStageHandler(event: Event): void {
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			//new AeonDesktopTheme();
			new MetalWorksMobileTheme();
			//new MinimalMobileTheme();
			this.button = new Button();
			this.button.label = "Click Me";
			this.button.addEventListener(Event.TRIGGERED, button_TriggeredHandler);
			this.addChild(this.button);
			this.button.validate();
			this.button.x = (this.stage.stageWidth - this.button.width) / 2;
			this.button.y = (this.stage.stageHeight - this.button.height) / 2;
		}
		private function button_TriggeredHandler(event: Event): void {
			var label: Label = new Label();
			label.text = "Hi, I'm Feathers!\nHave a Nice Day.";
			Callout.show(label, this.button);
		}
	}
}