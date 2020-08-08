using Godot;
using System;

public class Credits : Control
{
	private TextureButton backButton;

	public override void _Ready()
	{
		VisualServer.SetDefaultClearColor(new Color(0, 0, 0));

		this.backButton = (TextureButton)GetNode("BackButton");

		this.backButton.Connect("pressed", this, nameof(OnPressedBackButton));
	}

	private void OnPressedBackButton()
	{
		Menu.mainMenuShow = false;
	}
}
