package {
	import flash.filesystem.File;
	
	import starling.events.Event;
	import starling.display.Sprite;
	import starling.core.Starling;
	import starling.utils.AssetManager;
	import starling.animation.Transitions;

	import feathers.controls.Screen;
	import feathers.controls.Button;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.themes.MetalWorksMobileTheme;
	import feathers.events.FeathersEventType;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

	public class AppController extends Sprite {
		private var assetMgr: AssetManager;
		private var screenNavigator: ScreenNavigator;
		private var transitionMgr: ScreenSlidingStackTransitionManager;

		public function AppController() {
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, initializeHandler);
		}
		private function initializeHandler(e: Event): void {
			this.removeEventListener(Event.ADDED_TO_STAGE, initializeHandler);
			this.stage.addEventListener(Event.RESIZE, stageResized);

			assetMgr = new AssetManager();
			assetMgr.verbose = true;
			var appDir: File = File.applicationDirectory;
			assetMgr.enqueue(appDir.resolvePath("assets"));
			assetMgr.loadQueue(handleAssetsLoading);
		}
		private function handleAssetsLoading(ratioLoaded: Number): void {
			trace("handleAssetsLoading: " + ratioLoaded);

			if (ratioLoaded == 1) {
				startApp();
			}
		}
		private function startApp() {
			this.height = this.stage.stageHeight;
			this.width = this.stage.stageWidth;

			new MetalWorksMobileTheme();

			this.screenNavigator = new ScreenNavigator();
			var screenANavItem: ScreenNavigatorItem = new ScreenNavigatorItem(new ScreenA(), {
				"showScreenB": "screenB"
			});
			var screenBNavItem: ScreenNavigatorItem = new ScreenNavigatorItem(new ScreenB(), {
				"showScreenA": "screenA"
			});
			this.screenNavigator.addScreen("screenA", screenANavItem);
			this.screenNavigator.addScreen("screenB", screenBNavItem);
			this.transitionMgr = new ScreenSlidingStackTransitionManager(this.screenNavigator);
			this.transitionMgr.duration = 5;
			this.transitionMgr.ease = Transitions.EASE_IN_ELASTIC;
			this.addChild(this.screenNavigator);
			this.screenNavigator.showScreen("screenA");
		}
		private function stageResized(e: Event): void {
			this.height = this.stage.stageHeight;
			this.width = this.stage.stageWidth;
		}

	}

}
