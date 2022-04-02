package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.text.FlxText;
import haxe.ui.core.Component;
import haxe.ui.macros.ComponentMacros;

class PlayState extends FlxState
{
	var bfSprite:FlxSprite;
	var gfSprite:FlxSprite;
	var dadSprite:FlxSprite;

	var stageBg:FlxSprite;
	var stageFg:FlxSprite;
	var stageCurtains:FlxSprite;

	var userInterface:Component;

	override public function create()
	{
		super.create();

		buildGameStage();
		buildInterface();

		// FlxG.camera.zoom = 0.6;
	}

	/**
	 * Literally just ripped from the Funkin repo.
	 */
	function buildGameStage()
	{
		FlxG.sound.playMusic(AssetPaths.Inst__ogg);

		stageBg = new FlxSprite(-600, -200).loadGraphic(AssetPaths.stageback__png);
		stageBg.antialiasing = true;
		stageBg.scrollFactor.set(0.9, 0.9);
		// active = false means the update function won't be called
		stageBg.active = false;
		add(stageBg);

		stageFg = new FlxSprite(-650, 600).loadGraphic(AssetPaths.stagefront__png);
		stageFg.setGraphicSize(Std.int(stageFg.width * 1.1));
		stageFg.updateHitbox();
		stageFg.antialiasing = true;
		stageFg.scrollFactor.set(0.9, 0.9);
		stageFg.active = false;
		add(stageFg);

		stageCurtains = new FlxSprite(-500, -300).loadGraphic(AssetPaths.stagecurtains__png);
		stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
		stageCurtains.updateHitbox();
		stageCurtains.antialiasing = true;
		stageCurtains.scrollFactor.set(1.3, 1.3);
		stageCurtains.active = false;
		add(stageCurtains);

		// Girlfriend
		gfSprite = new FlxSprite(400, 130);
		gfSprite.frames = FlxAtlasFrames.fromSparrow(AssetPaths.GIRLFRIEND__png, AssetPaths.GIRLFRIEND__xml);
		gfSprite.animation.addByIndices("idle", "GF Dancing Beat", [for (i in 0...29) i], "", 24, true);
		gfSprite.scrollFactor.set(0.95, 0.95);
		gfSprite.antialiasing = true;
		add(gfSprite);
		gfSprite.animation.play("idle");

		// Boyfriend
		bfSprite = new FlxSprite(770, 450);
		bfSprite.frames = FlxAtlasFrames.fromSparrow(AssetPaths.BOYFRIEND__png, AssetPaths.BOYFRIEND__xml);
		bfSprite.animation.addByPrefix("idle", "BF idle dance", 24, true);
		bfSprite.scrollFactor.set(1, 1);
		bfSprite.antialiasing = true;
		add(bfSprite);
		bfSprite.animation.play("idle");

		// Dad
		dadSprite = new FlxSprite(100, 100);
		dadSprite.frames = FlxAtlasFrames.fromSparrow(AssetPaths.DADDY_DEAREST__png, AssetPaths.DADDY_DEAREST__xml);
		dadSprite.animation.addByPrefix("idle", "Dad idle dance", 24, true);
		dadSprite.scrollFactor.set(1, 1);
		dadSprite.antialiasing = true;
		add(dadSprite);
		dadSprite.animation.play("idle");
	}

	/**
	 * Builds the user interface from XML.
	 */
	function buildInterface()
	{
		// Problem: The user interface elements zoom in and out with the scene.
		// Solution? Put them on their own camera!
		var cameraHUD = new FlxCamera();
		FlxG.cameras.add(cameraHUD, false); // False means don't add objects by default.
		cameraHUD.bgColor.alpha = 0; // Make the background transparent.

		userInterface = ComponentMacros.buildComponent("assets/data/interface.xml");
		userInterface.width = FlxG.width - 100;
		userInterface.height = FlxG.height - 100;
		userInterface.x = 50;
		userInterface.y = 50;
		userInterface.cameras = [cameraHUD];
		toggleInterface();

		var helpText:FlxText = new FlxText(0, 0, FlxG.width, "R: Reset State    SPACE: Toggle Interface    Z/X: Zoom");
		helpText.setFormat(null, 24, 0xffffffff);
		helpText.y = FlxG.height - helpText.height;
		helpText.cameras = [cameraHUD];
		add(helpText);
	}

	var userInterfaceEnabled:Bool = false;

	function toggleInterface()
	{
		if (userInterfaceEnabled)
		{
			remove(userInterface);
			userInterfaceEnabled = false;
		}
		else
		{
			add(userInterface);
			userInterfaceEnabled = true;
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.R)
		{
			// Reset the state.
			FlxG.switchState(new PlayState());
		}

		if (FlxG.keys.justPressed.Z)
		{
			FlxG.camera.zoom += 0.1;
		}

		if (FlxG.keys.justPressed.X)
		{
			FlxG.camera.zoom -= 0.1;
		}

		if (FlxG.keys.justPressed.SPACE)
		{
			toggleInterface();
		}
	}
}
