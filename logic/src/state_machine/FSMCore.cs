using System.Collections.Generic;


namespace Concept{
	/// <summary>
	/// Finite State Core declaration
	/// </summary>
	/// <typeparam name="T">Type for the defined states types</typeparam>
	public class FSMCore<T>{
		/// <summary>
		/// Holds the state machine name
		/// </summary>
		private string _name_;


		/// <summary>
		/// Holds a list of the Finite state machine transitions
		/// </summary>
		private List<FSMTransition<T>> _transitions_ = new List<FSMTransition<T>>();


		/// <summary>
		/// Holds the current finite state 
		/// </summary>
		private T _current_state_;


		/// <summary>
		/// Holds the last finite state
		/// </summary>
		private T _last_state_;


		/// <summary>
		/// Event Used to notify the subscrivers on a state change
		/// </summary>
		public event BaseEventHandler OnStateChange;

		/// <summary>
		/// Finite state machine constructor
		/// </summary>
		/// <param name="name">State Machine name</param>
		/// <param name="transitions">List with the state machine transitions</param>
		public FSMCore(string name, List<FSMTransition<T>> transitions){
			_name_ = name;
			_transitions_ = transitions;
		}

		
		/// <summary>
		/// Gets the defined state machine name
		/// </summary>
		/// <returns>Finite State Machine name</returns>
		public string GetName() { return _name_; }


		/// <summary>
		/// Gets the current state machine state
		/// </summary>
		/// <returns>Current state value</returns>
		public T GetCurrentState() { return _current_state_; }


		/// <summary>
		/// Gets the previous state machine state
		/// </summary>
		/// <returns>Previous state value</returns>
		public T GetPreviousState() { return _last_state_; }


		/// <summary>
		/// Inititalize the finite state machine with a define state
		/// </summary>
		/// <param name="initState"></param>
		public void InitMachine(T initState) => _current_state_ = _last_state_ = initState;


		/// <summary>
		/// Evaluates a request transition
		/// </summary>
		/// <param name="transition_name">Defined transition string name</param>
		public void RequestTransition(string transition_name){
			if (_transitions_.Count == 0)
				return;
			
			FSMTransition<T> curr_transiton = _transitions_.Find(
				x => x.GetTransitionName() == transition_name);

			if (curr_transiton != null && curr_transiton.ValidateFromState(_current_state_)) {
				_last_state_ = _current_state_;
				_current_state_ = curr_transiton.GetToState();
				curr_transiton.InvokeOnEnd();
				OnStateChange.Invoke();
			}
		}


		/// <summary>
		/// Forces a defined state, this will trigger a event raise as normal transition
		/// </summary>
		/// <param name="definedState">Defined target state</param>
		public void ForceCurrentState(T definedState){
			_last_state_ = _current_state_;
			_current_state_ = definedState;
			OnStateChange.Invoke();
		}
	}
}