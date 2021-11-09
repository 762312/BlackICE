
package.cpath = package.cpath..";./tfh/mod/?.dll;"
require("wx")


UI = {}

-- create MyFrame1
UI.MyFrame1 = wx.wxFrame (wx.NULL, wx.wxID_ANY, "", wx.wxDefaultPosition, wx.wxSize( 500,500 ), wx.wxDEFAULT_FRAME_STYLE+wx.wxTAB_TRAVERSAL, "Hoi3 Utility" )
	UI.MyFrame1:SetSizeHints( wx.wxSize( 500,500 ), wx.wxDefaultSize )
	UI.MyFrame1.m_mgr = wxaui.wxAuiManager()
	UI.MyFrame1.m_mgr:SetManagedWindow( UI.MyFrame1 )

	UI.m_notebook4 = wx.wxNotebook( UI.MyFrame1, wx.wxID_ANY, wx.wxDefaultPosition, wx.wxSize( 100,100 ), 0 )
	UI.MyFrame1.m_mgr:AddPane( UI.m_notebook4, wxaui.wxAuiPaneInfo() :Left() :CaptionVisible( False ):CloseButton( False ):Dock():Resizable():FloatingSize( wx.wxDefaultSize ):CentrePane() )

	UI.m_panel8 = wx.wxPanel( UI.m_notebook4, wx.wxID_ANY, wx.wxDefaultPosition, wx.wxSize( -1,-1 ), wx.wxTAB_TRAVERSAL )
	UI.bSizer2 = wx.wxBoxSizer( wx.wxVERTICAL )

	UI.m_textCtrl3 = wx.wxTextCtrl( UI.m_panel8, wx.wxID_ANY, "Setting up...", wx.wxDefaultPosition, wx.wxDefaultSize, 0 )
	UI.m_textCtrl3:Enable( False )

	UI.bSizer2:Add( UI.m_textCtrl3, 0, wx.wxALIGN_CENTER + wx.wxALL, 10 )

	UI.m_button8 = wx.wxButton( UI.m_panel8, wx.wxID_ANY, "Redo Setup", wx.wxDefaultPosition, wx.wxDefaultSize, 0 )
	UI.bSizer2:Add( UI.m_button8, 0, wx.wxALIGN_CENTER + wx.wxALL, 10 )


	UI.m_panel8:SetSizer( UI.bSizer2 )
	UI.m_panel8:Layout()
	UI.bSizer2:Fit( UI.m_panel8 )
	UI.m_notebook4:AddPage(UI.m_panel8, "Setup", True )
	UI.m_panel9 = wx.wxPanel( UI.m_notebook4, wx.wxID_ANY, wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxTAB_TRAVERSAL )
	UI.gSizer1 = wx.wxGridSizer( 1, 2, 0, 0 )


	UI.m_panel9:SetSizer( UI.gSizer1 )
	UI.m_panel9:Layout()
	UI.gSizer1:Fit( UI.m_panel9 )
	UI.m_notebook4:AddPage(UI.m_panel9, "Puppets", False )


	UI.MyFrame1 .m_mgr:Update()
	UI.MyFrame1:Centre( wx.wxBOTH )

	-- Connect Events

	UI.m_button8:Connect( wx.wxEVT_COMMAND_BUTTON_CLICKED, function(event)
        UI.m_textCtrl3:SetValue("Click :)")
	end )

    UI.MyFrame1:Show(true)

