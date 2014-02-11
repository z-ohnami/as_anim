package
{
	import flash.display.Sprite;
	
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

			var scale:Number = stage.fullScreenWidth / Main.SCREEN_WIDTH;

			stage.stageWidth = SCREEN_WIDTH * scale;
			stage.stageHeight = SCREEN_HEIGHT * scale;
			
			mStarling = new Starling(Game,stage);
			mStarling.start();

		}
	}
}