package {
	import starling.events.Event;
	import starling.display.Sprite;
	import starling.core.Starling;

	import feathers.controls.Screen;
	import feathers.controls.Button;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.themes.MetalWorksMobileTheme;
	import feathers.events.FeathersEventType;
	import starling.utils.AssetManager;

	import flash.filesystem.File;
	import starling.display.Button;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.media.Video;

	public class Main extends Screen {
		private var assetMgr: AssetManager;
		private var playPauseButton: Button;
		private var videoStream: NetStream;
		private var video: Video;
		private var videoPlaying: Boolean;
		private var videoPaused: Boolean;
		private var potraitMode: Boolean;

		public function Main() {
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		private function initializeHandler(e: Event): void {
			this.removeEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			this.stage.addEventListener(Event.RESIZE, stageResized);

			assetMgr = new AssetManager;
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
			new MetalWorksMobileTheme();

			this.layout = new AnchorLayout();
			this.width = this.stage.stageWidth;
			this.height = this.stage.stageHeight;

			potraitMode = true;

			setupVideo();
			setupButton();
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
		private function setupButton() {
			playPauseButton = new Button();
			playPauseButton.label = "Play";

			var playPauseButtonLayout: AnchorLayoutData = new AnchorLayoutData();
			playPauseButtonLayout.left = 5;
			playPauseButtonLayout.right = 5;
			playPauseButtonLayout.bottom = 1;

			playPauseButton.layoutData = playPauseButtonLayout
			playPauseButton.addEventListener(Event.TRIGGERED, handlePlayPauseButtonClick);
			this.addChild(playPauseButton);
		}
		private function handlePlayPauseButtonClick(e: Event): void {
			if (!videoPlaying) {
				videoStream.play("video/marvel_avengers_2.mp4");
				playPauseButton.label = "Pause";
				videoPlaying = true;
				videoPaused = false;
			} else if (!videoPaused) {
				videoStream.togglePause();
				playPauseButton.label = "Play";
				videoPaused = true;
			} else {
				videoStream.togglePause();
				playPauseButton.label = "Pause";
				videoPaused = false;
			}
		}
		private function stageResized(e: Event): void {
			this.width = this.stage.stageWidth;
			this.height = this.stage.stageHeight;

			if (this.height > this.width) {
				this.potraitMode = true;
			} else {
				this.potraitMode = false;
			}

			positionVideo();
		}
		private function positionVideo() {
			if (video != null) {
				if (!potraitMode) {
					video.height = this.height - playPauseButton.height - 5 - 10;
					video.scaleX = video.scaleY;

					video.x = this.width - 10;
					video.y = 5;
				} else {
					video.width = this.width - 10;
					video.scaleY = video.scaleX;

					video.x = 5;
					video.y = 5;
				}
			}
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
