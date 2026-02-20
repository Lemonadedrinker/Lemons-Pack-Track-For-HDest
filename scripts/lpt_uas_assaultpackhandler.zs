class LPT_UaS_AssaultPackHandler : LPT_BackpackHandler
{
    override void WorldLoaded(WorldEvent event)
    {
        backpackClassName = "UaS_AssaultPack";
        markerClassName = "LPT_UaS_AssaultPackMarker";
    }
}
