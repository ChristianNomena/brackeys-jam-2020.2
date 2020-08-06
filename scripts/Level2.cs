using Godot;
using System;

public class Level2 : Node2D
{
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		float red = 0.04f;
		float green = 0.24f;
		float blue = 0.45f;

		VisualServer.SetDefaultClearColor(new Color(red, green, blue));
	}

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
