package game
{
	
	import starling.display.Sprite;
	import starling.events.Event;

	import game.ImageLoader;
	
	public class Game extends Sprite
	{
		public function Game()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init():void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			var baseCard:ImageLoader = new ImageLoader('/img/card1.png');
			addChild(baseCard);
		}
	}
}