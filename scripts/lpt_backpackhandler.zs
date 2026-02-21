class LPT_BackpackHandler : EventHandler
{
    Array<HDBackpack> backpacks;
    Array<LPT_BackpackMarker> markers;

    String backpackClassName; // For inheritance
    String markerClassName; // For inheritance

    bool uninstallingMod;

    override void WorldLoaded(WorldEvent event)
    {
        backpackClassName = "HDBackpack";
        markerClassName = "LPT_BackpackMarker";
    }

    // Used to uninstall the mod
    override void NetworkProcess(ConsoleEvent event)
    {
        if(players[Consoleplayer].mo == null) return;

        // Uninstall the mod by deleting the event handler, only if it is the arbitrator
        else if (event.Name == "LPT_Uninstall")
        {
            //Console.printf("Trying to uninstall mod");
            //Console.printf("Player number: %i", event.Player);
            if (net_arbitrator == event.Player)
            {
                if (backpackClassName == "HDBackpack") Console.printf("Uninstalling mod. Have a good day!");
                uninstallingMod = true;
            }
            else
            {
                if (backpackClassName == "HDBackpack") Console.printf("Not uninstalling mod. You must be the arbitrator!");
            }
        }
    }

    // Spawn and store the backpacks with their markers
    override void WorldThingSpawned(WorldEvent event)
    {
        // Only runs for backpacks
        //Console.printf(event.Thing.GetClassName());
        if (event.Thing.GetClassName() != backpackClassName) return;

        // Spawn in the marker
        LPT_BackpackMarker marker = SpawnMarker(HDBackpack(event.Thing));

        // Add to the arrays
        backpacks.Push(HDBackpack(event.Thing));
        markers.Push(marker);
    }

    override void WorldTick()
    {
        // Delete the event handler if the mod is being uninstalled
        if (uninstallingMod)
        {
            for (int i = 0; i < markers.Size(); i++)
            {
                markers[i].Destroy();
            }

            if (!bDESTROYED)
            {
                Destroy();
            }
            return;
        }

        // Check if any of the previously existing backpacks have been deleted
        // If so, restore both arrays
        for (int i = 0; i < backpacks.Size(); i++)
        {
            if (backpacks[i] == Null)
            {
                ResetMarkers();
                break;
            }
        }

        // For each backpack, move the marker to the backpack
        HDBackpack backpack;
        for (int i = 0; i < backpacks.Size(); i++)
        {
            backpack = backpacks[i];
            markers[i].SetOrigin(backpack.pos, false);
            //markers[i].target = backpacks[i].target;

            //Console.printf("%i", backpacks[i].frame);

            // Set the translation only if it has items and is owned
            if (CheckBackpack(backpack))
            {
                markers[i].SetTranslation(backpack);
            }
            // Hide the backpack when on the player, the sprite then is 0
            else markers[i].bDormant = true;
        }
    }

    /***
    *   Called whenever the number of markers is not the same as backpacks somehow
    *   Could happen on inventory clear
    */
    void ResetMarkers()
    {
        // Parse through the markers, deleting them
        for (int i = 0; i < markers.Size(); i++)
        {
            markers[i].Destroy();
        }

        // Clear them out
        backpacks.Clear();
        markers.Clear();

        // Parse through all the backpacks, re-adding the markers again
        ThinkerIterator it = ThinkerIterator.Create(backpackClassName);
        HDBackpack backpack;
        LPT_BackpackMarker marker;
        while (backpack = HDBackpack(Actor(it.Next())))
        {
            // Spawn in the marker
            marker = SpawnMarker(backpack);

            backpacks.Push(backpack);
            markers.Push(marker);
        }
    }

    LPT_BackpackMarker SpawnMarker(HDBackpack backpack)
    {
        bool a;
        Actor b;

        // Spawn in the marker
        [a, b] = backpack.A_SpawnItemEx(
            markerClassName
        );

        return LPT_BackpackMarker(b);
    }

    bool CheckBackpack(HDBackpack backpack)
    {
        bool isShowing = false;
        
        // Empty backpack
        if (backpack.frame == 1)
        {
            if (CVar.GetCvar("LPT_ShowEmptyPacks").GetBool()) isShowing = true;
        }
        // Filled backpack
        else if (backpack.frame == 2)
        {
            if (players[ConsolePlayer].mo == backpack.target) isShowing = true;
            else if (CVar.GetCvar("LPT_ShowOtherPlayerPacks").GetBool() && players[ConsolePlayer].mo != backpack.target) isShowing = true;
        }

        return isShowing;
    }
}