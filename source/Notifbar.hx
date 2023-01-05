package;

import haxe.ui.RuntimeComponentBuilder;
import haxe.ui.components.Button;
import haxe.ui.components.Label;
import haxe.ui.containers.Box;
import haxe.ui.containers.SideBar;
import haxe.ui.containers.VBox;
import haxe.ui.core.Component;

class Notifbar extends SideBar
{
	var outerContainer:Box = null;
	var container:VBox = null;
	var message:Label = null;
	var action1:Button = null;

	public function new()
	{
		super();

		buildSidebar();
		buildChildren();
	}

	function buildSidebar():Void
	{
		this.width = 256;
		this.percentHeight = 100;
		// this.height = 56;

		this.position = "left";
		this.method = "shift";
	}

	function buildChildren():Void
	{
		outerContainer = cast(buildComponent("assets/data/notifbar.xml"), Box);
		add(outerContainer);

		container = outerContainer.findComponent('notifbarContainer', VBox);
		message = outerContainer.findComponent('notifbarMessage', Label);
		action1 = outerContainer.findComponent('notifbarAction1', Button);
	}

	function buildComponent(path:String):Component
	{
		return RuntimeComponentBuilder.fromAsset(path);
	}
}
