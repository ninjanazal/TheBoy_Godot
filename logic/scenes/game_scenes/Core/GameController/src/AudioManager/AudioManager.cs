public class AudioManager : BaseController{
	// + + + + + + + + + + + + + + + + + + + +//
	//                 PUBLIC                 //
	// + + + + + + + + + + + + + + + + + + + +//


	/// <summary>
	/// Godot API _EnterTree function override
	/// </summary>
	public override void _EnterTree() {
		startController(Concept.kControllersTypes.AUDIOMANAGER);
	}
}