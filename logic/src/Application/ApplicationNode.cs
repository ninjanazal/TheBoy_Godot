using Concept;
using Godot;
using System;

/// <summary>
/// Godot Singleton Node Class
/// </summary>
public class ApplicationNode : Node {

	/// <summary>
	/// Godot API _EnterTree function override
	/// This regist a reference for the tree component for the Application singleton
	/// </summary>
	public override void _EnterTree() {
		AppSingleton.GetSingleton().RegistNodeSingleton(this);
	}


	// + + + + + + + + + + + + + + + + + + + +//
	//                 PUBLIC                 //
	// + + + + + + + + + + + + + + + + + + + +//


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
