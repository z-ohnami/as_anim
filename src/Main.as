package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import game.Game;
	
	import starling.core.Starling;
	
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

			var scale:Number = stage.fullScreenWidth / Main.SCREEN_WIDTH;

			stage.stageWidth = SCREEN_WIDTH * scale;
			stage.stageHeight = SCREEN_HEIGHT * scale;
			
			mStarling = new Starling(Game,stage);
//			mStarling.enableErrorChecking = true;
			mStarling.start();

		}
	}
}