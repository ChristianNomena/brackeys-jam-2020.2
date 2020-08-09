using Godot;
using System;

public class Level4 : Node2D
{
	public static bool levelIsRunning = false;
	
	public override void _Ready()
	{
		float red = 0.31f;
		float green = 0.48f;
		float blue = 0.67f;

		VisualServer.SetDefaultClearColor(new Color(red, green, blue));
		
		levelIsRunning = true;
		Level3.levelIsRunning = false;
	}

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
