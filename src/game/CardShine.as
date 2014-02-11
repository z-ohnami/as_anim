package game
{
	import starling.display.Sprite;
	
	public class CardShine extends Sprite
	{
		
		private var colorA:uint;
		private var numShines:int;
		private var shineWidth:Number, shineHeight:Number;
		private var speed:Number;
		private var shineLayer:Sprite = null;

		private var _baseWidth:Number;
		private var _baseHeight:Number;
		private var _baseNum:Number;
		
		public function CardShine(colorA:uint, numShines:int, shineWidth:Number, shineHeight:Number, speed:Number)
		{
			super();

			shineLayer = new Sprite();
			addChild(shineLayer);

			_baseNum = numShines;
			_baseWidth = shineWidth;
			_baseHeight = shineHeight;
			
			this.colorA = colorA;
//			this.colorB = colorB;
//			this.numShines = Util.getRandomRange(4,numShines);
//			this.shineWidth = shineWidth;
//			this.shineHeight = shineHeight;
//			this.shineWidth = Util.getRandomRange(100,shineWidth);
//			this.shineHeight = Util.getRandomRange(100,shineHeight);
			this.speed = speed;
			
//			drawShines();

		}
		
		public function drawShines():void
		{
			shineLayer.removeChildren();

			this.numShines = _baseNum;
//			this.numShines = Util.getRandomRange(4,_baseNum);
			this.shineWidth = _baseWidth;
			this.shineHeight = _baseHeight;
//			this.shineWidth = Util.getRandomRange(100,_baseWidth);
//			this.shineHeight = Util.getRandomRange(100,_baseHeight);
			
			var i:int = -1, angle:Number = 360 / numShines;
			while (++i < numShines)
			{
//				if(i % 2) {
					var shine:Shine = new Shine(colorA, shineWidth, shineHeight);
//					var shine:Shine = new Shine(i % 2 ? colorA : colorB, shineWidth, shineHeight);
					shine.rotation = angle * i;
					shineLayer.addChild(shine);					
//				}
			}
		}
		
	}

}

import starling.display.Shape;

class Shine extends Shape
{
	public function Shine(color:uint, width:Number, height:Number)
	{
		
		graphics.beginFill(color);
		graphics.lineTo(-width >> 1, height);
		graphics.lineTo(width >> 1, height);
		graphics.lineTo(0, 0);
		graphics.endFill();
	}
}
