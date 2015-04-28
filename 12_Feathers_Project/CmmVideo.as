package {
	import flash.filesystem.File;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.media.Video;
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

	public class CmmVideo extends PanelScreen {
		private var contentPanel: Panel;
		private var buttonPanel: Panel;
		
		private var assetMgr: AssetManager;
		private var video: Video;
		private var videoStream: NetStream;
		private var currentSoundChannel: SoundChannel;

		private var backButton: Button;
		private var playPauseButton: Button;

		private var videoPlaying: Boolean;
		private var videoPaused: Boolean;
		private var potraitMode: Boolean;

		public function CmmVideo() {
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		private function initializeHandler(): void {
			this.removeEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			this.stage.addEventListener(Event.RESIZE, stageResized);
			this.addEventListener(Event.ADDED_TO_STAGE, screenAddedToStage);
			this.headerProperties.title = "Creative Multimedia Video";

			assetMgr = new AssetManager;
			assetMgr.verbose = true;
			var appDir: File = File.applicationDirectory;
			assetMgr.enqueue(appDir.resolvePath("assets/cmmAssets"));
			assetMgr.loadQueue(handleAssetsLoading);
		}
		private function screenAddedToStage(e: Event): void {
			setupVideo();
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

			potraitMode = true;

			setupButtonPanel();
			setupContentPanel();
			setupVideo();
		}
		private function setupButtonPanel() {
			this.buttonPanel = new Panel();
			var buttonPanelLayoutData: AnchorLayoutData = new AnchorLayoutData();
			buttonPanelLayoutData.left = 10;
			buttonPanelLayoutData.right = 10;
			buttonPanelLayoutData.bottom = 10;
			this.buttonPanel.layoutData = buttonPanelLayoutData;
			var buttonPanelLayout: HorizontalLayout = new HorizontalLayout();
			buttonPanelLayout.gap = 30;
			buttonPanelLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			this.buttonPanel.layout = buttonPanelLayout;
			this.addChild(this.buttonPanel);

			buttonPanelButtons();
		}
		private function buttonPanelButtons() {
			backButton = new Button();
			backButton.label = "Back";
			backButton.addEventListener(Event.TRIGGERED, handleBackButtonClick);
			this.buttonPanel.addChild(backButton);
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
		private function contentPanelContent() {
			var texture: Texture = this.assetMgr.getTexture("cmm");
			var cmmPic: Image = new Image(texture);
			cmmPic.width = 150;
			cmmPic.height = 150;
			this.contentPanel.addChild(cmmPic);

			playPauseButton = new Button();
			playPauseButton.label = "Play";
			var playPauseButtonLayout: AnchorLayoutData = new AnchorLayoutData();
			playPauseButtonLayout.left = 5;
			playPauseButtonLayout.right = 5;
			playPauseButton.layoutData = playPauseButtonLayout
			playPauseButton.addEventListener(Event.TRIGGERED, handlePlayPauseButtonClick);
			this.contentPanel.addChild(playPauseButton);
		}
		private function setupVideo() {
			var nc: NetConnection = new NetConnection();
			nc.connect(null);
			videoStream = new NetStream(nc);
			videoStream.client = this;
			video = new Video();
			Starling.current.nativeStage.addChild(video);
			video.attachNetStream(videoStream);
			videoPlaying = false;

			positionVideo();
		}
		private function stageResized(e: Event): void {
			this.height = this.stage.stageHeight;
			this.width = this.stage.stageWidth;

			if (this.height > this.width) {
				this.potraitMode = true;
			} else {
				this.potraitMode = false;
			}

			positionVideo();
		}
		private function handlePlayPauseButtonClick(e: Event): void {
			if (!videoPlaying) {
				videoStream.play("assets/cmmAssets/videos/cmm_video.mp4");
				currentSoundChannel = assetMgr.playSound("daClick");
				playPauseButton.label = "Pause";
				videoPlaying = true;
				videoPaused = false;
			} else if (!videoPaused) {
				videoStream.togglePause();
				playPauseButton.label = "Play";
				currentSoundChannel = assetMgr.playSound("daClick");
				videoPaused = true;
			} else {
				videoStream.togglePause();
				currentSoundChannel = assetMgr.playSound("daClick");
				playPauseButton.label = "Pause";
				videoPaused = false;
			}
		}
		private function positionVideo() {
			if (video != null) {
				if (!potraitMode) {
					video.height = this.height - contentPanel.height - 5 - 10;
					video.scaleX = video.scaleY;

					video.x = this.width - 10;
					video.y = 5;
				} else {
					video.width = this.width - 20;
					video.scaleY = video.scaleX;

					video.x = 10;
					video.y = 40;
				}
			}
		}
		private function handleBackButtonClick(e: Event): void {
			this.dispatchEventWith("showCmm");
			currentSoundChannel = assetMgr.playSound("daClick");
			removeVideo();
		}
		private function removeVideo() {
			videoStream.close();
			videoPlaying = false;
			Starling.current.nativeStage.removeChild(video);
			playPauseButton.label = "Play";
		}
		public function onMetaData(infoObject: Object) {
			trace("onMetaData invoked...");
		}
		public function onXMPData(infoObject: Object) {
			trace("onXMPData invoked...");
		}
		public function onCuePoint(infoObject: Object) {
			trace("onCuePoint invoked...");
		}

	}

}