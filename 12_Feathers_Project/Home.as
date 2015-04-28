package {
	import flash.filesystem.File;
	import flash.media.Sound;
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

	public class Home extends PanelScreen {
		private var contentPanel: Panel;
		private var buttonPanel: Panel;
		
		private var assetMgr: AssetManager;
		private var currentSoundChannel:SoundChannel;
		
		private var cmmButton: Button;
		private var dapButton: Button;
		private var gadButton: Button;
		private var settingsButton: Button;
		
		public function Home() {
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		private function initializeHandler(): void {
			this.removeEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			this.headerProperties.title = "L.S.A.D Clonmel Courses Hub";
			
			assetMgr = new AssetManager;
			assetMgr.verbose = true;
			var appDir: File = File.applicationDirectory;
			assetMgr.enqueue(appDir.resolvePath("assets/homeAssets"));
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

			this.height = this.stage.stageHeight;
			this.width = this.stage.stageWidth;

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
			settingsButton = new Button();
			settingsButton.label = "Settings";
			settingsButton.addEventListener(Event.TRIGGERED, handleSettingsButtonClick);
			this.buttonPanel.addChild(settingsButton);
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
			contentPanelLayout.gap = 100;
			contentPanelLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			this.contentPanel.layout = contentPanelLayout;
			this.addChild(this.contentPanel);

			contentPanelContent();
		}
		private function contentPanelContent() {
			cmmButton = new Button();
			cmmButton.label = "Creative Mutltimedia";
			cmmButton.addEventListener(Event.TRIGGERED, handleCmmButtonClick);
			this.contentPanel.addChild(cmmButton);

			dapButton = new Button();
			dapButton.label = "Digital Animation Production";
			dapButton.addEventListener(Event.TRIGGERED, handleDapButtonClick);
			this.contentPanel.addChild(dapButton);

			gadButton = new Button();
			gadButton.label = "Game Art + Design";
			gadButton.addEventListener(Event.TRIGGERED, handleGadButtonClick);
			this.contentPanel.addChild(gadButton);
		}
		private function handleCmmButtonClick(e: Event): void {
			this.dispatchEventWith("showCmm");
			currentSoundChannel = assetMgr.playSound("daClick");
		}
		private function handleDapButtonClick(e: Event): void {
			this.dispatchEventWith("showDap");
			currentSoundChannel = assetMgr.playSound("daClick");
		}
		private function handleGadButtonClick(e: Event): void {
			this.dispatchEventWith("showGad");
			currentSoundChannel = assetMgr.playSound("daClick");
		}
		private function handleSettingsButtonClick(e: Event): void {
			this.dispatchEventWith("showSettings");
			currentSoundChannel = assetMgr.playSound("daClick");
		}

	}

}
