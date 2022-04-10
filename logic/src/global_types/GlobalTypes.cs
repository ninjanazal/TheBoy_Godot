

/// <summary>
/// Main Concept namespace
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
}