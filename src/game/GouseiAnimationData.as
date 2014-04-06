package game
{
	public class GouseiAnimationData
	{

		public var baseCard:ImageLoader;
		public var materialCard:Vector.<ImageLoader>;
		
		public function GouseiAnimationData()
		{			
			baseCard = new ImageLoader('/img/card1.png',64,96);
			
			materialCard = new Vector.<ImageLoader>;
			for(var i:Number = 0;i < 5;i++) {
				var material:ImageLoader = new ImageLoader('/img/card'+(i+1)+'.png',64,96);
				materialCard.push(material);
			}
			
		}
	}
}