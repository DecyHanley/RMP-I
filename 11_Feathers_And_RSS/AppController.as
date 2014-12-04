package {
	import flash.filesystem.File;
	import flash.text.TextFormat;
	
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	import feathers.controls.PanelScreen;
	import feathers.layout.VerticalLayout;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.events.FeathersEventType;
	import feathers.controls.ScrollContainer;
	import feathers.controls.ScrollText;
	import feathers.themes.MetalWorksMobileTheme;

	public class AppController extends PanelScreen {
		private const RSS_FEED_URL: String = "http://feeds.breakingnews.ie/bntopstories?format=xml";
		private var assetMgr: AssetManager;
		private var rssFeed: XML;
		private var scrollTxt: ScrollText;
		
		public function AppController() {
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		private function initializeHandler(e: starling.events.Event): void {
			this.removeEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			this.stage.addEventListener(starling.events.Event.RESIZE, stageResized);
			loadAssets();
		}
		private function loadAssets(): void {
			assetMgr = new AssetManager();
			assetMgr.verbose = true;
			assetMgr.enqueue(RSS_FEED_URL);
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
			this.headerProperties.title = "Feathers and XML";
			this.layout = new AnchorLayout();
			var scrollTextLayout: AnchorLayoutData;
			scrollTextLayout = new AnchorLayoutData();
			scrollTextLayout.top = 2;
			scrollTextLayout.left = 5;
			scrollTextLayout.right = 5;
			scrollTextLayout.bottom = 2;
			this.scrollTxt = new ScrollText();
			this.scrollTxt.layoutData = scrollTextLayout;
			this.scrollTxt.isHTML = true;
			rssFeed = assetMgr.getXml("bntopstories");
			trace("RSS FEED IS" + rssFeed);
			for (var i: int = 0; i < (rssFeed..item).length(); i++) {
				this.scrollTxt.text += "<h2>" + rssFeed..item[i].title + "</h2><br>";
				this.scrollTxt.text += "<p>" + rssFeed..item[i].description + "</p><br>";
				trace(rssFeed..item[i].title);
				trace(rssFeed..item[i].description);
			}
			this.addChild(scrollTxt);
			this.scrollTxt.textFormat = new TextFormat("_sans", 14, 0xFFFFFF);
		}
		protected function stageResized(e: starling.events.Event): void {
			this.height = this.stage.stageHeight;
			this.width = this.stage.stageWidth;
		}
	}
}
