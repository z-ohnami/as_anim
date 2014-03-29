package game
{
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Game extends Sprite
	{
		public function Game()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init():void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			stage.color = 0x000000;

//			var animation:GouseiAnimation = new GouseiAnimation(new GouseiAnimationData());
			var animation:EvoAnimation = new EvoAnimation(new EvoAnimationData());
//			var animation:SkillAnimation = new SkillAnimation(new DeckCardData(),new SkillEffect5() as SkillEffectBase);

			addChild(animation);
			animation.start();
			
		}
	}
}