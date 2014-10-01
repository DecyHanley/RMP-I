package {
	import feathers.themes.MetalWorksMobileTheme;
	import feathers.events.FeathersEventType;
	import feathers.controls.Drawers;
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.ScrollContainer;
	import starling.display.Sprite;
	import starling.events.Event;
	public class Main extends ScreenNavigator {
		public function Main() {
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		protected function initializeHandler(e: Event): void {
			this.removeEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			new MetalWorksMobileTheme();
			var screenA: ScreenA = new ScreenA();
			var screenNavItem1: ScreenNavigatorItem = new ScreenNavigatorItem(screenA, {
				"showScreenB": "screenB"
			});
			this.addScreen("screenA", screenNavItem1);
			var screenB: ScreenB = new ScreenB();
			var screenNavItem2: ScreenNavigatorItem = new ScreenNavigatorItem(screenB, {
				"showScreenA": "screenA"
			});
			this.addScreen("screenB", screenNavItem2);
			this.showScreen("screenA");
		}
	}
}