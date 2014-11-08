package haxegame.player;

import starling.display.DisplayObjectContainer;
import starling.display.MovieClip;
import haxegame.util.StarlingMovieClip;
import haxegame.util.StarlingMovieClipCreator;
import haxegame.texture.SpriteSheetKey;

using haxegame.util.StarlingMovieClip;

class Player
{
	private var movieClip:MovieClip;
	private var currentFrame:Int;
	private var totalFrames:Int;
	private var layer:DisplayObjectContainer;
	private var starlingMovieClip:StarlingMovieClip;

	public function new(layer:DisplayObjectContainer, layout:Layout)
	{
		this.layer = layer;

		starlingMovieClip = StarlingMovieClipCreator.create(Player, SpriteSheetKey.ONE, "walk", layout.player);
		starlingMovieClip.setScale(2, 2);

		initialize();
	}
	public function initialize()
	{
		starlingMovieClip.gotoFirstFrame();
	}
	public function show()
	{
		layer.add(starlingMovieClip);
	}
	public function run()
	{
		starlingMovieClip.loopFrame();
	}
	public function draw()
	{
		starlingMovieClip.draw();
	}
	public function hide()
	{
		layer.remove(starlingMovieClip);
	}
}
