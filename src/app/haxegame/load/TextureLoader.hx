package haxegame.load;
import flash.xml.XML;
import flash.display.BitmapData;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.events.Event;
import flash.display.Loader;
class TextureLoader
{
	public var xmlLoader(default, null):URLLoader;
	public var pngLoader(default, null):Loader;
	private var loaded:Bool;
	private static inline var TEXTURE_DIRECTORY = "texture/";
	private static inline var XML_FILE = TEXTURE_DIRECTORY + "view.xml";
	private static inline var PNG_FILE = TEXTURE_DIRECTORY + "view.png";

	private var mainFunction:Void->Void;
	public function new()
	{
		xmlLoader = new URLLoader();
		xmlLoader.addEventListener(Event.COMPLETE, onLoadComplete);

		pngLoader = new Loader();
		pngLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
	}
	private function onLoadComplete(event:Event){
		loaded = true;
	}

	//
	public function run()
	{
		mainFunction();
	}
	public function execute()
	{
		xmlLoader.load(new URLRequest(XML_FILE));
		mainFunction = loadXml;
	}
	private function loadXml()
	{
		if(!loaded) return;

		loaded = false;
		pngLoader.load(new URLRequest(PNG_FILE));
		mainFunction = loadPng;
	}
	private function loadPng()
	{
		if(loaded)
			mainFunction = finish;
	}
	private function finish(){}
	public function isFinished():Bool
		return Reflect.compareMethods(mainFunction, finish);

	public function destroy()
	{
		xmlLoader.removeEventListener(Event.COMPLETE, onLoadComplete);
		pngLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);
	}

	public function getXml():XML
	{
		return new XML(xmlLoader.data);
	}

	public function getBitmapData():BitmapData
	{
		var displayObject = pngLoader;
		var bitmapData = new BitmapData(Std.int(displayObject.width), Std.int(displayObject.height));
		bitmapData.draw(displayObject);
		return bitmapData;
	}
}
