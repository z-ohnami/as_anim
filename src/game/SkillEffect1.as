package game
{
	import a24.tween.Tween24;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.events.Event;
	
	public class SkillEffect1 extends SkillEffectBase
	{
		[Embed(source = '../../res/img/skill_slash.png')]
		private static var SkillSlashImage:Class;

		public function SkillEffect1()
		{
			//set skill title
			super('乱舞の太刀');			
			addEventListener(Event.ADDED_TO_STAGE,init);
			
		}
		
		private function init(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			_effectTween = setTween();
		}
		
		private function setTween():Tween24
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
					//slash scaling
					Tween24.serial(
						Tween24.prop(skillImage).scaleXY(1 * setting.scaleOffset,1 * setting.scaleOffset).rotation(setting.rotation),
						Tween24.tween(skillImage,0.1).scaleXY(1 * setting.scaleOffset,1 * setting.scaleOffset),
						Tween24.tween(skillImage,0.1).scaleXY(1.1 * setting.scaleOffset,1.1 * setting.scaleOffset),
						Tween24.wait(0.05)
					),
					//slash display
					Tween24.serial(
						Tween24.tween(skillImage,0.1).alpha(0.7),
						Tween24.tween(skillImage,0.1).alpha(1.0),
						Tween24.tween(skillImage,0.6).alpha(0)
					),
					//slash moving
					Tween24.serial(
						Tween24.tween(skillImage,0.3).$xy(setting.mx,setting.my),
						damageEnemyTween()
					)

				).delay(delayTime));

				delayTime += 0.08;
			}

			return Tween24.parallel(tween);
		}
		
	}
}