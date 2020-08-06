using Godot;
using System;

public class Level3 : Node2D
{
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		float red = 0.31f;
		float green = 0.48f;
		float blue = 0.67f;

		VisualServer.SetDefaultClearColor(new Color(red, green, blue));
	}

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
