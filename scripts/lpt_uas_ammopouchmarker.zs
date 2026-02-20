class LPT_UaS_AmmoPouchMarker : LPT_BackpackMarker
{
    Default
    {
        Scale 0.5;
    }

    States
	{
	Spawn:
		UGSP ABC -1 NoDelay{
			if (target)
			{
				translation = target.translation;
				frame = 2;
			}
		}
		Loop;
    }
}
