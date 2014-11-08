package haxegame.util;
import starling.core.Starling;
import starling.display.DisplayObjectContainer;
import starling.textures.Texture;
import starling.display.MovieClip;
class StarlingMovieClip
{
	public var movieClip(default, null):MovieClip;
	public var currentFrame(default, null):Int;
	public var totalFrames(default, null):Int;
	public static var FIRST_FRAME(default, null) = 0;

	public function new(textures:flash.Vector<Texture>, fps:Int)
	{
		movieClip = new MovieClip(textures, fps);
		currentFrame = FIRST_FRAME;
		totalFrames = movieClip.numFrames - 1;
	}
	public function addChild(layer:DisplayObjectContainer)
	{
		Starling.juggler.add(movieClip);
		layer.addChild(movieClip);
	}
	public static function add(layer:DisplayObjectContainer, starlingMovieClip:StarlingMovieClip)
	{
		starlingMovieClip.addChild(layer);
	}
	public function removeChild(layer:DisplayObjectContainer)
	{
		Starling.juggler.remove(movieClip);
		layer.removeChild(movieClip);
	}
	public static function remove(layer:DisplayObjectContainer, starlingMovieClip:StarlingMovieClip)
	{
		starlingMovieClip.removeChild(layer);
	}
	public function gotoFirstFrame()
	{
		currentFrame = FIRST_FRAME;
	}
	public function nextFrame()
	{
		if(currentFrame < totalFrames)
			currentFrame++;
	}
	public function loopFrame()
	{
		if(currentFrame < totalFrames)
			currentFrame++;
		else
			currentFrame = FIRST_FRAME;
	}
	public function isLastFrame():Bool
	{
		return currentFrame == totalFrames;
	}

	public function setXY(x:Float, y:Float)
	{
		movieClip.x = x;
		movieClip.y = y;
	}
	public function setPosition(position:{x:Float, y:Float})
	{
		setXY(position.x, position.y);
	}
	public function setScale(x:Float, y:Float)
	{
		movieClip.scaleX = x;
		movieClip.scaleY = y;
	}
	
	public function draw()
	{
		movieClip.currentFrame = currentFrame;
	}
}
