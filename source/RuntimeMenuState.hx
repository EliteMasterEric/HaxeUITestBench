package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFrame;
import haxe.ui.containers.ListView;
import haxe.ui.core.Component;
import haxe.ui.macros.ComponentMacros;

class RuntimeMenuState extends HaxeUIState // extends MusicBeatState
{
	public function new()
	{
		super('assets/data/two-lists.xml');
	}

	override function create()
	{
		buildBackground();
		super.create();
	}

	var componentDisabled:Bool = false;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.SPACE)
		{
			if (componentDisabled)
			{
				this.add(component);
			}
			else
			{
				this.remove(component);
			}
		}
	}

	var menuBG:FlxSprite;

	function buildBackground()
	{
		menuBG = new FlxSprite(0, 0).loadGraphic(AssetPaths.menuDesat__png);
		add(menuBG);
		menuBG.color = 0xFF0047AB;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.scrollFactor.set(0, 0);
	}
}
