using Godot;
using System;

public class Introduction : Control
{
	private Sprite background;
	private AudioStreamPlayer audioStreamPlayer;
	private Timer timer;
	private Node2D nodePart1, nodePart2, nodePart3;

	private Control readyForLevel1;

	private int timerCount;

	public static bool readyIntroduction = false;

	public override void _Ready()
	{
		VisualServer.SetDefaultClearColor(new Color(0, 0, 0));

		this.background = (Sprite)GetNode("Background");
		this.audioStreamPlayer = (AudioStreamPlayer)GetNode("AudioStreamPlayer");
		this.timer = (Timer)GetNode("Timer");
		this.nodePart1 = (Node2D)GetNode("Part1/Node2DPart1");
		this.nodePart2 = (Node2D)GetNode("Part2/Node2DPart2");
		this.nodePart3 = (Node2D)GetNode("Part3/Node2DPart3");
		this.timerCount = 0;

		this.readyForLevel1 = (Control)GetNode("ReadyForLevel1");

		this.timer.Connect("timeout", this, nameof(OnTimeOutTimer));

		this.nodePart1.Show();
		this.nodePart2.Hide();
		this.nodePart3.Hide();

		this.readyForLevel1.Hide();
	}

	private void OnTimeOutTimer()
	{
		this.timerCount++;

		if (timerCount == 1)
		{
			this.nodePart1.Hide();
			this.nodePart2.Show();
			this.nodePart3.Hide();
		}
		else if (timerCount == 2)
		{
			this.nodePart1.Hide();
			this.nodePart2.Hide();
			this.nodePart3.Show();
		}
		else if (timerCount == 3)
		{
			this.nodePart3.Hide();
			this.background.Hide();

			this.timer.Stop();
			ReadyForLevel1.readyLevel1 = true;

			this.readyForLevel1.Show();
		}
	}

	public override void _Process(float delta)
	{
		if (readyIntroduction)
		{
			this.audioStreamPlayer.Play();
			this.timer.Start();
			readyIntroduction = false;
		}
	}
}
