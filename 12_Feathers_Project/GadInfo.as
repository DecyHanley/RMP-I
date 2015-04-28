package {
	import flash.filesystem.File;
	import flash.text.TextFormat;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	import starling.events.Event;
	import starling.core.Starling;
	import starling.utils.AssetManager;
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
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.ScrollContainer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.controls.ScrollText;

	public class GadInfo extends PanelScreen {
		private var contentPanel: Panel;
		private var buttonPanel: Panel;

		private var assetMgr: AssetManager;
		private var scrollTxt: ScrollText;
		private var currentSoundChannel: SoundChannel;

		private var homeButton: Button;

		public function GadInfo() {
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		private function initializeHandler(): void {
			this.removeEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			this.headerProperties.title = "Game Art + Design Information";

			assetMgr = new AssetManager;
			assetMgr.verbose = true;
			var appDir: File = File.applicationDirectory;
			assetMgr.enqueue(appDir.resolvePath("assets/gadAssets"));
			assetMgr.loadQueue(handleAssetsLoading);
		}
		private function handleAssetsLoading(ratioLoaded: Number): void {
			trace("handleAssetsLoading: " + ratioLoaded);
			if (ratioLoaded == 1) {
				startPage();
			}
		}
		private function startPage() {
			var screenLayout: AnchorLayout = new AnchorLayout();
			this.layout = screenLayout;

			setupButtonPanel();
			setupContentPanel();
		}
		private function setupButtonPanel() {
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
			homeButton.label = "Back";
			homeButton.addEventListener(Event.TRIGGERED, handleBackButtonClick);
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
			contentPanelLayout.gap = 10;
			contentPanelLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			this.contentPanel.layout = contentPanelLayout;
			this.addChild(this.contentPanel);

			contentPanelContent();
		}
		private function contentPanelContent() {
			var texture: Texture = this.assetMgr.getTexture("gad");
			var gadPic: Image = new Image(texture);
			gadPic.width = 100;
			gadPic.height = 100;
			this.contentPanel.addChild(gadPic);

			var gadXML: XML = this.assetMgr.getXml("gadInfo");
			this.scrollTxt = new ScrollText();
			this.scrollTxt.text = gadXML.info;
			this.contentPanel.addChild(this.scrollTxt);
			this.scrollTxt.textFormat = new TextFormat("Helvetica", 12, 0xFFFFFF, null, null, null, null, null, "center");
		}
		private function handleBackButtonClick(e: Event): void {
			this.dispatchEventWith("showGad");
			currentSoundChannel = assetMgr.playSound("daClick");
		}

	}

}
