package game
{
	import a24.tween.Tween24;
	
	import starling.display.Sprite;

	public class SkillEffectBase extends Sprite
	{
		protected var _skillEffectName:String;
		protected var _effectTween:Tween24;

		protected var _enemyDeck:Vector.<ImageLoader>;		
		
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

		public function set enemyDeck(deck:Vector.<ImageLoader>):void
		{
			_enemyDeck = deck;
		}
		
		protected function damageEnemyTween():Tween24
		{
			var tween:Array = [];
			
			var offsetArray:Array = [
				{'x':2,'y':2},
				{'x':2,'y':1},
				{'x':1,'y':2},
				{'x':3,'y':3},
				{'x':3,'y':1},
				{'x':1,'y':3},
				{'x':4,'y':4},
				{'x':2,'y':4},
				{'x':4,'y':2},
			]

			var offsetLength:int = offsetArray.length;
				
			var enemyLength:int = _enemyDeck.length;
			for(var i:int = 0;i < enemyLength;i++) {
				var offset:Object = offsetArray[Util.getRandomRange(0,offsetLength-1)];
				tween.push(
					Tween24.serial(
						Tween24.tween(_enemyDeck[i],0.1).$xy(offset.x,offset.y),
						Tween24.tween(_enemyDeck[i],0.1).$xy(-1 * offset.x,-1 * offset.y)
					)
				);
			}
			
			return Tween24.parallel(tween);
		}
		
	}
}