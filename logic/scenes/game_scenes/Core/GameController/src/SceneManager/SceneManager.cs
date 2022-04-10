using Concept;


/// <summary>
/// Class Holding the current scene and elevated scene control
/// </summary>
public class SceneManager : BaseController{

	// + + + + + + + + + + + + + + + + + + + +//
	//                 PUBLIC                 //
	// + + + + + + + + + + + + + + + + + + + +//

	/// <summary>
	/// Godot API _EnterTree function override
	/// </summary>
	public override void _EnterTree() {
		startController(Concept.kControllersTypes.SCENEMANAGER);
	}
}