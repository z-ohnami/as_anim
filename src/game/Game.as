package game
{
	
	import starling.display.Sprite;
	import starling.events.Event;
	
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
			
			stage.color = 0x000000;

			var animation:GouseiAnimation = new GouseiAnimation(new GouseiAnimationData());
			addChild(animation);
			animation.start();
			
		}
	}
}