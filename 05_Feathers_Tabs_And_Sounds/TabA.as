package {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	import feathers.events.FeathersEventType;
	import feathers.controls.Panel;
	import feathers.controls.Button;

	public class TabA extends Panel {
		private var playButton:Button;
		private var stopButton:Button;
		private var theAssetsManager: AssetManager;
		private var currentSoundChannel:SoundChannel;

		public function TabA() {
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		public function setAssetManager(am: AssetManager): void {
			if (am is AssetManager) {
				this.theAssetsManager = am;
			}
		}
		private function initializeHandler(e: Event): void {
			this.removeEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			this.playButton = new Button();
			this.playButton.label = "Play";
			
			this.stopButton = new Button();
			this.stopButton.label = "Stop";
			
			this.playButton.addEventListener(Event.TRIGGERED, handlePlay);
			this.stopButton.addEventListener(Event.TRIGGERED, handleStop);

			this.addChild(this.playButton);
			this.addChild(this.stopButton);

			this.playButton.validate();
			this.stopButton.validate();

			this.playButton.x = (this.stage.stageWidth - this.playButton.width) / 2;
			this.playButton.y = (this.stage.stageHeight - this.playButton.height) / 2;
			
			this.stopButton.x = this.playButton.x;
			this.stopButton.y = this.playButton.y + (this.playButton.height/2) + 5 + (this.stopButton.height/2);
		}
		private function handlePlay(e: Event): void {
			trace("Play Clicked");
			currentSoundChannel = theAssetsManager.playSound("Sound1");
		}
		private function handleStop(e: Event): void {
			trace("Stop Clicked");
			if (currentSoundChannel != null) {
				currentSoundChannel.stop();
			}
		}

	}

}
