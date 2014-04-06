package game
{
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class GouseiAnimation extends Animation
	{
		private var _base:ImageLoader;
		private var _material:Vector.<ImageLoader>;
		private var _materialLength:int = 0;
		
		private var _flashScreen:Quad;
		private var _backEffect:Sprite;
		private var _panel:Sprite;

		private var _black:Quad;
		private var _blackFlg:Boolean = false;

		private var _messagePanel:Sprite;
		private var _messageText:TextField;
		
		private var _bg:Image;
		[Embed(source = '../../res/img/bg2.png')]
		private static var Bg:Class;
		
		private var _barContentImage:Image;
		[Embed(source="/img/testWaku.xml", mimeType="application/octet-stream")]
		public static const WakuXml:Class;
		[Embed(source="/img/testWaku.png")]
		public static const WakuTexture:Class;

		public function GouseiAnimation()
		{
			var animationData:GouseiAnimationData = new GouseiAnimationData();
			
			_base = animationData.baseCard;
			_material = animationData.materialCard;
			_materialLength = _material.length;
			
			addEventListener(Event.ADDED_TO_STAGE,init);
			
		}

		private function init():void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);

			_bg = new Image(Texture.fromBitmap(new Bg()));
			addChild(_bg);

			_black = new Quad(stage.stageWidth,stage.stageHeight,0x000000);
			_black.alpha = 0;
			addChild(_black);
			
			_backEffect = new Sprite();
			addChild(_backEffect);
			
			_base.x = (stage.stageWidth - _base.width) >> 1;
			_base.y = (stage.stageHeight + _base.height) >> 1;
			addChild(_base);
			
			var posX:int = 0;
			for(var i:int=0;i < _materialLength;i++) {
				_material[i].x = posX;
				_material[i].y = stage.stageHeight - _material[i].height;
				addChild(_material[i]);

				posX += _material[i].width;
			}

			_flashScreen = new Quad(stage.stageWidth,stage.stageHeight,0xFFFFFF);
			_flashScreen.alpha = 0;
			addChild(_flashScreen);

			createPanel();
			
			_title = '合成';
			_rootTween = Tween24.serial(
					Tween24.wait(0.3),
					Tween24.parallel(
						sceneChange(),
						raiseBaseCard(),
						raiseMaterialCard()
					),
					gouseiAction(),
					flashScreen(),
					Tween24.parallel(
						sceneChange(),
						showDownBaseCard(),
						showPanel()
					),
					Tween24.wait(1.5)
				);
		}

		private function sceneChange():Tween24
		{
			var num:int = (_blackFlg) ? 0 : 1;
			_blackFlg = (_blackFlg) ? false : true;
			
			return Tween24.tween(_black,1,Ease24._2_QuadOut).alpha(num);
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
				tween.push(Tween24.tween(_material[i],0.5,Ease24._1_SineInOut).y(-1 * _material[i].height).delay(0.4 + (i * 0.1)));
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
			
			var delayTime:Number = 0.4;
			
			for(var i:int=0;i < _materialLength;i++) {	
				materialTween.push(
					Tween24.serial(
						Tween24.prop(_material[i]).x(centerX + distance * Math.cos(currentDegree * Math.PI / 180)).y(centerY + distance * Math.sin(currentDegree * Math.PI / 180)),
						Tween24.tween(_material[i],0.6,Ease24._1_SineIn).x(centerX - _base.width / 2).y(centerY - _base.height / 2),
						Tween24.parallel(
							Tween24.tween(_material[i],0.2).alpha(0),
							addLightLine(Util.getRandomRange(8,16)),
							Tween24.func(addStarParticle,Util.getRandomRange(24,32))
						)
					).delay(delayTime * i)
				);
				
				currentDegree += (180 / _materialLength);
			}

			return Tween24.parallel(
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
		
		private function createPanel():void
		{
			
			_messagePanel = new Sprite();
			var panelBg:Quad = new Quad(280,120,0x87ceeb);
			panelBg.alpha = 0.8;
			_messageText = new TextField(280,120,'レベルがあがったよ。\nよかったね。','Verdana',18);
			
			_messagePanel.alpha = 0;
			_messagePanel.addChild(panelBg);
			_messagePanel.addChild(_messageText);

			_messagePanel.x = 20;
			_messagePanel.y = stage.stageHeight - _messagePanel.height - 20;
			
			addChild(_messagePanel);
			
		}
		
		private function showPanel():Tween24
		{
			return Tween24.serial(
				Tween24.wait(0.5),
				Tween24.tween(_messagePanel,1).alpha(1)
			);
		}

	}
}