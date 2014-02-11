package game
{
	
	import game.ImageLoader;
	
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
			
			var baseCard:ImageLoader = new ImageLoader('/img/card1.png',96,144);
			addChild(baseCard);

			var materialCard:Vector.<ImageLoader> = new Vector.<ImageLoader>;
			for(var i:Number = 0;i < 5;i++) {
				var material:ImageLoader = new ImageLoader('/img/card'+(i+1)+'.png',32,48);
				addChild(material);
				materialCard.push(material);
			}
			
			var animation:GouseiAnimation = new GouseiAnimation(baseCard,materialCard);
			addChild(animation);
			animation.start();
			
		}
	}
}