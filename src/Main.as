package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	
	import game.Game;
	
	import starling.core.Starling;

//	[SWF(backgroundColor="#FFFFFF", width="360", height="640", frameRate="60")]
	public class Main extends Sprite
	{

		public static const SCREEN_WIDTH:int = 320;
		public static const SCREEN_HEIGHT:int = 480;		
		
		private var mStarling:Starling;
		
		public function Main()
		{
			super();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.frameRate = 60;

//			var scale:Number = stage.fullScreenWidth / Main.SCREEN_WIDTH;
//
//			stage.stageWidth = SCREEN_WIDTH * scale;
//			stage.stageHeight = SCREEN_HEIGHT * scale;
			
			Starling.handleLostContext = true; // コンテキストのロストを防ぐ
			
			//フルスクリーン時の縦横幅を取得
			var screenWidth:int = stage.fullScreenWidth;
			var screenHeight:int = stage.fullScreenHeight;
			
			// ゲーム画面が縦横比を維持しつつ、スクリーンにフィットするようにViewportの縦横幅を算出する
			var viewport:Rectangle = new Rectangle(0, 0, screenWidth, screenHeight);

			mStarling = new Starling(Game,stage,viewport);
			mStarling.stage.stageWidth = SCREEN_WIDTH;
			mStarling.stage.stageHeight = SCREEN_HEIGHT;
//			mStarling.enableErrorChecking = true;
			mStarling.start();

		}
	}
}