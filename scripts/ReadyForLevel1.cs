using Godot;
using System;

public class ReadyForLevel1 : Control
{
	public static bool readyLevel1 = false;

	public override void _Ready()
	{
		float red = 0.00f;
		float green = 0.00f;
		float blue = 0.00f;

		VisualServer.SetDefaultClearColor(new Color(red, green, blue));
	}

	public override void _Process(float delta)
	{
		if (readyLevel1 == true)
		{
			if (Input.IsActionJustReleased("accept_control"))
			{
				GetTree().ChangeScene("res://scenes/Gameplay.tscn");
			}
		}
	}
}
