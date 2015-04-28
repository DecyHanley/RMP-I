package {
	import flash.filesystem.File;
	import flash.media.SoundChannel;
	
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	import feathers.controls.PanelScreen;
	import feathers.controls.Panel;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.events.FeathersEventType;
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;

	public class Settings extends PanelScreen {
		private var contentPanel: Panel;
		private var buttonPanel: Panel;
		
		private var assetMgr: AssetManager;
		private var currentSoundChannel: SoundChannel;
		
		private var infoButton: Button;
		private var downloadButton: Button;
		private var homeButton: Button;

		public function Settings() {
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		private function initializeHandler(): void {
			this.removeEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			this.headerProperties.title = "Settings";
			
			assetMgr = new AssetManager;
			assetMgr.verbose = true;
			var appDir: File = File.applicationDirectory;
			assetMgr.enqueue(appDir.resolvePath("assets/settingsAssets"));
			assetMgr.loadQueue(handleAssetsLoading);
		}
		private function handleAssetsLoading(ratioLoaded: Number): void {
			trace("handleAssetsLoading: " + ratioLoaded);
			if (ratioLoaded == 1) {
				startPage();
			}
		}
		private function startPage()	{
			var screenLayout: AnchorLayout = new AnchorLayout();
			this.layout = screenLayout;

			this.height = this.stage.stageHeight;
			this.width = this.stage.stageWidth;
			
			setupButtonPanel();
			setupContentPanel();
		}
		private function setupButtonPanel()	{
			this.buttonPanel = new Panel();
			var buttonPanelLayoutData: AnchorLayoutData = new AnchorLayoutData();
			buttonPanelLayoutData.left = 10;
			buttonPanelLayoutData.right = 10;
			buttonPanelLayoutData.bottom = 10;
			this.buttonPanel.layoutData = buttonPanelLayoutData;
			var buttonPanelLayout: HorizontalLayout = new HorizontalLayout();
			buttonPanelLayout.gap = 100;
			buttonPanelLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			this.buttonPanel.layout = buttonPanelLayout;
			this.addChild(this.buttonPanel);
			
			buttonPanelButtons();
		}
		private function buttonPanelButtons()	{
			homeButton = new Button();
			homeButton.label = "Home";
			homeButton.addEventListener(Event.TRIGGERED, handleHomeButtonClick);
			this.buttonPanel.addChild(homeButton);
		}
		private function setupContentPanel() {
			this.contentPanel = new Panel();
			var contentPanelLayoutData: AnchorLayoutData = new AnchorLayoutData();
			contentPanelLayoutData.top = 10;
			contentPanelLayoutData.bottom = 10;
			contentPanelLayoutData.left = 10;
			contentPanelLayoutData.right = 10;
			contentPanelLayoutData.bottomAnchorDisplayObject = this.buttonPanel;
			contentPanel.layoutData = contentPanelLayoutData;
			var contentPanelLayout: VerticalLayout = new VerticalLayout();
			contentPanelLayout.gap = 30;
			contentPanelLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			this.contentPanel.layout = contentPanelLayout;
			this.addChild(this.contentPanel);
			
			contentPanelContent();
		}
		private function contentPanelContent()	{
			infoButton = new Button();
			infoButton.label = "Release Notes...";
			infoButton.addEventListener(Event.TRIGGERED, handleInfoButtonClick);
			this.contentPanel.addChild(infoButton);
			
			downloadButton = new Button();
			downloadButton.label = "Download Latest XML...";
			downloadButton.addEventListener(Event.TRIGGERED, handleDownloadButtonClick);
			this.contentPanel.addChild(downloadButton);
		}		
		private function handleHomeButtonClick(e: Event): void {
			this.dispatchEventWith("showHome");
			currentSoundChannel = assetMgr.playSound("daClick");
		}
		private function handleInfoButtonClick(e: Event): void {
			//Add XML text Doc for this...
			currentSoundChannel = assetMgr.playSound("daClick");
		}
		private function handleDownloadButtonClick(e: Event): void {
			//Add XML Download function...
			currentSoundChannel = assetMgr.playSound("daClick");
		}
		
	}
	
}
