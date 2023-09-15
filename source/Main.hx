package;

import debug.MemoryCounter;
import flixel.FlxGame;
import flixel.graphics.FlxGraphic;
import haxe.ui.Toolkit;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	final MAX_FPS = 300;

	public function new()
	{
		super();

		// Couldn't solve a bug earlier without doing this.
		FlxGraphic.defaultPersist = true;

		// Make sure to do this!
		// If you don't you end up with zero-width components in your HaxeUI.
		Toolkit.init();
		Toolkit.theme = 'dark';

		// addChild(new FlxGame(0, 0, RuntimeMenuState, MAX_FPS, MAX_FPS, false, false));
		addChild(new FlxGame(0, 0, RuntimeMenuSubState.RuntimeMenuSubStateParent, MAX_FPS, MAX_FPS, false, false));

		buildDebugDisplay();
	}

	function buildDebugDisplay()
	{
		var fpsCounter = new FPS(10, 3, 0xFFFFFF);
		addChild(fpsCounter);

		var memoryCounter = new MemoryCounter(10, 13, 0xFFFFFF);
		addChild(memoryCounter);
	}
}
