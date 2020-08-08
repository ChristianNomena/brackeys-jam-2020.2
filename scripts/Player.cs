using Godot;
using System;

public class Player : KinematicBody2D
{
	private double pesanteur, gravity, deceleration;
	private int acceleration, max_speed, jump_height, jump_count, player_anim_blend_pos, jump_offset;

	private Vector2 vectorFloor;
	private Vector2 velocity;

	private Sprite playerSprite;
	private AnimationTree playerAnim;
	private AnimationNodeStateMachinePlayback playerAnimState; 
	
	public override void _Ready()
	{
		this.pesanteur = 1.5;
		this.gravity = 1000 * this.pesanteur;

		this.acceleration = 10;
		this.deceleration = 0.24;

		this.max_speed = 400;
		this.jump_height = 800;
		this.jump_count = 0;
		this.jump_offset = 0;
		
		this.player_anim_blend_pos = 1;
		
		this.vectorFloor = new Vector2(0, -1); // ===== Nous permet de savoir ou se trouve le sol =====
		this.velocity = new Vector2();

		this.playerSprite = (Sprite)GetNode("Sprite");
		this.playerAnim = (AnimationTree)GetNode("AnimationTree");
		this.playerAnimState = (AnimationNodeStateMachinePlayback)this.playerAnim.Get("parameters/playback");
	}

	public override void _PhysicsProcess(float delta)
	{
		this.MovementLoop();
		this.playerAnim.Set("active", true);

		this.velocity.y += Convert.ToSingle(gravity) * delta;
		this.velocity = this.MoveAndSlide(this.velocity, this.vectorFloor);
	}

	private void MovementLoop()
	{	
		this.playerAnim.Set("parameters/Idle/blend_position", this.player_anim_blend_pos);
		this.playerAnim.Set("parameters/Run/blend_position", this.player_anim_blend_pos);
		this.playerAnim.Set("parameters/Jump/blend_position", this.player_anim_blend_pos);
		this.playerAnim.Set("parameters/Falling/blend_position", this.player_anim_blend_pos);
		
		bool left = Input.IsActionPressed("player_move_left");
		bool right = Input.IsActionPressed("player_move_right");

		bool jump = Input.IsActionJustPressed("player_jump");
		bool dash = Input.IsActionJustPressed("player_dash");

		int horizontalDirection = Convert.ToInt32(right) - Convert.ToInt32(left);

		// =============== Mouvement lineaire horizontal ===============
		if (horizontalDirection == -1)
		{
			this.velocity.x = Math.Max(this.velocity.x - this.acceleration, -this.max_speed);
			this.playerSprite.FlipH = true;
			this.player_anim_blend_pos = -1;
			if (this.IsOnFloor()) this.playerAnimState.Travel("Run");
			
			if (dash)
			{
				this.MouvementDash();
			}
			// Animation walk
		}
		else if (horizontalDirection == 1) 
		{
			this.velocity.x = Math.Min(this.velocity.x + this.acceleration, this.max_speed);
			this.playerSprite.FlipH = false;
			this.player_anim_blend_pos = 1;
			if (this.IsOnFloor()) this.playerAnimState.Travel("Run");
			
			if (dash)
			{
				this.MouvementDash();
			}
			// Animation walk
		}
		else if ((horizontalDirection == 0) && (this.IsOnFloor()))
		{
			this.velocity.x = Mathf.Lerp(this.velocity.x, 0, Convert.ToSingle(this.deceleration));
			// Animation idle
			if ( this.IsOnFloor())  this.playerAnimState.Travel("Idle");
		}

		// =============== Reinitialisation des sauts lorsqu'on touche le sol ===============
		if (this.IsOnFloor())
		{
			this.jump_count = 0;
		}

		// =============== Realisation des sauts ===============
		if (jump == true && jump_count < 2)
		{
			this.velocity.y = -jump_height;
			this.playerAnimState.Travel("Jump");
			jump_count++;
			// if (jump_count == 1 ) 
		}
		if ((!this.IsOnFloor()) && ( (jump_count == 0) || (jump_count == 2)))
		{
			this.playerAnimState.Travel("Falling");
		}
	}

	private void MouvementDash()
	{
		if (this.playerSprite.FlipH == false)
		{
			this.velocity.x += 7000;
		}
		else
		{
			this.velocity.x -= 7000;
		}
	}
}
