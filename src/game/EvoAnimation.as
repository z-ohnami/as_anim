package game
{
	
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.filters.ColorMatrixFilter;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class EvoAnimation extends Animation
	{
		private var _base:ImageLoader;
		private var _material:ImageLoader;
		private var _after:Image;
		private var _bg:Image;
				
		private var _panel1:Sprite;
		private var _panel2:Sprite;
		private var _panel3:Sprite;

		[Embed(source = '../../res/img/bg2.png')]
		private static var Bg:Class;

		[Embed(source = '../../res/img/card1.png')]
		private static var Card1:Class;

		[Embed(source = '../../res/img/card2.png')]
		private static var Card2:Class;

		[Embed(source = '../../res/img/card3.png')]
		private static var Card3:Class;
		
		[Embed(source="../../res/img/card_part1.xml", mimeType="application/octet-stream")]
		private static const CardXml1:Class;

		[Embed(source="../../res/img/card_part2.xml", mimeType="application/octet-stream")]
		private static const CardXml2:Class;

		[Embed(source="../../res/img/card_part3.xml", mimeType="application/octet-stream")]
		private static const CardXml3:Class;
		
		public function EvoAnimation()
		{
			var animationData:EvoAnimationData = new EvoAnimationData();
			
			_base = animationData.baseCard;
			_material = animationData.materialCard;
			
			addEventListener(Event.ADDED_TO_STAGE,init);
			
		}

		private function init():void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);

			_bg = new Image(Texture.fromBitmap(new Bg()));
			addChild(_bg);
			
			_base.pivotX = _base.width >> 1;
			_base.pivotY = _base.height >> 1;			
			_material.pivotX = _material.width >> 1;
			_material.pivotY = _material.height >> 1;
			
			_base.x     = ( stage.stageWidth)  >> 2;
			_base.y     = ( stage.stageHeight) >> 1;
			_material.x = (_base.x * 3);
			_material.y = ( stage.stageHeight) >> 1;

			addChild(_base);
			addChild(_material);
						
			_panel1 = createPanel(32,48,XML(new CardXml1()));
//			_panel1.scaleX = 3;
//			_panel1.scaleY = 3;
			
			_panel1.x = stage.stageWidth >> 1;
			_panel1.y = stage.stageHeight >> 1;
			_panel1.pivotX = _panel1.width >> 1;
			_panel1.pivotY = _panel1.height >> 1;
			_panel1.alpha = 0;
			
			addChild(_panel1);

			_panel2 = createPanel(16,24,XML(new CardXml2()));
//			_panel2.scaleX = 3;
//			_panel2.scaleY = 3;
			
			_panel2.x = stage.stageWidth >> 1;
			_panel2.y = stage.stageHeight >> 1;
			_panel2.pivotX = _panel2.width >> 1;
			_panel2.pivotY = _panel2.height >> 1;
			_panel2.alpha = 0;
			
			addChild(_panel2);

			_panel3 = createPanel(8,12,XML(new CardXml3()));
//			_panel3.scaleX = 3;
//			_panel3.scaleY = 3;
			
			_panel3.x = stage.stageWidth >> 1;
			_panel3.y = stage.stageHeight >> 1;
			_panel3.pivotX = _panel3.width >> 1;
			_panel3.pivotY = _panel3.height >> 1;
			_panel3.alpha = 0;

			addChild(_panel3);

			_after = new Image(Texture.fromBitmap(new Card3()));
//			_after.scaleX = 3;
//			_after.scaleY = 3;
			_after.x = stage.stageWidth >> 1;
			_after.y = stage.stageHeight >> 1;
			_after.pivotX = _after.width >> 1;
			_after.pivotY = _after.height >> 1;
			_after.alpha = 0;
			addChild(_after);

			_title = '進化';
			_rootTween = Tween24.serial(
				//				Tween24.wait(2)
				startTween(),
				evoTween(),
				endTween()
			);
			
		}
		
		private function startTween():Tween24
		{
			var cx:int = (stage.stageWidth) >> 1;
			
			return Tween24.serial(
				Tween24.tweenFunc(
					function(bright:Number):Function {
						var fil:ColorMatrixFilter = new ColorMatrixFilter();
						fil.adjustBrightness(bright);
						_bg.filter = fil;
					},0.5,[0],[-0.3]),
				Tween24.parallel(
					Tween24.tween(_base,1.5,Ease24._BackIn).x(cx),
					Tween24.tweenFunc(glowCard,0.1,[0],[0.5]).delay(1.4),
					Tween24.tween(_material,1.5,Ease24._BackIn).x(cx)
				),
				Tween24.parallel(
					Tween24.tween(_base,0.6).scaleXY(1.8,1.8),
					Tween24.tween(_material,0.6).scaleXY(1.8,1.8)
				),
				Tween24.func(
					resetFilter
				)
			);
		}

		private function evoTween():Tween24
		{
			return Tween24.serial(
				Tween24.tween(_panel1,0.6).alpha(1).scaleXY(1.8,1.8),
				Tween24.parallel(
					Tween24.tween(_panel2,0.5).alpha(1).scaleXY(2,2),
					Tween24.tween(_panel1,0.1).alpha(0),
					Tween24.tween(_base,0.1).alpha(0),
					Tween24.tween(_material,0.1).alpha(0)
				),
				Tween24.parallel(
					Tween24.tween(_panel3,0.5).alpha(1).scaleXY(2.5,2.5),
					Tween24.tween(_panel2,0.1).alpha(0)
				),
				Tween24.parallel(
					Tween24.tween(_after,0.4).alpha(1).scaleXY(3,3),
					Tween24.tween(_panel3,0.1).alpha(0)
				),
				Tween24.tween(_after,0.3).alpha(0).scaleXY(5,5)
			)
		}

		private function endTween():Tween24
		{
			var posY:int = stage.stageHeight >> 1;
			
			return Tween24.serial(
				Tween24.func(function():Function {
					_bg.filter = null;
				}
				),
				Tween24.prop(_after).alpha(1).scaleXY(1,1).y(-_after.height),
				Tween24.tween(_after,2).y(posY)
			);
		}
		
		private function glowCard(bright:Number):void
		{
//			_base.filter = BlurFilter.createGlow(color,alpha,2,1);
			var cardFilter:ColorMatrixFilter = new ColorMatrixFilter();
			cardFilter.adjustBrightness(bright);
			_base.filter = cardFilter;
			_material.filter = cardFilter;
		}

		private function resetFilter():void
		{
			_base.filter = null;
			_material.filter = null;
		}
		
		private function createPanel(blockWidth:int,blockHeight:int,splitXml:XML):Sprite
		{
			var panel:Sprite = new Sprite();
//			var xml:XML = XML(new CardXml1());
			
			var baseTexture:Texture = Texture.fromBitmap(new Card1());
			var baseAtlas:TextureAtlas = new TextureAtlas(baseTexture, splitXml);
			var baseFrames:Vector.<Texture> = baseAtlas.getTextures("");

			var materialTexture:Texture = Texture.fromBitmap(new Card2());
			var materialAtlas:TextureAtlas = new TextureAtlas(materialTexture, splitXml);
			var materialFrames:Vector.<Texture> = materialAtlas.getTextures("");

//			var w:int = 32;
//			var h:int = 48;
			var cy:int = 0;
			var cx:int = 0;
			var l:int = baseFrames.length;
			var suffix:int = 0;
			var blockNum:int = 64 / blockWidth;
			
			for(var i:int = 0;i < l;i++) {
				var tx:Texture = ((i+suffix) % 2 == 0) ? baseFrames[i] : materialFrames[i];
				var img:Image = new Image(tx);
				panel.addChild(img);
				img.x = cx;
				img.y = cy;

				if(i == 0 || (i+1) % blockNum > 0) {
					cx += blockWidth;
				} else {
					cx = 0;
					cy += blockHeight;
					suffix = (suffix > 0) ? 0 : 1;
				}				
			}

			return panel;
		}
		
	}
}