using Concept;
using Godot;

/// <summary>
/// Handles the intro scene logic
/// </summary>
public class IntroScene : Node {

	/// <summary>
	/// Holds a reference for the animation player
	/// </summary>
	private AnimationPlayer _introAnimation;


	/// <summary>
	/// Godot API _ready function override
	/// </summary>
	public override async void _Ready(){
		_introAnimation = GetNode<AnimationPlayer>("anim_intro");
		_introAnimation.Play("game_intro");

		await ToSignal(_introAnimation, "animation_finished");
	}
}