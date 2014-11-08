package haxegame.texture;
import flash.Vector;
import starling.textures.TextureAtlas;
import starling.textures.Texture;
import flash.display.Bitmap;
import flash.xml.XML;
import flash.display.BitmapData;
class TextureFactory
{
	private static inline var SPRITESHEET_FOLDER = "spritesheet";
	public var atlas(default, null):TextureAtlas;

	public function initializeField(xml:XML, bitmapData:BitmapData)
	{
		var bitmap = new Bitmap(bitmapData);
		var texture = Texture.fromBitmap(bitmap);

		atlas = new TextureAtlas(texture, xml);
	}
	public function getTextures(packageClass:Class<Dynamic>, spritesheetKey:SpriteSheetKey, key:String):flash.Vector<Texture>
	{
		var packages = Type.getClassName(packageClass).split(".");
		packages.shift();
		packages.pop();
		var name = SPRITESHEET_FOLDER + spritesheetKey + "/" + packages.join("/") + "/" + key;
		return atlas.getTextures(name);
	}

	//singleton
	private static var instance:TextureFactory;
	public static inline function getInstance():TextureFactory
	{
		if(instance == null) instance = new TextureFactory();
		return instance;
	}
	private function new(){}
}
