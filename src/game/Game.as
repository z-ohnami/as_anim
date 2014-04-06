package game
{
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.display.Quad;
	
	
	public class Game extends Sprite
	{
		public function Game()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,init);
		}

		private var _classArray:Array;
		private var _isPlay:Boolean = false;
		
		private var _start:TextField;
		private var _end:TextField;

		private var _current:int = 1;
		private var _total:int = 0;
		
		private function init():void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			stage.color = 0x000000;

			//single play entry
//			var animation:GouseiAnimation = new GouseiAnimation();
//			var animation:EvoAnimation = new EvoAnimation();
//			var animation:RaidStartAnimation = new RaidStartAnimation();
//			var animation:LoginBonusAnimation = new LoginBonusAnimation();
//			var animation:LevelUpAnimation = new LevelUpAnimation();
			var animation:SkillAnimation3 = new SkillAnimation3();
//
			addChild(animation);
			animation.start(
				function():void {
					removeChild(animation);
				}
			);

			// all play entry
//			createText();
//			var sheet:Quad = new Quad(stage.stageWidth,stage.stageHeight,0x000000);
//			sheet.alpha = 0;
//			addChild(sheet);
//			_classArray = [
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
//			_total = _classArray.length;
//			
//			sheet.addEventListener(TouchEvent.TOUCH,onTouch);
			
		}

		private function createText():void
		{
			_start = new TextField(stage.stageWidth,80,'大波コレクション','Verdana',24,0xFFFFFF);
			_start.hAlign = 'center';
			_start.x = 0;
			_start.y = (stage.stageHeight - _start.height) >> 1;
			addChild(_start);

			_end = new TextField(stage.stageWidth,80,'おしまい','Verdana',24,0xFFFFFF);
			_end.hAlign = 'center';
			_end.x = 0;
			_end.y = (stage.stageHeight - _end.height) >> 1;
			_end.alpha = 0;
			addChild(_end);
			
		}
		
		private function onTouch(event:TouchEvent):void{
			var touchEnd:Touch = event.getTouch(stage, TouchPhase.ENDED);
			if (_isPlay == false && touchEnd) {
				_isPlay = true;
				_start.alpha = 0;
				playAnimation();
			}
		}
		
		private function playAnimation():void
		{

			var className:Class = _classArray.shift();
			var animation:Animation = new className() as Animation;
			
			addChild(animation);
			animation.start(
				function():void {
					removeChild(animation);
					if(_classArray.length > 0) {
						_current++;
						playAnimation();
					}
					
					if(_classArray.length <= 0) {
						_isPlay = false;
						_end.alpha = 1;
					}
					
				},
				_current,_total
			);
			
		}
		
	}
}