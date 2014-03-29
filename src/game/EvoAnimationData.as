package game
{
	public class EvoAnimationData
	{

		public var baseCard:ImageLoader;
		public var materialCard:ImageLoader;
		
		public function EvoAnimationData()
		{			
			baseCard = new ImageLoader('/img/card1.png',64,96);
			materialCard = new ImageLoader('/img/card2.png',64,96);			
			
		}
	}
}