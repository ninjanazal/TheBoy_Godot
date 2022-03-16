using Godot;
using System;

/// <summary>
/// Main Concept namespace
/// </summary>
namespace Concept {

	/// <summary>
	/// Application singleton class object definition
	/// </summary>
	public sealed class AppSingleton : iApplication{

		/// <summary>
		/// Holds instance objected
		/// </summary>
		private static AppSingleton _instance;

		/// <summary>
		/// Node singleton reference
		/// </summary>
		private ApplicationNode _AppNode;


		/// <summary>
		/// AppSingleton Constructor
		/// </summary>
		private AppSingleton() { }


		/// <summary>
		/// Get singleton function definition
		/// </summary>
		/// <returns>Gets the current singleton instance</returns>
		public static AppSingleton GetSingleton(){
			if(_instance == null){
				_instance = new AppSingleton();
			}

			return _instance;
		}

		/// <summary>
		/// Regist the node Singleton Version
		/// </summary>
		/// <param name="nodeSingleton">Reference to the nodeSingleton</param>
		public void RegistNodeSingleton(ApplicationNode nodeSingleton){
			if(_AppNode == null){
				_AppNode = nodeSingleton;
				PrintMsg(kComponentTypes.CSHARPAPPLICATION,
				"Node based connected to logic singleton");
			}
		}

		/// <summary>
		/// Routs the internal singleton function to the node base one
		/// </summary>
		/// <param name="type">Enumeration kConceptType value</param>
		/// <param name="msg">String message</param>
		public void PrintMsg(kComponentTypes type, string msg) {
			string outValue =
				$"{Enum.GetName(typeof(Concept.kComponentTypes), type)} \t ::: \t{msg}";
			GD.Print(outValue);
		}
	}
}