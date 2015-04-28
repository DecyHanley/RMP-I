package {
	import flash.filesystem.File;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	import starling.events.Event;
	import starling.core.Starling;
	import starling.utils.AssetManager;
	import starling.textures.Texture;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;

	import feathers.themes.MetalWorksMobileTheme;
	import feathers.controls.PanelScreen;
	import feathers.controls.Panel;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.events.FeathersEventType;
	import feathers.controls.ScrollContainer;
	import feathers.controls.ScrollText;
	import feathers.controls.Button;
	import feathers.controls.Label;

	public class CmmImages extends PanelScreen {
		private const ENDPOINT_URL: String = "http://decyhanley.github.io/";
		private var assetMgr: AssetManager;
		private var slideshowXML: XML;
		private var activeSlideImage: Image = null;
		private var currentSlideIndex: uint = 0;
		private var numSlides: uint;

		private var contentPanel: Panel;
		private var buttonPanel: Panel;

		private var homeButton: Button;
		private var currentSoundChannel: SoundChannel;

		public function CmmImages() {
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		private function initializeHandler(e: starling.events.Event): void {
			this.removeEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			loadSlideShowXML();
		}
		private function loadSlideShowXML() {
			var theURL: URLRequest = new URLRequest(this.ENDPOINT_URL + "01_RMP_I/01_Class_Apps/10_Feathers_And_XML/assets/xml/slideshow.xml");
			var loader: URLLoader = new URLLoader();
			loader.addEventListener(flash.events.Event.COMPLETE, slideShowXMLLoaded);
			loader.load(theURL);
		}
		private function slideShowXMLLoaded(e: flash.events.Event): void {
			slideshowXML = new XML(e.target.data);
			assetMgr = new AssetManager();
			assetMgr.verbose = true;
			var slideList: XMLList = slideshowXML.slide;
			this.numSlides = slideList.length();
			for (var i: int = 0; i < this.numSlides; i++) {
				assetMgr.enqueue(this.ENDPOINT_URL + slideshowXML.@imagePath + slideList[i].@image);
				trace(this.ENDPOINT_URL + slideshowXML.@imagePath + slideList[i].@image);
			}
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
			this.headerProperties.title = "CMM Images";

			this.displaySlide();

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
			homeButton.label = "Home";
			homeButton.addEventListener(starling.events.Event.TRIGGERED, handleBackButtonClick);
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
		}
		private function displaySlide(slideIndex: uint = 0): void {
			if (this.activeSlideImage != null) {
				activeSlideImage.removeEventListener(starling.events.TouchEvent.TOUCH, handleNextSlide);
				this.removeChild(activeSlideImage);
			}
			var slideName: String = this.slideshowXML.slide[slideIndex].@image;
			var indexOfLastDot: int = slideName.lastIndexOf(".");
			slideName = slideName.substr(0, indexOfLastDot);
			activeSlideImage = new Image(this.assetMgr.getTexture(slideName));
			activeSlideImage.width = this.stage.stageWidth;
			activeSlideImage.scaleY = activeSlideImage.scaleX;
			activeSlideImage.addEventListener(starling.events.TouchEvent.TOUCH, handleNextSlide);
			this.addChild(activeSlideImage);
		}
		private function handleNextSlide(e: starling.events.TouchEvent): void {
			var touch: Touch = e.getTouch(this, TouchPhase.BEGAN);
			if (touch) {
				this.currentSlideIndex++;
				this.currentSlideIndex = this.currentSlideIndex % this.numSlides;
				this.displaySlide(this.currentSlideIndex);
			}
		}
		private function handleBackButtonClick(e: starling.events.Event): void {
			this.dispatchEventWith("showCmm");
			currentSoundChannel = assetMgr.playSound("daClick");
		}

	}

}