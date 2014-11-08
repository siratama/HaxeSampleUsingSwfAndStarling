package haxegame.load;
import flash.net.URLRequest;
import flash.events.Event;
import flash.display.Loader;
class SwfLoader
{
	private static inline var ASSETS_SWF = "view.swf";
	private var loader:Loader;
	public var loaded(default, null):Bool;

	private var mainFunction:Void->Void;
	public function new()
	{
		loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
	}
	private function onLoadComplete(event:Event){
		loaded = true;
	}
	public function execute()
	{
		loader.load(new URLRequest(ASSETS_SWF));
	}
	public function destroy()
	{
		loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);
	}

	public function run()
	{
		mainFunction();
	}
	private function finish(){}
	public function isFinished():Bool
		return Reflect.compareMethods(mainFunction, finish);
}
