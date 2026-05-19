class LPT_UaS_AssaultPackHandler : LPT_BackpackHandler
{
    override void OnRegister()
    {
        backpackClassName = "UaS_AssaultPack";
        wimpClassName = "WIMP_AssaultPack";
        markerClassName = "LPT_UaS_AssaultPackMarker";
    }
}
