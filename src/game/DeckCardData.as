package game
{
	public class DeckCardData
	{

		public var playerDeck:Vector.<ImageLoader>;
		public var enemyDeck:Vector.<ImageLoader>;
		
		public function DeckCardData()
		{	
			playerDeck = new Vector.<ImageLoader>();
			enemyDeck = new Vector.<ImageLoader>();
			
			for(var i:Number = 0;i < 1;i++) {
				var player:ImageLoader = new ImageLoader('/img/card'+(i+1)+'.png',64,96);
				playerDeck.push(player);
			}
			
			enemyDeck = new Vector.<ImageLoader>;
			for(i = 0;i < 5;i++) {
				var enemy:ImageLoader = new ImageLoader('/img/card'+(i+1)+'.png',64,96);
				enemyDeck.push(enemy);
			}
			
		}
	}
}