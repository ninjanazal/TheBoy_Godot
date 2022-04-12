using Godot;
using Concept;
using System;

/// <summary>
/// Base Controller class,
/// </summary>
public class BaseController : Node{

	protected kControllersTypes _controller_type;

	/// <summary>
	/// On Controller start function base definition
	/// </summary>
	public void startController(Concept.kControllersTypes type) { 
		_controller_type = type;
		AppSingleton.GetSingleton().PrintMsg(
			Concept.kComponentTypes.CONTROLLER,
			 $"Controller {_controller_type} as initialized"
		);

		AppSingleton.GetSingleton().RegistController(_controller_type, this);
	}
}