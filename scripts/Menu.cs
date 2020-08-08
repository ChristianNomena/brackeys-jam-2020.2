using Godot;
using System;

public class Menu : Control
{
	private TextureButton playButton, creditsButton, exitButton;
	private Label labelSaving, labelAccroche;
	private Control credits;

	public static bool mainMenuShow = false;

	public override void _Ready()
	{
		VisualServer.SetDefaultClearColor(new Color(0, 0, 0));

		this.labelSaving = (Label)GetNode("LabelSaving");
		this.labelAccroche = (Label)GetNode("LabelAccroche");

		this.credits = (Control)GetNode("Credits");

		this.playButton = (TextureButton)GetNode("PlayButton");
		this.creditsButton = (TextureButton)GetNode("CreditsButton");
		this.exitButton = (TextureButton)GetNode("ExitButton");

		this.playButton.Connect("pressed", this, nameof(OnPressedPlayButton));
		this.creditsButton.Connect("pressed", this, nameof(OnPressedCreditsButton));
		this.exitButton.Connect("pressed", this, nameof(OnPressedExitButton));

		this.credits.Hide();
	}

	private void OnPressedPlayButton()
	{
		Introduction.readyIntroduction = true;
		GetTree().ChangeScene("res://scenes/stories/Introduction.tscn");
	}

	private void OnPressedCreditsButton()
	{
		mainMenuShow = true;
	}

	private void OnPressedExitButton()
	{
		GetTree().Quit();
	}

	public override void _Process(float delta)
	{
		if (mainMenuShow)
		{
			this.playButton.Hide();
			this.creditsButton.Hide();
			this.exitButton.Hide();

			this.labelSaving.Hide();
			this.labelAccroche.Hide();

			this.credits.Show();
		}
		else
		{
			this.playButton.Show();
			this.creditsButton.Show();
			this.exitButton.Show();

			this.labelSaving.Show();
			this.labelAccroche.Show();

			this.credits.Hide();
		}
	}
}
