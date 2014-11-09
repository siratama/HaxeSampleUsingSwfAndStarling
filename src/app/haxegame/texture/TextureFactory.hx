package haxegame.texture;
import haxegame.load.TextureLoaderSet;
import flash.Vector;
import starling.textures.TextureAtlas;
import starling.textures.Texture;
import flash.display.Bitmap;
import flash.xml.XML;
import flash.display.BitmapData;
class TextureFactory
{
	private static inline var SPRITESHEET_FOLDER = "spritesheet";
	private var atlasMap:Map<String, TextureAtlas>;
	private var textureLoaderSet:TextureLoaderSet;

	public function initialize(textureLoaderSet:TextureLoaderSet)
	{
		this.textureLoaderSet = textureLoaderSet;

		add(SpriteSheetKey.ONE);
		//add(SpriteSheetKey.TWO);
	}
	private function add(spritesheetKey:SpriteSheetKey)
	{
		var textureLoader = textureLoaderSet.getTextureLoader(spritesheetKey);

		var bitmapData = textureLoader.getBitmapData();
		var bitmap = new Bitmap(bitmapData);
		var texture = Texture.fromBitmap(bitmap);

		atlasMap[cast(spritesheetKey, String)] = new TextureAtlas(texture, textureLoader.getXml());
		bitmapData.dispose();
	}

	//
	public function getTextures(packageClass:Class<Dynamic>, spritesheetKey:SpriteSheetKey, key:String):flash.Vector<Texture>
	{
		var packages = Type.getClassName(packageClass).split(".");
		packages.shift();
		packages.pop();
		var name = SPRITESHEET_FOLDER + spritesheetKey + "/" + packages.join("/") + "/" + key;
		return cast(atlasMap[cast(spritesheetKey, String)], TextureAtlas).getTextures(name);
	}

	//singleton
	private static var instance:TextureFactory;
	public static inline function getInstance():TextureFactory
	{
		if(instance == null) instance = new TextureFactory();
		return instance;
	}
	private function new()
	{
		atlasMap = new Map();
	}
}
