package game
{
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	
	public class Game extends Sprite
	{
		public function Game()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,init);
		}

		private var classArray:Array;
		private var _isPlay:Boolean = false;
		
		private function init():void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			stage.color = 0x000000;
			
			var sheet:Quad = new Quad(stage.stageWidth,stage.stageHeight,0x000000);
			sheet.alpha = 0;
			addChild(sheet);
			
//			var animation:GouseiAnimation = new GouseiAnimation(new GouseiAnimationData());
//			var animation:EvoAnimation = new EvoAnimation(new EvoAnimationData());
//			var animation:RaidStartAnimation = new RaidStartAnimation();
//			var animation:LoginBonusAnimation = new LoginBonusAnimation();
			var animation:LevelUpAnimation = new LevelUpAnimation();
//			var animation:SkillAnimation = new SkillAnimation(new DeckCardData(),new SkillEffect5() as SkillEffectBase);

//			addChild(animation);
//			animation.start(
//				function():void {
//					removeChild(animation);
//					trace('finished');
//				}
//			);
			
			
			classArray = [
				LevelUpAnimation,
				LoginBonusAnimation
			];

			sheet.addEventListener(TouchEvent.TOUCH,onTouch);
			
//			playAnimation();
			
		}

		private function onTouch(event:TouchEvent):void{
			var touchEnd:Touch = event.getTouch(stage, TouchPhase.ENDED);
			if (_isPlay == false && touchEnd) {
				_isPlay = true;
				playAnimation();
			}
		}
		
		private function playAnimation():void
		{

			var className:Class = classArray.shift();
			var animation:Animation = new className() as Animation;
			
			addChild(animation);
			animation.start(
				function():void {
					removeChild(animation);
					trace('finished');
					if(classArray.length > 0) {
						playAnimation();
					}
					
					if(classArray.length <= 0) {
						_isPlay = false;
					}
					
				}
			);
			
		}
		
	}
}