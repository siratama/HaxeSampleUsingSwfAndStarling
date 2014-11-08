package haxegame;

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
	private var textureLoader:TextureLoader;

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
		textureLoader = new TextureLoader();
		textureLoader.execute();
		mainFunction = loadTexture;
	}
	private function loadTexture()
	{
		textureLoader.run();
		if(!textureLoader.isFinished()) return;
		textureLoader.destroy();

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
		TextureFactory.getInstance().initializeField(textureLoader.getXml(), textureLoader.getBitmapData());
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


