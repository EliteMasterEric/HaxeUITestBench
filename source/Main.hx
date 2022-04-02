package;

import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	final MAX_FPS = 300;

	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, PlayState, 1.0, MAX_FPS, MAX_FPS, false, false));

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
