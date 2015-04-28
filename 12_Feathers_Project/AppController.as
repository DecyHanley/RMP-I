package {
	import starling.display.Sprite;
	import starling.events.Event;

	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.ScrollContainer;
	import feathers.events.FeathersEventType;
	import feathers.themes.MetalWorksMobileTheme;

	public class AppController extends ScreenNavigator {
		private var home: Home;

		private var cmm: Cmm;
		private var cmmInfo: CmmInfo;
		//private var cmmImages: CmmImages;
		private var cmmVideo: CmmVideo;

		private var dap: Dap;
		private var dapInfo: DapInfo;
		//private var dapImages: DapImages;
		private var dapVideo: DapVideo;

		private var gad: Gad;
		private var gadInfo: GadInfo;
		//private var gadImages: GadImages;		
		private var gadVideo: GadVideo;

		private var settings: Settings;

		private var homeSC: ScreenNavigatorItem;

		private var cmmSC: ScreenNavigatorItem;
		private var cmmInfoSC: ScreenNavigatorItem;
		//private var cmmImagesSC: ScreenNavigatorItem;
		private var cmmVideoSC: ScreenNavigatorItem;

		private var dapSC: ScreenNavigatorItem;
		private var dapInfoSC: ScreenNavigatorItem;
		//private var dapImagesSC: ScreenNavigatorItem;
		private var dapVideoSC: ScreenNavigatorItem;

		private var gadSC: ScreenNavigatorItem;
		private var gadInfoSC: ScreenNavigatorItem;
		//private var gadImagesSC: ScreenNavigatorItem;
		private var gadVideoSC: ScreenNavigatorItem;
		
		private var settingsSC: ScreenNavigatorItem;

		public function AppController() {
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		private function initializeHandler(e: Event): void {
			this.removeEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			startApp();
		}
		private function startApp() {
			new MetalWorksMobileTheme();
			/*-----------------------Home----------------------*/
			home = new Home();
			homeSC = new ScreenNavigatorItem(home, {
				"showCmm": "cmm",
				"showDap": "dap",
				"showGad": "gad",
				"showSettings": "settings"
			});
			this.addScreen("home", homeSC);
			/*-----------------------Cmm-----------------------*/
			cmm = new Cmm();
			cmmSC = new ScreenNavigatorItem(cmm, {
				"showCmmInfo": "cmmInfo",
				"showCmmImages": "cmmImages",
				"showCmmVideo": "cmmVideo",
				"showHome": "home"
			});
			this.addScreen("cmm", cmmSC);

			cmmInfo = new CmmInfo();
			cmmInfoSC = new ScreenNavigatorItem(cmmInfo, {
				"showCmm": "cmm"
			});
			this.addScreen("cmmInfo", cmmInfoSC);

			/*cmmImages = new CmmImages();
			cmmImagesSC = new ScreenNavigatorItem(cmmImages, {
				"showCmm": "cmm"
			});
			this.addScreen("cmmImages", cmmImagesSC);*/

			cmmVideo = new CmmVideo();
			cmmVideoSC = new ScreenNavigatorItem(cmmVideo, {
				"showCmm": "cmm"
			});
			this.addScreen("cmmVideo", cmmVideoSC);
			/*-----------------------Dap-----------------------*/
			dap = new Dap();
			dapSC = new ScreenNavigatorItem(dap, {
				"showDapInfo": "dapInfo",
				//"showDapImages": "dapImages",
				"showDapVideo": "dapVideo",
				"showHome": "home"
			});
			this.addScreen("dap", dapSC);

			dapInfo = new DapInfo();
			dapInfoSC = new ScreenNavigatorItem(dapInfo, {
				"showDap": "dap"
			});
			this.addScreen("dapInfo", dapInfoSC);	
			
			/*dapImages = new DapImages();
			dapImagesSC = new ScreenNavigatorItem(dapImages, {
				"showDap": "dap"
			});
			this.addScreen("dapImages", dapImagesSC);*/

			dapVideo = new DapVideo();
			dapVideoSC = new ScreenNavigatorItem(dapVideo, {
				"showDap": "dap"
			});
			this.addScreen("dapVideo", dapVideoSC);
			/*--------------------Gad--------------------------*/
			gad = new Gad();
			gadSC = new ScreenNavigatorItem(gad, {
				"showGadInfo": "gadInfo",
				//"showGadImages": "gadImages",
				"showGadVideo": "gadVideo",
				"showHome": "home"
			});
			this.addScreen("gad", gadSC);

			gadInfo = new GadInfo();
			gadInfoSC = new ScreenNavigatorItem(gadInfo, {
				"showGad": "gad"
			});
			this.addScreen("gadInfo", gadInfoSC);

			/*gadImages = new GadImages();
			gadImagesSC = new ScreenNavigatorItem(gadImages, {
				"showGad": "gad"
			});
			this.addScreen("gadImages", gadImagesSC);*/

			gadVideo = new GadVideo();
			gadVideoSC = new ScreenNavigatorItem(gadVideo, {
				"showGad": "gad"
			});
			this.addScreen("gadVideo", gadVideoSC);
			/*-------------------Settings----------------------*/
			settings = new Settings();
			settingsSC = new ScreenNavigatorItem(settings, {
				"showHome": "home"
			});
			this.addScreen("settings", settingsSC);
			/*-------------------------------------------------*/
			this.showScreen("home");
		}

	}

}