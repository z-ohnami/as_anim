package game
{
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class ImageLoader extends Sprite
	{
		private var _loader:Loader;
		private var _width:Number = 0;
		private var _height:Number = 0;
		
		public function ImageLoader(url:String,w:Number = 0,h:Number = 0)
		{
			super();

			_width = w;
			_height = h;
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.INIT,init);
			_loader.load(new URLRequest(url));
		}
		
		private function init(event:Event):void
		{
			var bitmap:Bitmap = event.currentTarget.loader.content as Bitmap;
			addChild(new Image(Texture.fromBitmap(bitmap)));
		}

		override public function get width():Number
		{
			return _width;
		}

		override public function get height():Number
		{
			return _height;
		}
		
	}
}