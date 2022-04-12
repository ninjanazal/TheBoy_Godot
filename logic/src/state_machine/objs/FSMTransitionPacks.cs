/// <summary>
/// Holds the transition packs for all inUse state machines
/// </summary>

using System.Collections.Generic;

namespace Concept{
	/// <summary>
	/// Struct holding static definitions for the transition packs
	/// </summary>
	public struct TransitionPacks {

		/// <summary>
		/// Cora finite state machine transition pack
		/// </summary>
		/// <value>List with all defined transition</value>
		public static List<FSMTransition<kCoreTransitions>> corePack =
			new List<FSMTransition<kCoreTransitions>> {

				// --------------------------------------------------
				// On Initialize transition
				new FSMTransition<kCoreTransitions>(
					"onInitialize", 
					new kCoreTransitions [] {kCoreTransitions.ANY},
					kCoreTransitions.ONINITIALIZE
					),


				// --------------------------------------------------
				// On Intro transition
				new FSMTransition<kCoreTransitions>(
					"onIntro",
					new kCoreTransitions [] {kCoreTransitions.ONINITIALIZE},
					kCoreTransitions.ONINTRO
				)
		};
	}
}