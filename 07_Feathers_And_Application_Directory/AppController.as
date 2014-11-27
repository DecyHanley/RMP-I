package {
	import flash.filesystem.File;
	
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import starling.events.Event;
	import starling.display.Button;
	
	import feathers.themes.MetalWorksMobileTheme;
	import feathers.events.FeathersEventType;
	import feathers.controls.Screen;
	
	public class AppController extends Screen {
		private var assetMgr: AssetManager;
		private var theButton: Button;

		public function AppController() {
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, loadAssets);
		}
		private function loadAssets(e: Event): void {
			var appDir: File = File.applicationDirectory;
			assetMgr = new AssetManager();
			assetMgr.verbose = true;
			assetMgr.enqueue(appDir.resolvePath("assets"));
			assetMgr.loadQueue(onAssetsLoading);
		}
		private function onAssetsLoading(ratioLoaded: Number): void {
			if (ratioLoaded == 1) {
				startApp();
			}
		}
		private function startApp() {
			new MetalWorksMobileTheme();

			theButton = new Button(this.assetMgr.getTexture("Mario"), "", this.assetMgr.getTexture("Luigi"));
			theButton.width = 100;
			theButton.height = 100;
			this.addChild(theButton);
			theButton.addEventListener(Event.TRIGGERED, onTheButtonTiggered);
		}
		private function onTheButtonTiggered(e: Event) {
			trace("The Button has been Triggered");
		}

	}

}
