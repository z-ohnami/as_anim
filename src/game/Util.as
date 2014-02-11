package game
{
	public class Util
	{
		public function Util()
		{
		}
		
		public static function getRandomRange(min:int = 0,max:int=0):int
		{

			var random:int = Math.floor(Math.random()*(max-min+1))+min; 
			return random;
		}
		
	}
}