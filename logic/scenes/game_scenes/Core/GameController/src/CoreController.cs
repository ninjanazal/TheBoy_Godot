using System;

/// <summary>
/// Holds the logic for the core controller
/// </summary>
public class CoreController : BaseController{

	/// <summary>
	/// List holding toppl with references to the Typed controllers 
	/// The first element defines the controller type
	/// </summary>
	private (Concept.kControllersTypes, BaseController)[] _managers;
	

	// + + + + + + + + + + + + + + + + + + + +//
	//                 PUBLIC                 //
	// + + + + + + + + + + + + + + + + + + + +//


	/// <summary>
	/// Godot API _EnterTree function override
	/// </summary>
	public override void _EnterTree() {
		_managers = new (Concept.kControllersTypes, BaseController)[
			Enum.GetNames(typeof(Concept.kControllersTypes)).Length	];

		startController(Concept.kControllersTypes.CORE);
	}


	/// <summary>
	/// Regists, if not define a reference to the manager object
	/// </summary>
	/// <param name="type">Enumeration value defining the manager type</param>
	/// <param name="manager">Manager object reference</param>
	/// <returns>If the manager was added to the collection</returns>
	public bool RegistManager(Concept.kControllersTypes type, BaseController manager){
		if(!Array.Exists<(Concept.kControllersTypes, BaseController)>(_managers, elm =>{
			return elm.Item1 == type;
		} )){
			_managers[(int)type] = (type, manager);
			return true;
		}
		return false;
	}
}