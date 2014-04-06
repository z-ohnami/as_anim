package game
{
	
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class SkillAnimation extends Animation
	{

		private const PLAYER_DECK_INITIAL_POS_X:int = 20;
		private const PLAYER_DECK_INITIAL_POS_Y:int = 320;
		private const ENEMY_DECK_INITIAL_POS_X:int = 3;
		private const ENEMY_DECK_INITIAL_POS_Y:int = 40;

		[Embed(source = '../../res/img/bg1.png')]
		private static var BgImage:Class;

		private var _black:Quad;

		[Embed(source = '../../res/img/skill_circle.png')]
		private static var SkillCircleImage:Class;
		
		[Embed(source="../../res/img/font.fnt", mimeType="application/octet-stream")]
		public static const FontXml:Class;

		[Embed(source = "../../res/img/font.png")]
		public static const FontTexture:Class;

		protected var _playerDeck:Vector.<ImageLoader>;
		protected var _enemyDeck:Vector.<ImageLoader>;		
		private var _skillEffect:SkillEffectBase;
		
		public function SkillAnimation(deck:DeckCardData,skillEffect:SkillEffectBase):void
		{
			super();
			_playerDeck = deck.playerDeck;
			_enemyDeck = deck.enemyDeck;
			_skillEffect = skillEffect;
			_skillEffect.enemyDeck = deck.enemyDeck;
			
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
			
			//set skillEffect
			addChild(_skillEffect);

			_title = 'スキル ('+_skillEffect.skillEffectName+')';
			_rootTween = Tween24.serial(
					beginTween(),
					animateSkill(),
					resetEnemyPosTween(),
					whiteOut(),
					showDamage()
				);
			
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
			var skillPanel:Sprite = new Sprite();
			skillPanel.alpha = 0;
			var skillPanelBg:Quad = new Quad(200,30,0x4169e1);
			skillPanelBg.alpha = 0.8;
			
			skillPanel.addChild(skillPanelBg);
			
			var text:TextField = new TextField(200,30,_skillEffect.skillEffectName,'Verdana',16);
			text.color = 0xFFFFFF;
			text.hAlign = 'center';

			skillPanel.x = (stage.stageWidth - skillPanel.width) >> 1;
			skillPanel.y = (stage.stageHeight - skillPanel.height) >> 1;
			skillPanel.addChild(text);

			addChild(skillPanel);
			
			return Tween24.serial(
				Tween24.prop(skillPanel).alpha(0),
				Tween24.tween(skillPanel,0.5).alpha(1),
				Tween24.tween(skillPanel,0.5).alpha(0)
			);
			
		}

		private function animateSkill():Tween24
		{

			var tween:Array = [];
			tween.push(_skillEffect.effectTween);
			
			for(var i:int = 0;i<_enemyDeck.length;i++) {
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

		private function resetEnemyPosTween():Tween24
		{
			var tween:Array = [];
			
			//reset enemy position
			var card:ImageLoader = null;
			var el:int = _enemyDeck.length;
			var ex:int = ENEMY_DECK_INITIAL_POS_X;
			for(var i:int = 0;i < el;i++) {
				card = _enemyDeck[i];
				tween.push(
					Tween24.prop(card).xy(ex,ENEMY_DECK_INITIAL_POS_Y)
				);
				ex += (card.width);
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

