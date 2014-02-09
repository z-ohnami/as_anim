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
		
		public function ImageLoader(url:String)
		{
			super();
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.INIT,init);
			_loader.load(new URLRequest(url));
		}
		
		private function init(event:Event):void
		{
			var bitmap:Bitmap = event.currentTarget.loader.content as Bitmap;
			addChild(new Image(Texture.fromBitmap(bitmap)));
		}
		
	}
}