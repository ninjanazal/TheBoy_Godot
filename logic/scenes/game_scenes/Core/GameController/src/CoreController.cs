using Concept;
using System;

/// <summary>
/// Holds the logic for the core controller
/// </summary>
public class CoreController : BaseController{


	/// <summary>
	/// Core controller internal finite state machine
	/// </summary>
	private FSMCore<kCoreTransitions> _coreFSM;

	// + + + + + + + + + + + + + + + + + + + +//
	//                 PUBLIC                 //
	// + + + + + + + + + + + + + + + + + + + +//


	/// <summary>
	/// Godot API _EnterTree function override
	/// </summary>
	public override void _EnterTree() {
		startController(Concept.kControllersTypes.CORE);
		_coreFSM = new FSMCore<kCoreTransitions>("coreControllerFSM",
			TransitionPacks.corePack, kCoreTransitions.ANY);
		
		_coreFSM.Subscrive(OnStateChange);
	}


	/// <summary>
	/// Godot API _Ready function override
	/// </summary>
	public override void _Ready(){
		_coreFSM.RequestTransition("onInitialize");
	}


	/// <summary>
	/// Callback function to handle the internal finite state machine change state event
	/// </summary>
	/// <param name="current_state">New State</param>
	private void OnStateChange(kCoreTransitions current_state){
		AppSingleton.GetSingleton().PrintMsg(
			kComponentTypes.CONTROLLER,
			 $"{this._controller_type}\t >>> On State Change ( {current_state} ) <<<"
		);
	}
}