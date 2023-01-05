package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFrame;
import haxe.ui.components.Button;
import haxe.ui.components.CheckBox;
import haxe.ui.containers.ListView;
import haxe.ui.containers.SideBar;
import haxe.ui.containers.menus.MenuCheckBox;
import haxe.ui.core.Component;
import haxe.ui.events.UIEvent;
import haxe.ui.macros.ComponentMacros;

class RuntimeMenuState extends HaxeUIState // extends MusicBeatState
{
	public function new()
	{
		super('assets/data/modmenu.xml');
	}

	override function create()
	{
		buildBackground();
		super.create();

		addListeners();

		buildNotifbar();
	}

	var notifbar:Notifbar;

	function buildNotifbar()
	{
		notifbar = new Notifbar();

		add(notifbar);
	}

	function addListeners():Void
	{
		var menuCheckBox:MenuCheckBox = component.findComponent("menuCheck", MenuCheckBox);

		menuCheckBox.onChange = function(event:UIEvent)
		{
			trace('Changed: ${event.value}');
		}

		var baseCheckBox:CheckBox = component.findComponent("baseCheck", CheckBox);

		baseCheckBox.onChange = function(event:UIEvent)
		{
			trace('Changed: ${event.value}');
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.SPACE)
		{
			if (this.members.contains(component))
			{
				this.remove(component);
			}
			else
			{
				this.add(component);
			}
		}

		if (FlxG.keys.justPressed.F5)
		{
			this.remove(component);
			component = buildComponent(_componentKey);
			this.add(component);
		}

		if (FlxG.keys.justPressed.S)
		{
			notifbar.show();
		}

		if (FlxG.keys.justPressed.H)
		{
			notifbar.hide();
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
