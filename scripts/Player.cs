using Godot;
using System;

public class Player : KinematicBody2D
{
	private double pesanteur, gravity, deceleration;
	private int acceleration, max_speed, jump_height, jump_count;

	private Vector2 vectorFloor;
	private Vector2 velocity;

	private Sprite playerSprite;
	
	public override void _Ready()
	{
		this.pesanteur = 1.5;
		this.gravity = 1000 * this.pesanteur;

		this.acceleration = 10;
		this.deceleration = 0.12;

		this.max_speed = 400;
		this.jump_height = 800;
		this.jump_count = 0;
		
		this.vectorFloor = new Vector2(0, -1); // ===== Nous permet de savoir ou se trouve le sol =====
		this.velocity = new Vector2();

		this.playerSprite = (Sprite)GetNode("Sprite");
	}

	public override void _PhysicsProcess(float delta)
	{
		this.MovementLoop();

		this.velocity.y += Convert.ToSingle(gravity) * delta;
		this.velocity = this.MoveAndSlide(this.velocity, this.vectorFloor);
	}

	private void MovementLoop()
	{
		bool left = Input.IsActionPressed("ui_left");
		bool right = Input.IsActionPressed("ui_right");
		bool jump = Input.IsActionJustPressed("ui_select");
		int horizontalDirection = Convert.ToInt32(right) - Convert.ToInt32(left);

		// =============== Mouvement lineaire horizontal ===============
		if (horizontalDirection == -1)
		{
			this.velocity.x = Math.Max(this.velocity.x - this.acceleration, -this.max_speed);
			this.playerSprite.FlipH = true;
			// Animation walk
		}
		else if (horizontalDirection == 1)
		{
			this.velocity.x = Math.Min(this.velocity.x + this.acceleration, this.max_speed);
			this.playerSprite.FlipH = false;
			// Animation walk
		}
		else
		{
			this.velocity.x = Mathf.Lerp(this.velocity.x, 0, Convert.ToSingle(this.deceleration));
			// Animation idle
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
			jump_count++;
		}
	}
}
