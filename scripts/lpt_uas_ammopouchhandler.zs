class LPT_UaS_AmmoPouchHandler : LPT_BackpackHandler
{
    override void WorldLoaded(WorldEvent event)
    {
        backpackClassName = "UaS_AmmoPouch";
        markerClassName = "LPT_UaS_AmmoPouchMarker";
    }
}
