package game
{
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class LevelUpAnimation extends Animation
	{
		private var _white:Quad;
		private var _black:Quad;
		private var _card:Image;
		private var _logo:Image;
		private var _bg:Image;
		private var _bossCatch:Sprite;
		
		private var _vege1:Image;
		private var _vege2:Image;
		private var _vege3:Image;
		private var _vege4:Image;

		private var _messagePanel:Sprite;
		private var _messageText:TextField;

		private var _loginItemTexture:Texture;
		private var _loginItemAtlas:TextureAtlas;

		private var _backLine:Sprite;
		private var _backLineFrames:Vector.<Quad>;

		[Embed(source = '../../res/img/levelup-logo.png')]
		private static var LogoImage:Class;

		[Embed(source = '../../res/img/card1.png')]
		private static var CardImage:Class;
				
		public function LevelUpAnimation()
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
			
		}

		private function init():void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);

			
			_black = new Quad(stage.stageWidth,stage.stageHeight,0x000000);
			addChild(_black);

			createBackLine();
			
			_logo  = new Image(Texture.fromBitmap(new LogoImage()));
			_logo.alpha = 0;
			_logo.pivotX = _logo.width >> 1;
			_logo.pivotY = _logo.height >> 1;
			_logo.x = stage.stageWidth >> 1;
			_logo.y = _logo.height;
			addChild(_logo);
			
			_card = new Image(Texture.fromBitmap(new CardImage()));
			_card.pivotX = _card.width >> 1;
			_card.pivotY = _card.height >> 1;
			_card.x = stage.stageWidth >> 1;
			_card.y = stage.stageHeight >> 1;
			addChild(_card);
			
			_white = new Quad(stage.stageWidth,stage.stageHeight,0xFFFFFF);
			_white.alpha = 0;
			addChild(_white);

			//create root tween
			_title = 'レベルアップ';
			_rootTween = Tween24.serial(
				cardTween(),
				lineAddTween(),
				Tween24.parallel(
					logoTween(),
					Tween24.func(rotateLine)
				),
				endTween()
			);
			
		}

		private function createBackLine():void
		{
			_backLineFrames = new Vector.<Quad>();
			_backLine = new Sprite();

			var lineTotal:int = 16;
			var colorArray:Array = [0x000000,0xff8c00,0x228b22];
			var lw:int = stage.stageWidth / lineTotal;
			var lh:int = stage.stageHeight;

			var startY1:int = -1 * lh;
			var startY2:int = stage.stageHeight;
			
			for(var i:int=0;i < lineTotal;i++) {
				var color:uint = colorArray[i % 3];
				var line:Quad = new Quad(lw,lh,color);

				line.x = i * lw;
				line.y = (i % 2 == 0) ? startY1 : startY2;
				_backLine.addChild(line);
				_backLineFrames.push(line);
			}

			addChild(_backLine);			
		}
		
//		public function start(onTweenComplete:Function):void
//		{
//			var tween:Tween24 = Tween24.serial(
//				cardTween(),
//				lineAddTween(),
//				Tween24.parallel(
//					logoTween(),
//					Tween24.func(rotateLine)
//				),
//				endTween()
//			);
//			
//			tween.addEventListener(Tween24Event.COMPLETE,onTweenComplete);
//			tween.play();
//			
//		}
		
		private function cardTween():Tween24
		{
			return Tween24.loop(4,
				Tween24.tween(_card,0.1).scaleXY(1.2,1.2).alpha(0.7),
				Tween24.wait(0.1),
				Tween24.tween(_card,0.1).scaleXY(1,1).alpha(1)
			);
		}

		private function lineAddTween():Tween24
		{
			var delayTime:Number = 0.05;
			var tweenArray:Array = [];

			var l:int = _backLineFrames.length;
			for(var i:int = 0;i < l;i++) {
				var line:Quad = _backLineFrames[i];
				tweenArray.push(
					Tween24.tween(line,0.5,Ease24._7_CircOut).y(0).delay(delayTime * i)
				);
			}
			
			return Tween24.parallel(
				tweenArray
			);
		}

		private function logoTween():Tween24
		{
			return Tween24.serial(
				Tween24.tween(_logo,0.5).alpha(1).scaleXY(1.5,1.5),
				Tween24.tween(_logo,0.5).scaleXY(1,1),
				Tween24.wait(1)
			);
		}

		private function rotateLine():void
		{

		}
		
		private function endTween():Tween24
		{
			return Tween24.serial(
				Tween24.tween(_white,0.5).alpha(1)
			);
		}
		
	}
}