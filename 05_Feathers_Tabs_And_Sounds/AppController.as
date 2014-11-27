package {
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	import feathers.themes.MetalWorksMobileTheme;
	import feathers.events.FeathersEventType;
	import feathers.controls.Screen;
	import feathers.controls.Panel;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.controls.TabBar;
	import feathers.data.ListCollection;

	public class AppController extends Screen {
		private var tabA: TabA;
		private var contentPanel: Panel;
		private var contentPanelLayoutData: AnchorLayoutData;
		private var tabBar: TabBar;
		private var tabsLayoutData: AnchorLayoutData;
		private var assetMgr: AssetManager;

		public function AppController() {
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		private function initializeHandler(e: Event): void {
			this.removeEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			assetMgr = new AssetManager();
			assetMgr.verbose = true;
			assetMgr.enqueue(EmbeddedAssets);
			assetMgr.loadQueue(handleAssetsLoading);
		}
		private function handleAssetsLoading(ratioLoaded: Number): void {
			trace("handleAssetsLoading: " + ratioLoaded);
			if (ratioLoaded == 1) {
				startApp();
			}
		}
		private function startApp() {
			new MetalWorksMobileTheme();

			this.layout = new AnchorLayout();
			this.height = this.stage.stageHeight;
			this.width = this.stage.stageWidth;

			tabBar = new TabBar();
			tabBar.dataProvider = new ListCollection([
				{
					label: "One"
				},
				{
					label: "Two"
				},
				{
					label: "Three"
				},
			]);
			tabBar.selectedIndex = 1;
			tabBar.addEventListener(Event.CHANGE, tabs_changeHandler);

			tabsLayoutData = new AnchorLayoutData();
			tabsLayoutData.bottom = 5;
			tabsLayoutData.left = 5;
			tabsLayoutData.right = 5;
			tabBar.layoutData = tabsLayoutData;
			this.addChild(tabBar);

			contentPanelLayoutData = new AnchorLayoutData();
			contentPanelLayoutData.top = 5;
			contentPanelLayoutData.left = 5;
			contentPanelLayoutData.right = 5;
			contentPanelLayoutData.bottom = 1;
			contentPanelLayoutData.bottomAnchorDisplayObject = tabBar;
				
			tabA = new TabA();
			tabA.layoutData = contentPanelLayoutData;
			tabA.setAssetManager(assetMgr);
			this.contentPanel = tabA;
			this.addChild(contentPanel);
		}
		private function tabs_changeHandler(e: Event): void {
			trace("selectedIndex: ", tabBar.selectedIndex);
		}
		
	}
	
}
