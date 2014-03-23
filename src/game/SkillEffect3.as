package game
{
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class SkillEffect3 extends SkillEffectBase
	{
		[Embed(source = '../../res/img/skill_aqua.png')]
		private static var SkillAquaImage:Class;

		[Embed(source = '../../res/img/aquaball.png')]
		private static var AquaBallImage:Class;
		
		public function SkillEffect3()
		{
			//set skill title
			super('アクアフレッシュ');
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
//加算合成するともっと綺麗になりそう
			//main aqua
			var aqua:Image = new Image(Texture.fromBitmap(new SkillAquaImage()));
			aqua.x = stage.stageWidth >> 1;
			aqua.pivotX = aqua.width >> 1;
			aqua.y = 90;
			aqua.pivotY = aqua.height >> 1;
			aqua.alpha = 1;
			addChild(aqua);
			aqua.scaleX = 0;
			aqua.scaleY = 0;
			
			tween.push(
				Tween24.tween(aqua,1.5,Ease24._1_SineInOut).scaleXY(3,3).alpha(0).rotation(3)
			);

			var scaleArray:Array = [0.2,0.1,0.15];
			
			var num:int = 50;
			for(var i:int = 0;i < num;i++) {
				var ball:Image = new Image(Texture.fromBitmap(new AquaBallImage()));
				ball.alpha = 0;
				ball.scaleX = ball.scaleY =  scaleArray[Util.getRandomRange(0,2)];
				ball.x = Util.getRandomRange(10,300);
				ball.y = Util.getRandomRange(30,180);
				addChild(ball);

//				var speed:Number = 0.4;
//				if(i % 2 == 0) {
//					speed -= (Util.getRandomRange(1,3) * 0.1);
//				}
					
				tween.push(
					Tween24.serial(
						Tween24.tween(ball,0.6).alpha(0.6).$y(-50),
						Tween24.tween(ball,0.2).alpha(0)
					)
				);
			}
			
			return Tween24.parallel(tween);
		}
		
	}
}