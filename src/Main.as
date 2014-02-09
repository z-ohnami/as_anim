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

			stage.stageWidth = SCREEN_WIDTH;
			stage.stageHeight = SCREEN_HEIGHT;
			
			mStarling = new Starling(Game,stage);
			mStarling.start();
			
		}
	}
}