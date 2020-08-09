using Godot;
using System;

public class Level5 : Node2D
{
	public static bool levelIsRunning = false;

	public override void _Ready()
	{
		float red = 0.40f;
		float green = 0.72f;
		float blue = 0.98f;

		VisualServer.SetDefaultClearColor(new Color(red, green, blue));

		levelIsRunning = true;
		Level4.levelIsRunning = false;
	}

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
