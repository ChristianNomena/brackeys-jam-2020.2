using Godot;
using System;

public class Credits : Control
{
	private TextureButton backButton;
	private TextureButton teamButton;
	private TextureButton musicButton;

	private Node2D teamNode;
	private Node2D musicNode;

	private Label titleLabel;

	public override void _Ready()
	{
		VisualServer.SetDefaultClearColor(new Color(0, 0, 0));

		this.backButton = (TextureButton)GetNode("BackButton");
		this.teamButton = (TextureButton)GetNode("TeamButton");
		this.musicButton = (TextureButton)GetNode("MusicButton");

		this.teamNode = (Node2D)GetNode("Team");
		this.musicNode = (Node2D)GetNode("Music");

		this.titleLabel = (Label)GetNode("TitleLabel");

		this.backButton.Connect("pressed", this, nameof(OnBackButtonPressed));

		this.OnTeamButtonPressed();
	}

	private void OnBackButtonPressed()
	{
		Menu.mainMenuShow = false;
	}
	
	private void OnTeamButtonPressed()
	{
		this.teamNode.Show();
		this.musicNode.Hide();

		this.teamButton.Hide();
		this.musicButton.Show();

		this.titleLabel.Text = "THE TEAM";
	}

	private void OnMusicButtonPressed()
	{
		this.teamNode.Hide();
		this.musicNode.Show();

		this.teamButton.Show();
		this.musicButton.Hide();

		this.titleLabel.Text = "MUSIC";
	}
}

