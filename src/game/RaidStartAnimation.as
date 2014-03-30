package game
{
	
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	
	import jp.nium.core.debug.Log;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class RaidStartAnimation extends Sprite
	{
		private var _boss:Image;
		private var _logo:Image;
				
		private var _panel1:Image;
		private var _panel2:Image;
		private var _panel3:Image;
		private var _panel4:Image;

		[Embed(source = '../../res/img/nebuta.png')]
		private static var RaidBossImage:Class;

		[Embed(source = '../../res/img/nebuta-logo.png')]
		private static var Logo:Class;
		
		[Embed(source="../../res/img/nebuta-panel.xml", mimeType="application/octet-stream")]
		private static const RaidBossXml:Class;
		
		public function RaidStartAnimation()
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
			
		}

		private function init():void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);

			_boss = new Image(Texture.fromBitmap(new RaidBossImage()));
			_boss.pivotX = _boss.width >> 1;
			_boss.alpha = 0;
			addChild(_boss);

			_logo = new Image(Texture.fromBitmap(new Logo()));
			_logo.alpha = 0;
			addChild(_logo);

			var bossTexture:Texture = Texture.fromBitmap(new RaidBossImage());
			var bossAtlas:TextureAtlas = new TextureAtlas(bossTexture, XML(new RaidBossXml()));
			var bossFrames:Vector.<Texture> = bossAtlas.getTextures("");
			
			_panel1 = new Image(bossFrames[0]);
			_panel2 = new Image(bossFrames[1]);
			_panel3 = new Image(bossFrames[2]);
			_panel4 = new Image(bossFrames[3]);

			_panel1.pivotX = _panel1.width >> 1;
			_panel1.pivotY = _panel1.height >> 1;
			_panel1.x = stage.stageWidth >> 1;
			_panel1.y = stage.stageHeight >> 1;
			_panel1.scaleX = 4;
			_panel1.scaleY = 4;

			_panel2.pivotX = _panel2.width >> 1;
			_panel2.pivotY = _panel2.height >> 1;
			_panel2.x = stage.stageWidth >> 1;
			_panel2.y = stage.stageHeight >> 1;
			_panel2.scaleX = 4;
			_panel2.scaleY = 4;

			_panel3.pivotX = _panel3.width >> 1;
			_panel3.pivotY = _panel3.height >> 1;
			_panel3.x = stage.stageWidth >> 1;
			_panel3.y = stage.stageHeight >> 1;
			_panel3.scaleX = 4;
			_panel3.scaleY = 4;

			_panel4.pivotX = _panel4.width >> 1;
			_panel4.pivotY = _panel4.height >> 1;
			_panel4.x = stage.stageWidth >> 1;
			_panel4.y = stage.stageHeight >> 1;
			_panel4.scaleX = 4;
			_panel4.scaleY = 4;
			
			_panel1.alpha = 0;
			_panel2.alpha = 0;
			_panel3.alpha = 0;
			_panel4.alpha = 0;
			
			addChild(_panel1);
			addChild(_panel2);
			addChild(_panel3);
			addChild(_panel4);

			_logo = new Image(Texture.fromBitmap(new Logo()));
			_logo.alpha = 0;
//			_logo.x = _logo.width >> 1;
			_logo.y = stage.stageHeight - _logo.height;
			
			addChild(_logo);

		}
		
		public function start():void
		{
			Tween24.serial(
//				Tween24.wait(2)
				spotTween(),
				slashTween(),
				toBattleTween()
			).play();
		}

		private function spotTween():Tween24
		{
			return Tween24.serial(
				Tween24.tween(_panel1,0.3,Ease24._1_SineIn).alpha(1).scaleXY(2,2),
				Tween24.wait(0.3),
				Tween24.tween(_panel1,0.05).alpha(0),
				Tween24.tween(_panel2,0.3,Ease24._1_SineIn).alpha(1).scaleXY(2,2),
				Tween24.wait(0.3),
				Tween24.tween(_panel2,0.05).alpha(0),
				Tween24.tween(_panel3,0.3,Ease24._1_SineIn).alpha(1).scaleXY(2,2),
				Tween24.wait(0.3),
				Tween24.tween(_panel3,0.05).alpha(0),
				Tween24.tween(_panel4,0.3,Ease24._1_SineIn).alpha(1).scaleXY(2,2),
				Tween24.wait(0.3),
				Tween24.tween(_panel4,0.05).alpha(0)
			)
		}

		private function slashTween():Tween24
		{
			var bx:int = (stage.stageWidth >> 2) * 2;
			var ly:int = (stage.stageHeight >> 1) - (_logo.height >> 2);
			
			return Tween24.serial(
				Tween24.parallel(
					Tween24.tween(_logo,0.8).alpha(1).y(ly),
					Tween24.tween(_boss,1.2,Ease24._BackIn).alpha(1).x(bx)
				),
				Tween24.wait(0.5)
			);
		}

		private function toBattleTween():Tween24
		{
//			this.pivotX = stage.stageWidth >> 1;
//			this.pivotY = stage.stageHeight >> 1;
			
			return Tween24.serial(
				Tween24.tween(this,3).rotation(3)
			);
		}
		
	}
}