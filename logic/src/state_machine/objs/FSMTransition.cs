using System;

namespace Concept
{
	/// <summary>
	/// Holds the logic for a FiniteStateMachine transition
	/// </summary>
	public class FSMTransition<T>
	{

		/// <summary>
		/// Holds the transition defined name
		/// </summary>
		private string _name_;


		/// <summary>
		/// Aray with the valid from transitions
		/// </summary>
		private T[] _fromStates_;


		/// <summary>
		/// Holds the result state if this is a valid transition
		/// </summary>
		private T _toState_;


		/// <summary>
		/// On finish Callback function
		/// </summary>
		private Action _onFinish_;


		/// <summary>
		/// Transition Constructor declaration
		///  </summary>
		/// <param name="transitionName">Defined transition naem</param>
		/// <param name="fromState">Defined array with valid from states</param>
		/// <param name="toState">To state definition on a valid pass</param>
		public FSMTransition(string transitionName,T[] fromStates, T toState, Action on_end = null) {
			_name_ = transitionName;
			_fromStates_ = fromStates;
			_toState_ = toState;
			_onFinish_ = on_end;
		}


		/// <summary>
		/// Validates if a defined state is a valid from state
		/// </summary>
		/// <param name="fromState">validation Defined state</param>
		/// <returns>If is a valid state</returns>
		public bool ValidateFromState(T fromState)
		{
			return Array.Exists(
				_fromStates_, elem => elem.Equals(fromState)
				);
		}

		/// <summary>
		/// Defines/Update the onFinished callback function
		/// </summary>
		/// <param name="on_end">On finish callback function</param>
		public void SetOnFinish(Action on_end) => _onFinish_ = on_end;


		/// <summary>
		/// Invoke the defined on End function
		/// </summary>
		public void InvokeOnEnd(){
			if(_onFinish_ != null){
				_onFinish_();
			};
		}


		/// <summary>
		/// Gets the transition name
		/// </summary>
		/// <returns>Gets the transition name</returns>
		public string GetTransitionName() { return _name_; }


		/// <summary>
		/// Gets the result state from this transition
		/// </summary>
		/// <returns>Result transition state</returns>
		public T GetToState() { return _toState_; }
	}

}