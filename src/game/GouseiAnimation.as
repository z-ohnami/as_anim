package game
{
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GouseiAnimation extends Sprite
	{
		private var _base:ImageLoader;
		private var _material:Vector.<ImageLoader>;
		
		public function GouseiAnimation(base:ImageLoader,material:Vector.<ImageLoader>)
		{
			_base = base;
			_material = material;
			
			addEventListener(Event.ADDED_TO_STAGE,init);
			
		}

		private function init():void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			_base.scaleX = 0.3;
			_base.scaleY = 0.3;
			_base.x = stage.stageWidth / 2 - _base.width / 2;
			_base.y = stage.stageHeight / 2 + _base.height / 2;
			
			var l:int = _material.length;
			var posX:int = (stage.stageWidth - (_material[i].width * l) ) / 2;
			for(var i:int=0;i < l;i++) {
				_material[i].scaleX = 0.1;
				_material[i].scaleY = 0.1;
				_material[i].x = posX;
				_material[i].y = stage.stageHeight - (_material[i].height * 2);

				posX += _material[i].width;
			}
			
		}
		
		public function start():void
		{
			Tween24.serial(
				Tween24.wait(0.3),
				Tween24.parallel(
					raiseBaseCard(),
					raiseMaterialCard()
				)
			).play();
		}
		
		private function raiseBaseCard():Tween24
		{
			return Tween24.tween(_base,1,Ease24._3_CubicInOut).y(-(_base.height));
		}

		private function raiseMaterialCard():Tween24
		{
			var tween:Array = [];
			
			var l:int = _material.length;
			var posX:int = 0;
			for(var i:int=0;i < l;i++) {
				tween.push(Tween24.tween(_material[i],0.5,Ease24._1_SineInOut).y(-(_material[i].height)).delay(0.3 + (i * 0.05)));
			}

			return Tween24.parallel(tween);
		}
	}
}