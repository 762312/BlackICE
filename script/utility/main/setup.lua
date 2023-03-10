PlayerCountries = {} -- init globally to avoid errors in other functions
-- Called once at start
function DeterminePlayers()
    if CountryIterCacheCheck == 0 then
        CountryIterCache()
    end
    PlayerCountries = {} -- Reset this each time so we don't grow the list each time GetPlayers is pressed
    local playercount = 0
    for tag, countryTag in pairs(CountryIterCacheDict) do
        if CCurrentGameState.IsPlayer( countryTag ) then
            -- Utils.LUA_DEBUGOUT("Player --- " .. playercount .. " --- " .. tag )
            playercount = playercount + 1
            table.insert(PlayerCountries, tag)
        end
    end
    UI.player_choice:Clear()
    UI.player_choice:Append(PlayerCountries)
end

-- Function to check if a player has disabled the hosts ability to check out his country during a MP game
-- will return false if disabled
function CheckPlayerAllowsSelection(player)
    local playerCountry = CCountryDataBase.GetTag(player)
    if playerCountry:GetCountry():GetVariables():GetVariable(CString("disable_gui_access")):Get() == 1 then
        PlayerCountry = nil
        return false
    end

    return true
end
