package game
{
	import flash.display.BitmapData;
	
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class SkillAnimation extends Sprite
	{

		private const PLAYER_DECK_INITIAL_POS_X:int = 20;
		private const PLAYER_DECK_INITIAL_POS_Y:int = 320;
		private const ENEMY_DECK_INITIAL_POS_X:int = 3;
		private const ENEMY_DECK_INITIAL_POS_Y:int = 40;

		[Embed(source = '../../res/img/bg1.png')]
		private static var BgImage:Class;

		private var _black:Quad;
		
		[Embed(source = '../../res/img/skill_slash.png')]
		private static var SkillSlashImage:Class;

		[Embed(source = '../../res/img/skill_circle.png')]
		private static var SkillCircleImage:Class;
		
		[Embed(source = '../particle/texture.png')]
		private static var ParticleImage:Class;
		
		[Embed(source = '../particle/particle2.pex',mimeType = 'application/octet-stream')]
		private static var ParticleData:Class;

		[Embed(source="../../res/img/font.fnt", mimeType="application/octet-stream")]
		public static const FontXml:Class;

		[Embed(source = "../../res/img/font.png")]
		public static const FontTexture:Class;

		private var _playerDeck:Vector.<ImageLoader>;
		private var _enemyDeck:Vector.<ImageLoader>;		
		
		public function SkillAnimation(deck:DeckCardData):void
		{
			super();
			_playerDeck = deck.playerDeck;
			_enemyDeck = deck.enemyDeck;
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			//background
			var bg:Image = new Image(Texture.fromBitmap(new BgImage()));
			addChild(bg);
			
			//set DeckImage
			var pl:int = _playerDeck.length;
			var px:int = PLAYER_DECK_INITIAL_POS_X;
			var card:ImageLoader = null;
			for(var i:int = 0;i < pl;i++) {
				card = _playerDeck[i];
				card.x = px + card.width / 2;
				card.y = PLAYER_DECK_INITIAL_POS_Y + card.height / 2;
				card.pivotX = card.width / 2;
				card.pivotY = card.height / 2;
				addChild(card);
				px += (card.width);
			}

			var el:int = _enemyDeck.length;
			var ex:int = ENEMY_DECK_INITIAL_POS_X;
			for(i = 0;i < el;i++) {
				card = _enemyDeck[i];
				card.x = ex;
				card.y = ENEMY_DECK_INITIAL_POS_Y;
				addChild(card);
				ex += (card.width);
			}

			_black = new Quad(stage.stageWidth,stage.stageHeight,0x000000);
			_black.alpha = 0;
			addChild(_black);
			
			//font setting
			var texture:Texture = Texture.fromBitmap(new FontTexture());
			var xml:XML = XML(new FontXml());
			TextField.registerBitmapFont(new BitmapFont(texture, xml));

		}
		
		public function start():void
		{
			// main
			Tween24.serial(
				beginTween(),
				animateSkill(),
				whiteOut(),
				showDamage()
			).play();

		}

		private function beginTween():Tween24
		{
			return Tween24.serial(
				Tween24.parallel(
					bootSkillTween(),
					showTitle()
				),
				blackOut()
			);
		}

		private function bootSkillTween():Tween24
		{
			var circle:Image = new Image(Texture.fromBitmap(new SkillCircleImage()));
			addChild(circle);
			
			var player:ImageLoader = _playerDeck[0];
			circle.x = player.x;
			circle.y = player.y - 40;

			circle.pivotX = circle.width / 2;
			circle.pivotY = circle.height / 2;
			
			circle.alpha = 0;
			
			return Tween24.serial(
				Tween24.tween(_playerDeck[0],0.4,Ease24._BackInOut).$y(-40),
				Tween24.tween(circle,0.2).alpha(1),
				Tween24.tween(circle,0.5).alpha(0).scaleXY(5,5)
			);
			
		}
		
		private function showTitle():Tween24
		{
			var text:TextField = new TextField(100,80,'乱舞の太刀');
			text.color = 0xFFFFFF;
			text.x = (stage.stageWidth - text.width) >> 1;
			text.y = (stage.stageHeight - text.height) >> 1;
			text.vAlign = 'top';
			text.hAlign = 'left';
			text.scaleX = 1.5;
			text.scaleY = 1.5;
			addChild(text);
			
			return Tween24.serial(
				Tween24.prop(text).alpha(0),
				Tween24.tween(text,0.5).alpha(1),
				Tween24.tween(text,0.5).alpha(0)
			);
			
		}

		private function animateSkill():Tween24
		{
			var slashSetting:Array = [
				{'x':60,'y':30,'mx':-100,'my':130,'rotation':-45,'scaleOffset':0.5},
				{'x':100,'y':50,'mx':130,'my':80,'rotation':120,'scaleOffset':0.5},
				{'x':200,'y':100,'mx':100,'my':130,'rotation':180,'scaleOffset':0.5},
				{'x':200,'y':100,'mx':130,'my':-80,'rotation':-120,'scaleOffset':0.5},
				{'x':20,'y':150,'mx':120,'my':-90,'rotation':-120,'scaleOffset':0.5},
				{'x':300,'y':40,'mx':-100,'my':130,'rotation':-45,'scaleOffset':0.5},
				{'x':300,'y':100,'mx':-130,'my':80,'rotation':-120,'scaleOffset':0.5},
				{'x':180,'y':150,'mx':-80,'my':-130,'rotation':-90,'scaleOffset':0.5},
				{'x':300,'y':100,'mx':-100,'my':130,'rotation':-45,'scaleOffset':0.5},
				{'x':300,'y':100,'mx':-100,'my':130,'rotation':-120,'scaleOffset':0.5},
				{'x':10,'y':70,'mx':200,'my':0,'rotation':0,'scaleOffset':1.2}, // finish
			];

			var tween:Array = [];

			var sl:int = slashSetting.length;
			var delayTime:Number = 0;

			for(var i:int=0;i < sl;i++) {
				var setting:Object = slashSetting[i];
				var skillImage:Image = new Image(Texture.fromBitmap(new SkillSlashImage()));
				skillImage.x = setting.x;
				skillImage.y = setting.y;
				skillImage.alpha = 0;
				addChild(skillImage);
				
				tween.push( Tween24.parallel(
					Tween24.serial(
						Tween24.prop(skillImage).scaleXY(1 * setting.scaleOffset,1 * setting.scaleOffset).rotation(setting.rotation),
						Tween24.tween(skillImage,0.1).scaleXY(1 * setting.scaleOffset,1 * setting.scaleOffset),
						Tween24.tween(skillImage,0.1).scaleXY(1.1 * setting.scaleOffset,1.1 * setting.scaleOffset),
						Tween24.wait(0.05)
					),
					Tween24.serial(
						Tween24.tween(skillImage,0.1).alpha(0.7),
						Tween24.tween(skillImage,0.1).alpha(1.0),
						Tween24.tween(skillImage,0.6).alpha(0)
					),
					Tween24.tween(skillImage,0.3).$xy(setting.mx,setting.my)
				).delay(delayTime));

				delayTime += 0.08;
			}
			
			for(i=0;i<_enemyDeck.length;i++) {
				tween.push(
					Tween24.loop(6,
						Tween24.serial(
							Tween24.tween(_enemyDeck[i],0.05).$x(3),
							Tween24.tween(_enemyDeck[i],0.05).$x(-3)
						)
					)
				)
			}
			
			return Tween24.parallel(tween);
		}

		private function showDamage():Tween24
		{
			var tween:Array = [];
			var l:int = _enemyDeck.length;
			var damageText:Vector.<TextField> = new Vector.<TextField>();
			
			var delayTime:Number = 0;
			for (var i:int=0;i<l;i++) {
				var text:TextField = new TextField(50,30,calcDamage());
				var target:ImageLoader = _enemyDeck[i];
				text.fontName = 'Arial';
//				text.fontSize = BitmapFont.NATIVE_SIZE;
//				text.color = 0xFFFFFF;
				text.color = Color.WHITE;
				text.x = target.x + 5;
				text.y = target.y + target.height - 10;
				text.vAlign = 'top';
				text.hAlign = 'left';
				text.alpha = 0;
				text.scaleX = 2;
				text.scaleY = 2;
				addChild(text);
				tween.push(
					Tween24.parallel(
						Tween24.serial(
							Tween24.tween(text,0.1).$xy(3,-10),
							Tween24.tween(text,0.1).$xy(-3,10)
						),
						Tween24.serial(
							Tween24.tween(text,0.2).alpha(1),
							Tween24.wait(1),
							Tween24.tween(text,0.2).alpha(0)
						)
					).delay(delayTime)
				);
				
				delayTime += 0.04;
			}

			return Tween24.parallel(tween);
		}

		private function calcDamage():String
		{
			return String(Util.getRandomRange(500,999));
		}
		
		private function blackOut():Tween24
		{
			return Tween24.tween(_black,0.5).alpha(0.5);
		}

		private function whiteOut():Tween24
		{
			return Tween24.tween(_black,0).alpha(0);
		}
		
	}
	
}

