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

			//single play entry
//			var animation:GouseiAnimation = new GouseiAnimation();
//			var animation:EvoAnimation = new EvoAnimation();
//			var animation:RaidStartAnimation = new RaidStartAnimation();
//			var animation:LoginBonusAnimation = new LoginBonusAnimation();
			var animation:LevelUpAnimation = new LevelUpAnimation();
//			var animation:SkillAnimation1 = new SkillAnimation1();

			addChild(animation);
			animation.start(
				function():void {
					removeChild(animation);
				}
			);
			

			// all play entry
//			var sheet:Quad = new Quad(stage.stageWidth,stage.stageHeight,0x000000);
//			sheet.alpha = 0;
//			addChild(sheet);
//			classArray = [
//				GouseiAnimation,
//				EvoAnimation,
//				RaidStartAnimation,
//				LevelUpAnimation,
//				LoginBonusAnimation,
//				SkillAnimation1,
//				SkillAnimation2,
//				SkillAnimation3,
//				SkillAnimation4,
//				SkillAnimation5
//			];
//
//			sheet.addEventListener(TouchEvent.TOUCH,onTouch);
			
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