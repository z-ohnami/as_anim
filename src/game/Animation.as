package game
{
	import a24.tween.Tween24;
	import a24.tween.events.Tween24Event;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class Animation extends Sprite
	{
		
		protected var _rootTween:Tween24;
		protected var _title:String;
		
		private var _titleText:TextField;
		private var _black:Quad;
		
		public function Animation()
		{
			super();
		}
		
		public function start(onTweenComplete:Function,current:int = 0,total:int = 0):void
		{
			_rootTween.addEventListener(Tween24Event.COMPLETE,onTweenComplete);

			_black = new Quad(stage.stageWidth,stage.stageHeight,0x000000);
			addChild(_black);
			
			var text:String = '[作品名]\n' + _title + '\n' + current + '/' + total;
			
			_titleText = new TextField(stage.stageWidth,80,text,'Verdana',20,0xFFFFFF);
			_titleText.hAlign = 'center';
			_titleText.x = (stage.stageWidth - _titleText.width) >> 1;
			_titleText.y = (stage.stageHeight - _titleText.height) >> 1;
			addChild(_titleText);

			Tween24.serial(
				Tween24.tween(_titleText,0.2).alpha(1),
				Tween24.wait(1),
				Tween24.func(hidePrompt),
				_rootTween,
				Tween24.wait(0.7)
			).play();
			
		}

		private function hidePrompt():void
		{
			removeChild(_titleText);
			removeChild(_black);
		}
		
	}
}