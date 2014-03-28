package game
{
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class SkillEffect4 extends SkillEffectBase
	{
		[Embed(source = '../../res/img/explosion.png')]
		private static var SkillExplosionImage:Class;

		[Embed(source = '../../res/img/circle_effect.png')]
		private static var CircleEffectImage:Class;
		
		public function SkillEffect4()
		{
			//set skill title
			super('爆風スランプ');
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
			
			var screen:Quad = new Quad(stage.stageWidth,stage.stageHeight,0xcc3333);
			screen.alpha = 0;
			
			//main
			var explosion:Image = new Image(Texture.fromBitmap(new SkillExplosionImage()));
			explosion.x = stage.stageWidth >> 1;
			explosion.pivotX = explosion.width >> 1;
			explosion.y = 140;
			explosion.pivotY = explosion.height;
			explosion.alpha = 0;
			explosion.scaleX = 0.1;
			explosion.scaleY = 0.1;

			//circle 1 white smoke
			var circle1:Image = new Image(Texture.fromBitmap(new CircleEffectImage()));
			circle1.scaleY = 0.1;
			circle1.alpha = 0;
			circle1.x = stage.stageWidth >> 1;
			circle1.y = explosion.y - 20;
			circle1.pivotX = circle1.width >> 1;
			circle1.pivotY = circle1.height >> 1;

			//circle2 blown
			var circle2:Image = new Image(Texture.fromBitmap(new CircleEffectImage()));
			circle2.scaleY = 0.1;
			circle2.alpha = 0;
			circle2.x = stage.stageWidth >> 1;
			circle2.y = explosion.y - 20;
			circle2.pivotX = circle1.width >> 1;
			circle2.pivotY = circle1.height >> 1;
			circle2.color = 0xcc6600;

			addChild(screen);
			addChild(circle1);			
			addChild(circle2);
			addChild(explosion);
			
			var adjustY:int = explosion.y + 20;
			tween.push(
				Tween24.serial(
					Tween24.tween(screen,0.5,Ease24._2_QuadOut).alpha(0.3),
					Tween24.parallel(
						Tween24.serial(
							Tween24.prop(circle1).alpha(0.7).scaleX(0.1),
							Tween24.tween(circle1,1,Ease24._1_SineOut).scaleX(3).alpha(0)
						),
						Tween24.serial(
							Tween24.prop(circle2).alpha(0.7).scaleX(0.1),
							Tween24.tween(circle2,1.8,Ease24._1_SineOut).scaleX(3).alpha(0)
						),
						Tween24.loop(20,
							Tween24.tween(explosion,0.05).$x(0.5),
							Tween24.tween(explosion,0.05).$x(-0.5)
						),
						Tween24.serial(
							Tween24.prop(explosion).alpha(1),
							Tween24.tween(explosion,2,Ease24._6_ExpoIn).scaleXY(1.5,1.5).$y(adjustY),
							Tween24.tween(explosion,0.8,Ease24._6_ExpoIn).alpha(0)
						)
					),
					Tween24.tween(screen,0.5,Ease24._3_CubicIn).alpha(0)
				)
			);

//			var scaleArray:Array = [0.2,0.1,0.15];
			
//			var num:int = 50;
//			for(var i:int = 0;i < num;i++) {
//				var ball:Image = new Image(Texture.fromBitmap(new AquaBallImage()));
//				ball.alpha = 0;
//				ball.scaleX = ball.scaleY =  scaleArray[Util.getRandomRange(0,2)];
//				ball.x = Util.getRandomRange(10,300);
//				ball.y = Util.getRandomRange(30,180);
//				addChild(ball);
//
////				var speed:Number = 0.4;
////				if(i % 2 == 0) {
////					speed -= (Util.getRandomRange(1,3) * 0.1);
////				}
//					
//				tween.push(
//					Tween24.serial(
//						Tween24.tween(ball,0.6).alpha(0.6).$y(-50),
//						Tween24.tween(ball,0.2).alpha(0)
//					)
//				);
//			}
			
			return Tween24.parallel(tween);
		}
		
	}
}