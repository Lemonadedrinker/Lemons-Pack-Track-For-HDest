class LPT_UaS_AmmoPouchHandler : LPT_BackpackHandler
{
    override void OnRegister()
    {
        backpackClassName = "UaS_AmmoPouch";
        wimpClassName = "WIMP_AmmoPouch";
        markerClassName = "LPT_UaS_AmmoPouchMarker";
    }
}
