package game
{
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	
	import starling.display.BlendMode;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GouseiAnimation extends Sprite
	{
		private var _base:ImageLoader;
		private var _material:Vector.<ImageLoader>;
		private var _materialLength:int = 0;
		
		private var _flashScreen:Quad;

		private var _backEffect:Sprite;
		
		public function GouseiAnimation(animationData:GouseiAnimationData)
		{
			_base = animationData.baseCard;
			_material = animationData.materialCard;
			_materialLength = _material.length;
			
			addEventListener(Event.ADDED_TO_STAGE,init);
			
		}

		private function init():void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);

			_backEffect = new Sprite();
			addChild(_backEffect);
			
			_base.scaleX = 0.3;
			_base.scaleY = 0.3;
			_base.x = stage.stageWidth / 2 - _base.width / 2;
			_base.y = stage.stageHeight / 2 + _base.height / 2;
			addChild(_base);
			
			var posX:int = (stage.stageWidth - (_material[0].width * _materialLength) ) / 2;
			for(var i:int=0;i < _materialLength;i++) {
				_material[i].scaleX = 0.15;
				_material[i].scaleY = 0.15;
				_material[i].x = posX;
				_material[i].y = stage.stageHeight - (_material[i].height * 2);
				addChild(_material[i]);

				posX += _material[i].width;
			}

			_flashScreen = new Quad(stage.stageWidth,stage.stageHeight,0xFFFFFF);
			_flashScreen.alpha = 0;
			addChild(_flashScreen);			

		}
		
		public function start():void
		{
			Tween24.serial(
				Tween24.wait(0.3),
				Tween24.parallel(
					raiseBaseCard(),
					raiseMaterialCard()
				),
				gouseiAction(),
				flashScreen(),
				showDownBaseCard()
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
				tween.push(Tween24.tween(_material[i],0.5,Ease24._1_SineInOut).y(-(_material[i].height)).delay(0.4 + (i * 0.1)));
			}

			return Tween24.parallel(tween);
		}
		
		private function flashScreen():Tween24
		{
			return Tween24.serial(
					Tween24.tween(_flashScreen,1.5).alpha(1)
				);
		}
		
		private function showDownBaseCard():Tween24
		{
			return Tween24.serial(
				Tween24.prop(_base).y(-(_base.height)),
				Tween24.parallel(
					Tween24.tween(_base,2).y(stage.stageHeight / 2 - _base.height / 2),
					Tween24.tween(_flashScreen,1).alpha(0)
				)
			);
		}
		
		private function gouseiAction():Tween24
		{
			var centerX:int = stage.stageWidth / 2;
			var centerY:int = stage.stageHeight / 2;

			var distance:int = stage.stageWidth / 2 + _material[0].width;
			var currentDegree:int = 0;
			
			var materialTween:Array = [];
			for(var i:int=0;i < _materialLength;i++) {
				
				materialTween.push(
					Tween24.serial(
						Tween24.prop(_material[i]).x(centerX + distance * Math.cos(currentDegree * Math.PI / 180)).y(centerY + distance * Math.sin(currentDegree * Math.PI / 180)),
//						Tween24.tween(_material[i],0.4).x(centerX - _material[i].width / 2).y(centerY - _material[i].height / 2).scaleXY(0.3,0.3),
						Tween24.tween(_material[i],0.4).x(centerX - _base.width / 2).y(centerY - _base.height / 2).scaleXY(0.3,0.3),
						Tween24.parallel(
							Tween24.tween(_material[i],0.2).alpha(0),
							addLightLine(Util.getRandomRange(8,16)),
							Tween24.func(addStarParticle,Util.getRandomRange(24,32))
						)
					)
				);
				
				currentDegree += (180 / _materialLength);
			}

			return Tween24.serial(
				Tween24.prop(_base).x(centerX - _base.width / 2).y(centerY - _base.height / 2),
				materialTween
			);
			
		}

		private function addLightLine(num:int = 10):Tween24
		{
			var tween:Array = [];
			for(var i:int = 0;i < num;i++) {
				var light:ImageLoader = new ImageLoader('/img/line.png',10,10);
				light.x = stage.stageWidth / 2;
				light.y = stage.stageHeight / 2;
				light.pivotX = light.width;
				light.scaleX = 100;
				light.scaleY = 5;
				light.rotation = (Math.PI * 2) / num * i;
				light.color = 0x60C0E0;
				light.blendMode = BlendMode.ADD;
				light.alpha = 0;

				_backEffect.addChild(light);
				tween.push(
					Tween24.serial(
						Tween24.prop(light).alpha(0.2),
						Tween24.tween(light, 1, Ease24._4_QuartOut).$$rotation(Math.random() - 0.5).alpha(0.6).scaleXY(200, 0).onComplete(removeImage, light)
					)
				);
			}
			
			return Tween24.parallel(tween);
		}

		private function addStarParticle(num:int = 30):void
		{
			var tween:Array = [];
			for(var i:int = 0;i < num;i++) {
				var light:ImageLoader = new ImageLoader('/img/star.png',10,10);	
				light.x = (stage.stageWidth / 2)  + Math.random() * 100 - 50;
				light.y = (stage.stageHeight / 2) + Math.random() * 100 - 50;
				light.rotation = -0.2;
				light.blendMode = BlendMode.ADD;
				light.color = 0x60C0E0;
				light.alpha = 0
				_backEffect.addChild(light);

				var dir:Number = Math.random() * (Math.PI * 2);
				//距離の減算によって速度を調節
				var speed:Number = 200 + (Math.random() * 800);
				
				tween.push(Tween24.parallel(
					Tween24.prop(light).alpha(0.6),
					Tween24.tween(light, 1).xy((stage.stageWidth / 2) + Math.cos(dir) * speed,(stage.stageHeight / 2) + Math.sin(dir) * speed).rotation(5),
					Tween24.tween(light, 1, Ease24._4_QuartIn).alpha(0)
				).onUpdate(function():void
				{
					var scale:Number = 0.5 + Math.random() * 3;
					light.scaleX = scale;
					light.scaleY = scale;
				}).onComplete(removeImage, light));
			}
			
			Tween24.parallel(tween).play();
		}
		
		
		private function removeImage(image:ImageLoader):void
		{
			if (image.parent == null)
				return;
			
			image.dispose();
			image.parent.removeChild(image);
		}		

		private function removeQuad(q:Quad):void
		{
			if (q == null)
				return;
			
			q.dispose();
		}		
	}
}