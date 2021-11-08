------------------------------------------------------
-- https://wxlua.sourceforge.net/docs/wxluaref.html --
------------------------------------------------------

package.cpath = package.cpath..";./tfh/mod/?.dll;"
require("wx")

if wx ~= nil then -- wx is not initialized until a few ticks have gone by. Do this to prevent log spam.

    -- Frame = Literally just the window. Program name, minimize, maximize, close. Thats it.
    frame = wx.wxFrame(wx.NULL, wx.wxID_ANY, "Hoi3 Utility",
                        wx.wxDefaultPosition, wx.wxSize(500, 500))

    notebookActions = wx.wxNotebook(frame, wx.wxID_ANY, wx.wxDefaultPosition, wx.wxDefaultSize)

    -- Panel = The canvas on which we build our gui.
    panelActions = wx.wxPanel(notebookActions, wx.wxID_ANY)

    -- Sizers take care of the arrangement and size (duh) of our buttons and/or the whole window/panel.
    local mainSizer         = wx.wxBoxSizer(wx.wxVERTICAL)
    local staticBox         = wx.wxStaticBox(panelActions, wx.wxID_ANY, "Cool Text")
    local staticBoxSizer    = wx.wxStaticBoxSizer(staticBox, wx.wxVERTICAL)
    local flexGridSizer     = wx.wxFlexGridSizer( 2, 2, 3, 3 )


    button_left_ID = 1
    button_right_ID = 2
    button_3_ID = 3
    button_4_ID = 4
    button_5_ID = 5
    button_6_ID = 6

    local ButtonLeft = wx.wxButton( panelActions, button_left_ID, "Almost Daily Resource Count OFF")
    local ButtonRight = wx.wxButton( panelActions, button_right_ID, "Almost Daily Resource Count ON")
    local Button3 = wx.wxButton( panelActions, button_3_ID, "333")
    local Button4 = wx.wxButton( panelActions, button_4_ID, "444")
    local Button5 = wx.wxButton( panelActions, button_5_ID, "555")
    local Button6 = wx.wxButton( panelActions, button_6_ID, "666")
    flexGridSizer:Add( ButtonLeft, 0, wx.wxALIGN_CENTER+wx.wxALL, 0 )
    flexGridSizer:Add( ButtonRight, 0, wx.wxALIGN_CENTER+wx.wxALL, 50 )
    flexGridSizer:Add( Button3, 0, wx.wxALIGN_CENTER+wx.wxALL, 0 )
    flexGridSizer:Add( Button4, 0, wx.wxALIGN_CENTER+wx.wxALL, 0 )
    flexGridSizer:Add( Button5, 0, wx.wxALIGN_CENTER+wx.wxALL, 0 )
    flexGridSizer:Add( Button6, 0, wx.wxALIGN_CENTER+wx.wxALL, 0 )


    staticBoxSizer:Add( flexGridSizer,  0, wx.wxGROW+wx.wxALIGN_CENTER+wx.wxALL, 5 )
    mainSizer:Add(   staticBoxSizer, 0, wx.wxALIGN_CENTER+wx.wxALL, 10 )

    notebookActions:AddPage(panelActions, "Page 1")
    panelActions:SetSizer( mainSizer )
    -- Couldn't get the dynamic sizing to work... so just set statics during the frame init
    -- mainSizer:SetSizeHints( frame )
    -- frame:SetSizeHints(notebook:GetBestSize():GetWidth(), notebook:GetBestSize():GetHeight())

    panelActions:Connect(button_left_ID, wx.wxEVT_COMMAND_BUTTON_CLICKED,
        function(event)
            if saveLoaded == true then
                DateOverride = false
                --Utils.LUA_DEBUGOUT(tostring(DateOverride))
            else
                --Utils.LUA_DEBUGOUT("NO SAVE LOADED")
            end
        end)
    --
    panelActions:Connect(button_right_ID, wx.wxEVT_COMMAND_BUTTON_CLICKED,
        function(event)
            if saveLoaded == true then
                DateOverride = true
                --Utils.LUA_DEBUGOUT(tostring(DateOverride))
            else
                --Utils.LUA_DEBUGOUT("NO SAVE LOADED")
            end
        end)
    --

    panelPuppet = wx.wxPanel(notebookActions, wx.wxID_ANY)

    -- Sizers take care of the arrangement and size (duh) of our buttons and/or the whole window/panel.
    local mainSizerPuppet         = wx.wxBoxSizer(wx.wxVERTICAL)
    local staticBoxPuppet         = wx.wxStaticBox(panelPuppet, wx.wxID_ANY, "Cool Text")
    local staticBoxSizerPuppet    = wx.wxStaticBoxSizer(staticBoxPuppet, wx.wxVERTICAL)
    local flexGridSizerPuppet     = wx.wxFlexGridSizer( 2, 2, 3, 3 )


    button_21_ID = 21
    button_22_ID = 22
    button_23_ID = 23
    button_24_ID = 24
    button_25_ID = 25
    button_26_ID = 26

    local Button1 = wx.wxButton( panelPuppet, button_21_ID, "111")
    local Button2 = wx.wxButton( panelPuppet, button_22_ID, "222")
    local Button3 = wx.wxButton( panelPuppet, button_23_ID, "333")
    local Button4 = wx.wxButton( panelPuppet, button_24_ID, "444")
    local Button5 = wx.wxButton( panelPuppet, button_25_ID, "555")
    local Button6 = wx.wxButton( panelPuppet, button_26_ID, "666")
    flexGridSizerPuppet:Add( Button1, 0, wx.wxALIGN_CENTER+wx.wxALL, 0 )
    flexGridSizerPuppet:Add( Button2, 0, wx.wxALIGN_CENTER+wx.wxALL, 50 )
    flexGridSizerPuppet:Add( Button3, 0, wx.wxALIGN_CENTER+wx.wxALL, 0 )
    flexGridSizerPuppet:Add( Button4, 0, wx.wxALIGN_CENTER+wx.wxALL, 0 )
    flexGridSizerPuppet:Add( Button5, 0, wx.wxALIGN_CENTER+wx.wxALL, 0 )
    flexGridSizerPuppet:Add( Button6, 0, wx.wxALIGN_CENTER+wx.wxALL, 0 )


    staticBoxSizerPuppet:Add( flexGridSizerPuppet,  0, wx.wxGROW+wx.wxALIGN_CENTER+wx.wxALL, 5 )
    mainSizerPuppet:Add(   staticBoxSizerPuppet, 0, wx.wxALIGN_CENTER+wx.wxALL, 10 )

    notebookActions:AddPage(panelPuppet, "Page 2")
    panelPuppet:SetSizer( mainSizerPuppet )

    panelPuppet:Connect(button_21_ID, wx.wxEVT_COMMAND_BUTTON_CLICKED,
        function(event)
            if saveLoaded == true then
                DateOverride = false
                --Utils.LUA_DEBUGOUT(tostring(DateOverride))
            else
                --Utils.LUA_DEBUGOUT("NO SAVE LOADED")
            end
        end)
    --
    panelPuppet:Connect(button_22_ID, wx.wxEVT_COMMAND_BUTTON_CLICKED,
        function(event)
            if saveLoaded == true then
                DateOverride = true
                --Utils.LUA_DEBUGOUT(tostring(DateOverride))
            else
                --Utils.LUA_DEBUGOUT("NO SAVE LOADED")
            end
        end)
    --


    frame:Centre()
    frame:Show(true)

end