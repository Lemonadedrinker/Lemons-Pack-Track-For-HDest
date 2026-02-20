class LPT_UaS_AssaultPackMarker : LPT_BackpackMarker
{
    Default
    {
        Scale 0.5;
    }

    States
	{
	Spawn:
		UGSQ ABC -1 NoDelay{
			if (target)
			{
				translation = target.translation;
				frame = 2;
			}
		}
		Loop;
    }
}
