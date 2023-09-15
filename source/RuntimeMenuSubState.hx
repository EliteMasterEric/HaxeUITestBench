package;

import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxFrame;
import haxe.ui.components.Button;
import haxe.ui.components.CheckBox;
import haxe.ui.components.TextField;
import haxe.ui.containers.Form;
import haxe.ui.containers.ListView;
import haxe.ui.containers.SideBar;
import haxe.ui.containers.VBox;
import haxe.ui.containers.dialogs.Dialog;
import haxe.ui.containers.menus.MenuCheckBox;
import haxe.ui.core.Component;
import haxe.ui.events.UIEvent;
import haxe.ui.macros.ComponentMacros;
import lime.app.Future;
import openfl.Assets;
import openfl.display.BitmapData;

class RuntimeMenuSubState extends HaxeUISubState // extends MusicBeatState
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

		var testForm:Form = component.findComponent("testForm", Form);
		var testFormValue:TextField = component.findComponent("testFormValue", TextField);
		var testFormSubmit:Button = component.findComponent("testFormSubmit", Button);

		testFormSubmit.onClick = function(event:UIEvent)
		{
			trace('Clicked form button');
			testForm.submit();
		}

		testForm.onSubmit = function(event:UIEvent)
		{
			trace('Form submitted! Value: ${testFormValue.text}');
		}

		testForm.onInvalidData = function(event:UIEvent)
		{
			trace('Invalid data!');
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

		if (FlxG.keys.justPressed.D)
		{
			var dialog:Dialog = cast this.buildComponent("assets/data/dialog.xml");
			dialog.destroyOnClose = false;
			dialog.closable = true;
			dialog.showDialog(true);
		}

		if (FlxG.keys.justPressed.C)
		{
			var future:Future<BitmapData> = Assets.loadBitmapData('assets/images/cursor-default.png');
			future.onComplete(function(bitmapData:BitmapData)
			{
				FlxG.mouse.load(bitmapData, 1.0, 0, 0);
			});
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

/**
 * All this state does is launch the substate.
 */
class RuntimeMenuSubStateParent extends FlxState
{
	public function new()
	{
		super();
	}

	var secondCamera:FlxCamera;

	public override function create():Void
	{
		super.create();

		openSubState(new RuntimeMenuSubState());
	}
}
