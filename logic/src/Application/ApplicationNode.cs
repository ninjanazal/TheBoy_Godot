using Concept;
using Godot;
using System;

/// <summary>
/// Godot Singleton Node Class
/// </summary>
public class ApplicationNode : Node, Concept.iApplication {

	/// <summary>
	/// Godot API _EnterTree function override
	/// </summary>
	public override void _EnterTree() {
		AppSingleton.GetSingleton().RegistNodeSingleton(this);
	}


	/// <summary>
	/// Prints a typed message
	/// </summary>
	/// <param name="type">Enumeration kConceptType value</param>
	/// <param name="msg">String message</param>
	public void PrintMsg(kComponentTypes type, string msg) {
		string outValue =
			$"{Enum.GetName(typeof(Concept.kComponentTypes), type)} \t ::: \t{msg}";
		GD.Print(outValue);
	}
}
