using System;


namespace Concept
{
	/// <summary>
	/// Application singleton interface
	/// </summary>
	interface iApplication {

		/// <summary>
		/// Print Message singleton declaration
		/// </summary>
		/// <param name="type">Enumeration kConceptType value</param>
		/// <param name="msg">String message</param>
		void PrintMsg(Concept.kComponentTypes type, string msg);
	}
}