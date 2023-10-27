package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import haxe.ui.backend.flixel.UIRuntimeState;
import haxe.ui.components.Button;
import haxe.ui.components.CheckBox;
import haxe.ui.components.TextField;
import haxe.ui.containers.TabView;
import haxe.ui.containers.dialogs.Dialogs;
import haxe.ui.containers.menus.MenuBar;
import haxe.ui.containers.menus.MenuCheckBox;

@:build(haxe.ui.RuntimeComponentBuilder.build("assets/data/main.xml"))
class RuntimeMenuState extends UIRuntimeState
{
	var menuBG:FlxSprite;

	// These components are bound on instantiation by the build macro.
	public var menubar:MenuBar;
	public var menuCheck:MenuCheckBox;
	public var tabView1:TabView;
	public var buttonPage1:Button;
	public var buttonPage2:Button;
	public var buttonPage3:Button;
	public var buttonPage4:Button;
	public var textfieldPage1:TextField;
	public var checkboxPage1:CheckBox;

	public override function create():Void
	{
		buildBackground();

		super.create();
	}

	public override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.F5)
		{
			FlxG.resetState();
		}
	}

	function buildBackground():Void
	{
		menuBG = new FlxSprite(0, 0).loadGraphic(AssetPaths.menuDesat__png);
		menuBG.color = 0xFF0047AB;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.scrollFactor.set(0, 0);
		add(menuBG);
	}

	@:bind(buttonPage1, MouseEvent.CLICK)
	public function onClickButtonPage1(_)
	{
		trace("Clicked Page 1!");
		openSubState(new TestSubState());
	}

	@:bind(buttonPage2, MouseEvent.CLICK)
	public function onClickButtonPage2(_)
	{
		trace("Clicked Page 2!");
		Dialogs.openBinaryFile('Open Instrumental', [{label: 'OGG Audio File', extension: 'ogg'}], onSelectedFilePage2);
	}

	function onSelectedFilePage2(info:SelectedFileInfo):Void
	{
		trace('File selected! ${info.name} (${info.fullPath}) (Binary? ${info.isBinary} ${info.bytes.length} bytes)');
	}

	@:bind(buttonPage3, MouseEvent.CLICK)
	public function onClickButtonPage3(_)
	{
		trace("Clicked Page 3!");
	}

	@:bind(buttonPage4, MouseEvent.CLICK)
	public function onClickButtonPage4(_)
	{
		trace("Clicked Page 4!");
	}

	@:bind(textfieldPage1, MouseEvent.CLICK)
	public function onChangeTextFieldPage1(_)
	{
		trace('Textfield now reads: ${textfieldPage1.value}!');
	}

	@:bind(checkboxPage1, MouseEvent.CLICK)
	public function onChangeCheckBoxPage1(_)
	{
		trace('Checkbox is now: ${checkboxPage1.value}!');
	}
}

class TestSubState extends FlxSubState
{
	public override function create():Void
	{
		super.create();

		var menuBG = new FlxSprite(0, 0).loadGraphic(AssetPaths.menuDesat__png);
		menuBG.color = 0xFFAB4700;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.scrollFactor.set(0, 0);
		add(menuBG);
	}

	public override function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (FlxG.keys.justPressed.SPACE)
		{
			this.close();
		}
	}
}
