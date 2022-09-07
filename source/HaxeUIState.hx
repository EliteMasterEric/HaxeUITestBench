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
			component = buildComponent();
		if (component != null)
			add(component);
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
