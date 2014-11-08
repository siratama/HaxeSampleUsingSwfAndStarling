package haxegame.load;

import haxegame.texture.SpriteSheetKey;

class TextureLoaderSet
{
	public var map(default, null):Map<String, TextureLoader>;
	private var set:Array<TextureLoader>;
	private var copySet:Array<TextureLoader>;
	private var mainFunction:Void->Void;
	private var loadingTextureLoader:TextureLoader;

	public function new()
	{
		map = new Map();
		set = [];

		create(SpriteSheetKey.ONE, "view");
		//create(SpriteSheetKey.TWO, "view2");

		copySet = set.copy();
		mainFunction = initializeToLoad;
	}
	private function create(spriteSheetKey:SpriteSheetKey, fileName:String)
	{
		var textureLoader = new TextureLoader(fileName);
		map[cast(spriteSheetKey, String)] = textureLoader;
		set.push(textureLoader);
	}
	public function run()
	{
		mainFunction();
	}
	private function initializeToLoad()
	{
		loadingTextureLoader = copySet.shift();
		loadingTextureLoader.execute();
		mainFunction = load;
	}
	private function load()
	{
		loadingTextureLoader.run();
		if(!loadingTextureLoader.isFinished()) return;

		if(copySet.length > 0)
			initializeToLoad();
		else
			mainFunction = finish;
	}
	private function finish(){}
	public function isFinished():Bool
		return Reflect.compareMethods(mainFunction, finish);

	public function destroy()
	{
		for (textureLoader in copySet)
			textureLoader.destroy();
	}

	public function getTextureLoader(spriteSheetKey:SpriteSheetKey):TextureLoader
	{
		return map[cast(spriteSheetKey, String)];
	}
}
