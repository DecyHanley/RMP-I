package {
	import flash.filesystem.File;
	import flash.text.TextFormat;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import starling.events.Event;
	import starling.core.Starling;
	import starling.textures.Texture;
	import starling.display.Sprite;
	import starling.display.Image;
	
	import feathers.controls.PanelScreen;
	import feathers.controls.Panel;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.events.FeathersEventType;
	import starling.utils.AssetManager;
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import starling.display.Button;
	import feathers.controls.ScrollContainer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.controls.ScrollText;
	
	public class Dap extends PanelScreen {
		private var contentPanel: Panel;
		private var buttonPanel: Panel;
		
		private var assetMgr: AssetManager;
		private var scrollTxt: ScrollText;
		private var currentSoundChannel: SoundChannel;
		
		private var infoButton: Button;
		//private var imagesButton: Button;
		private var videoButton:Button;
		private var homeButton: Button;

		public function Dap() {
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		private function initializeHandler(): void {
			this.removeEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			this.headerProperties.title = "B.Sc(Hons) Digital Animation Production";
			
			assetMgr = new AssetManager;
			assetMgr.verbose = true;
			var appDir: File = File.applicationDirectory;
			assetMgr.enqueue(appDir.resolvePath("assets/dapAssets"));
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
			buttonPanelLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			this.buttonPanel.layout = buttonPanelLayout;
			this.addChild(this.buttonPanel);

			buttonPanelButtons();
		}
		private function buttonPanelButtons() {
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
			contentPanelLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			contentPanelLayout.gap = 30;
			this.contentPanel.layout = contentPanelLayout;
			this.addChild(this.contentPanel);

			contentPanelContent();
		}
		private function contentPanelContent() {
			var texture:Texture = this.assetMgr.getTexture("dap");
			var dapPic:Image = new Image(texture);
			dapPic.width = 100;
			dapPic.height = 100;
			this.contentPanel.addChild(dapPic);
			
			infoButton = new Button();
			infoButton.label = "Infromation";
			infoButton.addEventListener(Event.TRIGGERED, handleInfoButtonClick);
			this.contentPanel.addChild(infoButton);
			
			/*imagesButton = new Button();
			imagesButton.label = "Images";
			imagesButton.addEventListener(Event.TRIGGERED, handleImagesButtonClick);
			this.contentPanel.addChild(imagesButton);*/
			
			videoButton = new Button();
			videoButton.label = "Video";
			videoButton.addEventListener(Event.TRIGGERED, handleVideoButtonClick);
			this.contentPanel.addChild(videoButton);
		}
		private function handleInfoButtonClick(e: Event): void {
			this.dispatchEventWith("showDapInfo");
			currentSoundChannel = assetMgr.playSound("daClick");
		}
		/*private function handleImagesButtonClick(e: Event): void {
			this.dispatchEventWith("showDapImages");
			currentSoundChannel = assetMgr.playSound("daClick");
		}*/
		private function handleVideoButtonClick(e: Event): void {
			this.dispatchEventWith("showDapVideo");
			currentSoundChannel = assetMgr.playSound("daClick");
		}
		private function handleHomeButtonClick(e: Event): void {
			this.dispatchEventWith("showHome");
			currentSoundChannel = assetMgr.playSound("daClick");
		}

	}

}
