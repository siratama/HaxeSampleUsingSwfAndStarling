package haxegame;

import haxegame.load.TextureLoaderSet;
import haxegame.texture.SpriteSheetKey;
import starling.core.Starling;
import starling.display.Sprite;
import flash.display.MovieClip;
import flash.events.Event;
import flash.Lib;
import flash.display.Stage;
import haxegame.texture.TextureFactory;
import haxegame.load.TextureLoader;
import haxegame.load.SwfLoader;
import haxegame.player.Player;

class Main
{
	private var stage:Stage;
	private var root:MovieClip;
	private var mainFunction:Void->Void;
	private var starlingWorld:Starling;

	private var swfLoader:SwfLoader;
	private var textureLoaderSet:TextureLoaderSet;

	private var starlingRoot:Sprite;
	private var gameLayer:Sprite;

	private var layout:Layout;
	private var player:Player;

	public static function main(){
		new Main();
	}
	public function new()
	{
		root = flash.Lib.current;
		stage = root.stage;

		root.addEventListener(Event.ENTER_FRAME, run);
		initializeToLoadSwf();
	}
	private function run(event){
		mainFunction();
	}

	//
	private function initializeToLoadSwf()
	{
		swfLoader = new SwfLoader();
		swfLoader.execute();
		mainFunction = loadSwf;
	}
	private function loadSwf()
	{
		if(!swfLoader.loaded) return;
		swfLoader.destroy();

		initializeToLoadTexture();
	}
	private function initializeToLoadTexture()
	{
		textureLoaderSet = new TextureLoaderSet();
		mainFunction = loadTexture;
	}
	private function loadTexture()
	{
		textureLoaderSet.run();
		if(!textureLoaderSet.isFinished()) return;
		textureLoaderSet.destroy();

		initializeToLoadStarling();
	}
	private function initializeToLoadStarling()
	{
		starlingWorld = new Starling(Sprite, stage);
		starlingWorld.showStats = true;
		starlingWorld.start();

		mainFunction = loadStarling;
	}
	private function loadStarling()
	{
		if(starlingWorld.isStarted)
			initializeMain();
	}

	//
	private function initializeMain()
	{
		TextureFactory.getInstance().initialize(textureLoaderSet);
		initializeLayer();
		initializeGame();

		initializeToPlayGame();
	}
	private function initializeLayer()
	{
		starlingRoot = cast starlingWorld.root;
		gameLayer = new Sprite();
		starlingRoot.addChild(gameLayer);
	}
	private function initializeGame()
	{
		layout = new Layout();
		player = new Player(gameLayer, layout);
	}

	//
	private function initializeToPlayGame()
	{
		player.show();
		mainFunction = playGame;
	}
	private function playGame()
	{
		player.run();
		player.draw();
	}
}


