using Godot;
using System;

public class MapLevel1 : Node2D
{

	private Timer timer;
	public override void _Ready()
	{
		this.timer = (Timer)GetNode("Timer");
	}

	public override void _Process(float delta)
	{

	}
}
