package game
{
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	import starling.filters.BlurFilter;
	
	public class SkillEffect5 extends SkillEffectBase
	{
		[Embed(source = '../../res/img/gravity_top.png')]
		private static var SkillGravityTopImage:Class;

		[Embed(source = '../../res/img/gravity_back.png')]
		private static var SkillGravityBackImage:Class;

		[Embed(source = '../../res/img/gravity_ring.png')]
		private static var SkillGravityRingImage:Class;

		[Embed(source = '../../res/img/circle_effect.png')]
		private static var CircleEffectImage:Class;
		
		public function SkillEffect5()
		{
			//set skill title
			super('グラヴィティブラスト');
			addEventListener(Event.ADDED_TO_STAGE,init);
			
		}
		
		private function init(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			_effectTween = setTween();			
		}
		
		private function setTween():Tween24
		{
			var tween:Array = [];
			
			var screen:Quad = new Quad(stage.stageWidth,stage.stageHeight,0x990099);
			screen.alpha = 0;
			addChild(screen);
			
			var gravity:Sprite = new Sprite();

			var ring:Image = new Image(Texture.fromBitmap(new SkillGravityRingImage()));
			var back:Image = new Image(Texture.fromBitmap(new SkillGravityBackImage()));
			var top:Image  = new Image(Texture.fromBitmap(new SkillGravityTopImage()));
			
			gravity.addChild(back);
			gravity.addChild(top);
			gravity.addChild(ring);
			
			gravity.x = stage.stageWidth >> 1;
			gravity.pivotX = gravity.width >> 1;
			gravity.y = 120;
			gravity.pivotY = gravity.height >> 1;
			gravity.alpha = 0;
			gravity.scaleX = 1.5;
			gravity.scaleY = 1.5;
			
			top.x = 128;
			top.y = 128;
			back.x = 128;
			back.y = 128;
			
			top.pivotX = 128;
			top.pivotY = 128;
			back.pivotX = 128;
			back.pivotY = 128;

			addChild(gravity);

			tween.push(
				Tween24.serial(
					Tween24.tween(screen,0.5,Ease24._2_QuadOut).alpha(0.2),
					Tween24.parallel(
						Tween24.serial(
							Tween24.prop(gravity).alpha(0.5),
							Tween24.parallel(
								Tween24.tween(gravity,0.7,Ease24._7_CircIn).scaleXY(1,1).alpha(1),
								addCircleTween()
							),
							Tween24.parallel(
								Tween24.tween(gravity,0.5,Ease24._7_CircIn).scaleXY(0.5,0.5),
								addCircleTween(true)
							),
							Tween24.parallel(
								Tween24.tween(gravity,0.4,Ease24._7_CircIn).scaleXY(0.2,0.2),
								addCircleTween()
							)
						),
						Tween24.parallel(
							Tween24.tween(top,2).rotation(4),
							Tween24.tween(back,2).rotation(-4)
						)
					),
					Tween24.tween(gravity,0.3,Ease24._1_SineIn).alpha(0).scaleXY(2,2),
					Tween24.tween(screen,0.5,Ease24._3_CubicIn).alpha(0)
				)
			);
			
			return Tween24.parallel(tween);
		}

		private function addCircleTween(reverse:Boolean = false):Tween24
		{
			var circle1:Image = new Image(Texture.fromBitmap(new CircleEffectImage()));
			circle1.x = stage.stageWidth >> 1;
			circle1.y = 120;
			circle1.pivotX = circle1.width >> 1;
			circle1.pivotY = circle1.height >> 1;
			addChild(circle1);
			circle1.scaleY = 0.3;
			circle1.scaleX = 5;
			circle1.alpha = 0;
			circle1.rotation = (reverse) ? 0.5 : -0.5;
			circle1.filter = BlurFilter.createGlow(0xFF00FF,0.8,4);

			var circle2:Image = new Image(Texture.fromBitmap(new CircleEffectImage()));
			circle2.x = stage.stageWidth >> 1;
			circle2.y = 120;
			circle2.pivotX = circle2.width >> 1;
			circle2.pivotY = circle2.height >> 1;
			addChild(circle2);
			circle2.scaleY = 0.3;
			circle2.scaleX = 5;
			circle2.alpha = 0;
			circle2.rotation = (reverse) ? -0.5 : 0.5;
			circle2.filter = BlurFilter.createGlow(0xFF00FF,0.8,4);
	
			return Tween24.parallel(
				Tween24.tween(circle1,0.5,Ease24._4_QuartOut).scaleXY(0,0).alpha(0.9),
				Tween24.tween(circle2,0.5,Ease24._4_QuartOut).scaleXY(0,0).alpha(0.9).delay(0.2)
			);
		}
		
	}
}