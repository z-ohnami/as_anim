package game
{
	import a24.tween.Tween24;
	import a24.tween.Ease24;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class SkillEffect2 extends SkillEffectBase
	{
		[Embed(source = '../../res/img/skill_cicron.png')]
		private static var SkillCircleImage:Class;

		public function SkillEffect2()
		{
			//set skill title
			super('サイクロン');
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

			var rotatePatern:Array = [-0.2,-0.1,0.1,0,2];
			
			var num:int = 50;
			var delayTime:Number = 0;
			for(var i:int = 0;i < num;i++) {
				var ring:Image = new Image(Texture.fromBitmap(new SkillCircleImage()));
				ring.x = stage.stageWidth >> 1;
				ring.pivotX = ring.width >> 1;
				ring.y = 190;
				ring.pivotY = ring.height >> 1;
				ring.alpha = 0;
				ring.scaleY = 0.1;
				addChild(ring);
				
				ring.rotation = rotatePatern[Util.getRandomRange(0,3)];

				var speed:Number = 0.4;
				if(i % 2 == 0) {
					speed -= (Util.getRandomRange(1,3) * 0.1);
				}
					
				tween.push(
					Tween24.parallel(
						Tween24.serial(
							Tween24.prop(ring).scaleXY(0.05,0.1),
							Tween24.tween(ring,speed,Ease24._6_ExpoIn).y(20).scaleX(1.5),
							Tween24.tween(ring,0.1).alpha(0)
						),
						Tween24.tween(ring,0.4).alpha(1),
						damageEnemyTween()
					).delay(delayTime)
				);

				delayTime += 0.04;
			}
			
			return Tween24.parallel(tween);
		}
		
	}
}