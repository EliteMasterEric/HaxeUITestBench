import flixel.FlxState;
import flixel.FlxSubState;
import haxe.ui.RuntimeComponentBuilder;
import haxe.ui.components.CheckBox;
import haxe.ui.containers.menus.MenuCheckBox;
import haxe.ui.core.Component;
import haxe.ui.events.UIEvent;

class HaxeUIState extends FlxState
{
	public var component:Component;

	var _componentKey:String;

	public function new(key:String)
	{
		super();
		_componentKey = key;
	}

	override function create()
	{
		super.create();

		if (component == null)
			component = buildComponent();
		if (component != null)
			add(component);

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

	public function buildComponent(assetPath:String = null)
	{
		if (assetPath == null)
			assetPath = _componentKey;
		return RuntimeComponentBuilder.fromAsset(assetPath);
	}

	override function destroy()
	{
		if (component != null)
			remove(component);
		component = null;
	}
}
