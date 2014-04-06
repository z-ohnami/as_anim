package game
{
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.filters.ColorMatrixFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class LoginBonusAnimation extends Animation
	{
		private var _white:Quad;
		private var _black:Quad;
		private var _hanko:Image;
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
		
		private var _vegeFrames:Vector.<Texture>;
		
		[Embed(source = '../../res/img/bg3.png')]
		private static var BgImage:Class;

		[Embed(source = '../../res/img/login-item.png')]
		private static var LoginItemImage:Class;
		
		[Embed(source="../../res/img/login-item.xml", mimeType="application/octet-stream")]
		private static const LoginItemXml:Class;
		
		public function LoginBonusAnimation()
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
			
		}

		private function init():void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);

			_loginItemTexture = Texture.fromBitmap(new LoginItemImage());
			_loginItemAtlas = new TextureAtlas(_loginItemTexture, XML(new LoginItemXml()));
			_vegeFrames = _loginItemAtlas.getTextures("vege");
			
			_bg = new Image(Texture.fromBitmap(new BgImage()));
			addChild(_bg);

			createLoginStampMap();
			
			_black = new Quad(stage.stageWidth,stage.stageHeight,0x000000);
			addChild(_black);

			_logo  = new Image(_loginItemAtlas.getTexture('logo'));
			_logo.alpha = 0;
			addChild(_logo);
			
			_hanko = new Image(_loginItemAtlas.getTexture('hanko'));
			_hanko.alpha = 0;
			addChild(_hanko);
			
			_vege1 = new Image(_vegeFrames[0]);
			_vege2 = new Image(_vegeFrames[1]);
			_vege3 = new Image(_vegeFrames[2]);
			_vege4 = new Image(_vegeFrames[3]);
			
			_messagePanel = new Sprite();
			var panelBg:Quad = new Quad(300,120,0x87ceeb);
			panelBg.alpha = 0.8;
			_messageText = new TextField(200,120,'');

			_messagePanel.alpha = 0;
			_messagePanel.addChild(panelBg);
			_messagePanel.addChild(_messageText);

			_messagePanel.addChild(_vege1);
			_messagePanel.addChild(_vege2);

			addChild(_messagePanel);
			
			_white = new Quad(stage.stageWidth,stage.stageHeight,0xFFFFFF);
			_white.alpha = 0;
			addChild(_white);

			_title = 'ログインボーナス';
			_rootTween = Tween24.serial(
				//				Tween24.wait(2)
				logoTween(),
				hankoTween(),
				messageTween(),
				endTween()
			);
			
		}

		private function createLoginStampMap():void
		{
			var map:Sprite = new Sprite();

			var back:Quad = new Quad(256,256,0xdc143c);
			map.addChild(back);
			
			var total:int = 9;
			var lineBlockNumber:int = 3;
			var current:int = 4;
			var posOffset:int = 4;

			var posX:int = posOffset;
			var posY:int = posOffset;

			var prizeLength:int = _vegeFrames.length;
			var prizePos:int = 0;
			
			for(var i:int=0;i < total;i++) {
				var tile:Quad = new Quad(80,80,0xfff5ee);
				tile.x = posX;
				tile.y = posY;
				map.addChild(tile);

				var prize:Image = new Image(_vegeFrames[prizePos]);
				prize.x = posX;
				prize.y = posY;
				map.addChild(prize);
				prizePos++;

				if(prizePos >= prizeLength) {
					prizePos = 0;
				}

				if(i < current) {
					var hanko:Image = new Image(_loginItemAtlas.getTexture('hanko'));
					hanko.x = posX;
					hanko.y = posY;
					map.addChild(hanko);
				}
				
				if((i+1) % lineBlockNumber == 0) {
					posX = posOffset;
					posY += tile.height + posOffset;
				} else {
					posX += tile.width  + posOffset;
				}
			}

			map.x = 32;
			map.y = (stage.stageHeight - map.height) >> 1;
			
			addChild(map);
		}
		
//		public function start():void
//		{
//			Tween24.serial(
////				Tween24.wait(2)
//				logoTween(),
//				hankoTween(),
//				messageTween(),
//				endTween()
//			).play();
//		}

		private function logoTween():Tween24
		{
			var lx:int = (stage.stageWidth - _logo.width) >> 1;
			var ly:int = (stage.stageHeight - _logo.height) >> 1;

			return Tween24.serial(
				Tween24.prop(_logo).xy(lx,ly + _logo.height),
				Tween24.tween(_logo,0.5).y(ly).alpha(1),
				Tween24.wait(0.3),
				Tween24.tween(_logo,0.3).alpha(0).y(ly - _logo.height),
				Tween24.tween(_black,0.5).alpha(0),
				Tween24.prop(_logo).alpha(1).y((_logo.height >> 1) + 20)
			);
		}

		private function hankoTween():Tween24
		{
			_hanko.x = stage.stageWidth >> 1;
			_hanko.y = stage.stageHeight >> 1;

			_hanko.pivotX = _hanko.width >> 1;
			_hanko.pivotY = _hanko.height >> 1;
			
			return Tween24.serial(
				Tween24.prop(_hanko).scaleXY(3,3),
				Tween24.tween(_hanko,1,Ease24._7_CircOut).scaleXY(1,1).alpha(1),
				Tween24.tweenFunc(glowHanko,0.3,[0],[0.7]),
				Tween24.wait(0.1),
				Tween24.tweenFunc(glowHanko,0.2,[0.7],[0])
			);
		}

		private function glowHanko(bright:Number):void
		{
			var cardFilter:ColorMatrixFilter = new ColorMatrixFilter();
			cardFilter.adjustBrightness(bright);
			_hanko.filter = cardFilter;
		}

		private function messageTween():Tween24
		{
			_messagePanel.x = (stage.stageWidth - _messagePanel.width) >> 1;
			_messagePanel.y = stage.stageHeight - _messagePanel.height - 20;
		
			_vege1.x = _messagePanel.width - _vege1.width - 30;
			_vege1.y = (_messagePanel.height - _vege1.height) >> 1;
			_messageText.text = '今日は白菜をプレゼント！！';
			
			_vege2.x = _messagePanel.width - _vege2.width - 30;
			_vege2.y = (_messagePanel.height - _vege2.height) >> 1;
			_vege2.alpha = 0;
			
			return Tween24.serial(
				Tween24.tween(_messagePanel,0.6,Ease24._3_CubicIn).alpha(1),
				Tween24.wait(1.5),
				Tween24.func(changeMessage),
				Tween24.wait(1.5)
			);
		}

		private function changeMessage():void
		{
			_messageText.text = '明日はジャガイモだ！！';
			Tween24.parallel(
				Tween24.tween(_vege1,0.5).alpha(0).delay(0.2),
				Tween24.tween(_vege2,0.5).alpha(1)				
			).play();
			
		}
		
		private function endTween():Tween24
		{
			return Tween24.serial(
				Tween24.tween(_white,0.5).alpha(1)
			);
		}
		
	}
}