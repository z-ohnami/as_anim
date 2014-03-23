package game
{
	import a24.tween.Tween24;
	
	import starling.display.Sprite;

	public class SkillEffectBase extends Sprite
	{
		protected var _skillEffectName:String;
		protected var _effectTween:Tween24;
		
		public function SkillEffectBase(effectName:String):void
		{
			_skillEffectName = effectName;
		}
		
		public function get skillEffectName():String
		{
			return _skillEffectName;
		}
	
		public function get effectTween():Tween24
		{
			return _effectTween;
		}

		protected function set effectTween(tween:Tween24):void
		{
			_effectTween  = tween;
		}
		
	}
}