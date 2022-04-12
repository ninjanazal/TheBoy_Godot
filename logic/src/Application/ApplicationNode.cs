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
}
