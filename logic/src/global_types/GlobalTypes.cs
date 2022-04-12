/// <summary>
/// Holds the Global types enumeration and definitions
/// </summary>


namespace Concept {
	/// <summary>
	/// Holds the component types
	/// </summary>
	public enum kComponentTypes	{
		CSHARPAPPLICATION,
		APPLICATION,
		GAME,
		CAMERA,
		CHARACTER,
		LEVEL,
		AUDIO,
		CONTROLLER
	};

	/// <summary>
	/// Holds the available game controller types
	/// </summary>
	public enum kControllersTypes {
		CORE,
		BASECONTROLLER,
		SCENEMANAGER,
		INPUTMANAGER,
		AUDIOMANAGER,
		GAMELOGIC
	}


	/// <summary>
	/// Base event Handler definititon, no arguments
	/// </summary>
	public delegate void BaseStateChange<T>(T curr_state);
}