class LPT_BackpackMarker : MapMarker
{
    Default
    {
        Scale 0.5;
    }

    States
	{
	Spawn:
		BPAK ABC -1 NoDelay{
			if (target)
			{
				translation = target.translation;
				frame = 2;
			}
		}
		Loop;
    }

	override void BeginPlay()
	{
		Super.BeginPlay();
		bDormant = true;
	}

	void SetTranslation(HDBackpack backpack)
	{
		//Console.printf("%d", backpack.CurState.Frame);
		if (backpack.target == Null) return;

		// Add the colored tag
		frame = backpack.frame;

		// Show
		bDormant = false;
		
		float scaleValue = CVar.GetCVar("LPT_Scale").GetFloat() / 2;
		Scale = (scaleValue, scaleValue);

		// Set if the marker scales
		args[2] = !CVar.GetCVar("LPT_ScaleWithZoom").GetBool();

		//Console.printf("%d", backpack.CurState.Frame);

		// Set the owner
		translation = backpack.target.translation;
	}
}