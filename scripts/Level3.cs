using Godot;
using System;

public class Level3 : Node2D
{
	public static bool levelIsRunning = false;

	public override void _Ready()
	{
		float red = 0.22f;
		float green = 0.32f;
		float blue = 0.57f;

		VisualServer.SetDefaultClearColor(new Color(red, green, blue));

		levelIsRunning = true;
		Level2.levelIsRunning = false;
	}

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
