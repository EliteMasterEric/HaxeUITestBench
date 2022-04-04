import flixel.FlxState;
import flixel.FlxSubState;
import haxe.ui.RuntimeComponentBuilder;
import haxe.ui.core.Component;

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
			buildHaxeUIComponent();
		add(component);
	}

	private function buildHaxeUIComponent()
	{
		component = RuntimeComponentBuilder.fromAsset(_componentKey);
	}
}
