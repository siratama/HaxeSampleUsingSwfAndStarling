package haxegame.util;
import starling.textures.TextureSmoothing;
import haxegame.texture.SpriteSheetKey;
import haxegame.texture.TextureFactory;
class StarlingMovieClipCreator
{
	public static function create(
		packageClass:Class<Dynamic>, spritesheetKey:SpriteSheetKey, key:String,
		?position:{x:Float, y:Float}, ?textureSmoothing:String, ?fps:Int
	):StarlingMovieClip{

		var textures = TextureFactory.getInstance().getTextures(packageClass, spritesheetKey, key);

		var starlingMovieClip = new StarlingMovieClip(textures, (fps == null) ? App.FPS: fps);
		starlingMovieClip.movieClip.stop();

		if(position != null)
			starlingMovieClip.setPosition(position);

		starlingMovieClip.movieClip.smoothing =
			(textureSmoothing == null) ? TextureSmoothing.NONE : textureSmoothing;

		return starlingMovieClip;
	}
}
