-- Based On   		: QuikEmotes from Theodas
-- Author			: Yupyup - Area 52
-- Addon			: QuikTells
-- Create Date  	: 02.23.2012
-- Last Updated		: 04.28.2019

-- The button panel seen in the UI.  Needs to be global so we can redraw it when needed.
local tellButtonPanel = CreateFrame("Frame", "QuikTellsTellButtonFrame", UIParent)
local tellButtonArray = {	CreateFrame("Button", "QuikTellsTellButton1", tellButtonPanel, "UIPanelButtonTemplate"),
							CreateFrame("Button", "QuikTellsTellButton2", tellButtonPanel, "UIPanelButtonTemplate"),
							CreateFrame("Button", "QuikTellsTellButton3", tellButtonPanel, "UIPanelButtonTemplate"),
							CreateFrame("Button", "QuikTellsTellButton4", tellButtonPanel, "UIPanelButtonTemplate"),
							CreateFrame("Button", "QuikTellsTellButton5", tellButtonPanel, "UIPanelButtonTemplate"),
							CreateFrame("Button", "QuikTellsTellButton6", tellButtonPanel, "UIPanelButtonTemplate"),
							CreateFrame("Button", "QuikTellsTellButton7", tellButtonPanel, "UIPanelButtonTemplate"),
							CreateFrame("Button", "QuikTellsTellButton8", tellButtonPanel, "UIPanelButtonTemplate"),
							CreateFrame("Button", "QuikTellsTellButton9", tellButtonPanel, "UIPanelButtonTemplate"),
							CreateFrame("Button", "QuikTellsTellButton10", tellButtonPanel, "UIPanelButtonTemplate"),
							CreateFrame("Button", "QuikTellsTellButton11", tellButtonPanel, "UIPanelButtonTemplate"),
							CreateFrame("Button", "QuikTellsTellButton12", tellButtonPanel, "UIPanelButtonTemplate"),
							CreateFrame("Button", "QuikTellsTellButton13", tellButtonPanel, "UIPanelButtonTemplate"),
							CreateFrame("Button", "QuikTellsTellButton14", tellButtonPanel, "UIPanelButtonTemplate"),
							CreateFrame("Button", "QuikTellsTellButton15", tellButtonPanel, "UIPanelButtonTemplate")}

-- Constants defintion
local c = QuikTellsConfig

-- The hidden frame that does all the work of loading the addon
local quikTellsLoader = CreateFrame("Frame")
quikTellsLoader:Hide()
quikTellsLoader:RegisterEvent("ADDON_LOADED")
quikTellsLoader:SetScript("OnEvent", function(self, event, arg1)
	if event == "ADDON_LOADED" and arg1 == "QuikTells" then
		-- Get the saved values or set the defaults
		if (QuikTellsSavedVariableTable == nil) then
			-- TODO: Add new rows to saved values when new rows are added to defaults
			QuikTellsSavedVariableTable = c.quikTellsTableDefaultVariables
		end

		-- Create hide/show button
		QuikTells_LoadHideShowPanel()

		-- Create button frame
		QuikTells_LoadTellPanel()

		-- Show the button bar on launch?
		if (QuikTellsShowButtons == nil) then
			QuikTellsShowButtons = true
		end
	
		-- Load the config panel
		QuikTells_LoadConfigPanel()

		-- Unregister so we don't get more notifications
		self:UnregisterEvent("ADDON_LOADED")
	end
end)

function QuikTells_LoadHideShowPanel()
	local hideShowPanel = CreateFrame("Frame", "QuikTellsHideShowFrame", UIParent)
	hideShowPanel:SetPoint("CENTER", UIParent, "CENTER", 0, c.hideShowButtonPanelHeight)
	hideShowPanel:SetWidth(c.hideShowButtonPanelWidth)
	hideShowPanel:SetHeight(c.hideShowButtonPanelHeight)
	hideShowPanel:SetBackdrop({	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark", 
								edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", 
								tile = true, tileSize = 16, edgeSize = 16, 
								insets = { left = 0, right = 0, top = 0, bottom = 0}})
	hideShowPanel:SetBackdropColor(0,0,0,1)
	hideShowPanel:RegisterForDrag("LeftButton")
	hideShowPanel:SetMovable(true)
	hideShowPanel:EnableMouse(true)
	hideShowPanel:SetScript("OnDragStart", hideShowPanel.StartMoving)
	hideShowPanel:SetScript("OnDragStop", hideShowPanel.StopMovingOrSizing)

	local hideShowButton = CreateFrame("Button", "QuikTellsHideShowButton", hideShowPanel, "UIPanelButtonTemplate")
	hideShowButton:SetText("QuikTells")
	hideShowButton:SetPoint("TOPLEFT", hideShowPanel, "TOPLEFT", c.hideShowButtonPanelBuffer, -c.hideShowButtonPanelBuffer)
	hideShowButton:SetWidth(c.hideShowButtonPanelWidth - (c.hideShowButtonPanelBuffer * 2))
	hideShowButton:SetHeight(c.hideShowButtonPanelHeight - (c.hideShowButtonPanelBuffer * 2))
	hideShowButton:SetScript("OnClick", function(self)
		QuikTells_HideShowButton_OnClick()
	end)
end

function QuikTells_ReloadTellPanel()
	for i = 1, table.getn(tellButtonArray) do
		tellButtonArray[i]:Hide()
	end
	tellButtonPanel:Hide()
	QuikTells_LoadTellPanel()
end

function QuikTells_LoadTellPanel()
	local numberOfEnabledButtons = 0
	for i = 1, table.getn(QuikTellsSavedVariableTable) do
		local currentValues = QuikTellsSavedVariableTable[i]
		if currentValues[c.quikTellsTableEnabledColumn] == c.quikTellsRowEnabled then
			numberOfEnabledButtons = numberOfEnabledButtons + 1
		end
	end

	local panelWidth = (numberOfEnabledButtons * c.tellButtonWidth) + (numberOfEnabledButtons  * c.tellButtonXSpacing) + c.tellButtonXSpacing
	tellButtonPanel:Hide()
	tellButtonPanel:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	tellButtonPanel:SetWidth(panelWidth)
	tellButtonPanel:SetHeight(c.tellButtonFrameHeight + c.tellButtonYSpacing)
	tellButtonPanel:SetBackdrop({	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark", 
									edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", 
									tile = true, tileSize = 16, edgeSize = 16, 
									insets = { left = 0, right = 0, top = 0, bottom = 0}})
	tellButtonPanel:SetBackdropColor(0,0,0,1)
	tellButtonPanel:RegisterForDrag("LeftButton")
	tellButtonPanel:SetMovable(true)
	tellButtonPanel:EnableMouse(true)
	tellButtonPanel:SetScript("OnDragStart", tellButtonPanel.StartMoving)
	tellButtonPanel:SetScript("OnDragStop", tellButtonPanel.StopMovingOrSizing)

	-- TODO: Hide when entering pet battles
	-- TODO: Hide when entering vehicles?

	-- Show the button bar(s) on launch?
	if (QuikTellsShowButtons == nil) then
		QuikTellsShowButtons = true
	end

	if (QuikTellsShowButtons == true) then 
		tellButtonPanel:Show()
	else
		tellButtonPanel:Hide()
	end

	local enabledButtonNumber = 0
	for i = 1, table.getn(QuikTellsSavedVariableTable) do
		local currentValues = QuikTellsSavedVariableTable[i]
		if currentValues[c.quikTellsTableEnabledColumn] == c.quikTellsRowEnabled then
			local xCoord = (enabledButtonNumber * c.tellButtonWidth) + (enabledButtonNumber * c.tellButtonXSpacing)
			local tellButton = tellButtonArray[i]
			tellButton:Show()
			tellButton:SetText(currentValues[c.quikTellsTableNameColumn])
			tellButton:SetPoint("TOPLEFT", tellButtonPanel, "TOPLEFT", xCoord + c.tellButtonXSpacing, -c.tellButtonYSpacing)
			tellButton:SetWidth(c.tellButtonWidth)
			tellButton:SetHeight(c.tellButtonFrameHeight - (2 * c.tellButtonYSpacing))
			tellButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
			tellButton:SetScript("OnClick", function(self, button, down)
				QuikTells_TellButton_OnClick(i, button)
			end)
			enabledButtonNumber = enabledButtonNumber + 1
		end
	end
end

function QuikTells_HideShowButton_OnClick()
	if (QuikTellsShowButtons == true) then 
		tellButtonPanel:Hide()
		QuikTellsShowButtons = false
	else
		tellButtonPanel:Show()
		QuikTellsShowButtons = true
	end	
end

function QuikTells_TellButton_OnClick(buttonNumber, mouseButtonName)
	local currentValues = QuikTellsSavedVariableTable[buttonNumber]
	local actionString = "None"
	if (mouseButtonName == "LeftButton") then
		actionString = currentValues[c.quikTellsTableLeftActionColumn]
	else 
		if (mouseButtonName == "RightButton") then
			actionString = currentValues[c.quikTellsTableRightActionColumn]
		end
	end

	-- Check for pull countdown action
	if (actionString == "Pull In 10") then
		DEFAULT_CHAT_FRAME.editBox:SetText("/pull 10") 
		ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
	else
		-- Check for reload ui
		if (actionString == "Reload UI") then
			DEFAULT_CHAT_FRAME.editBox:SetText("/reload ui") 
			ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
		else
			-- Check for emote
			local emoteIndex = string.find(actionString, "Emote ", 1)
			if (emoteIndex ~= nil) then
				local emote = string.sub(actionString, emoteIndex + 6)
				DoEmote(emote)
			else
				-- Must be a text
				SendChatMessage(currentValues[c.quikTellsTableTextColumn], string.upper(actionString))
			end
		end
	end
end

-- TODO: Reload button bar when config closed or values change
function QuikTells_LoadConfigPanel()
	-- Create config screen
	local configPanel = CreateFrame("Frame", "QuikTellsOptions", InterfaceOptionsFramePanelContainer)
	configPanel.name = "QuikTells"
	configPanel:Hide()
	InterfaceOptions_AddCategory(configPanel)

	-- Create title
	local title = configPanel:CreateFontString("ARTWORK")
	title:SetFontObject("GameFontNormalLarge")
	title:SetPoint("TOPLEFT", configPanel, "TOPLEFT", 10, -15)
	title:SetText("QuikTells")

	-- Create column headers
	QuikTells_createConfigColumnHeaderLabel(configPanel, "Show", c.configXCoords[1] - 5) -- subtract 5 to line up correctly
	QuikTells_createConfigColumnHeaderLabel(configPanel, "Name", c.configXCoords[2])
	QuikTells_createConfigColumnHeaderLabel(configPanel, "Text", c.configXCoords[3])
	QuikTells_createConfigColumnHeaderLabel(configPanel, "Left Click Action", c.configXCoords[4] + 20) -- add 20 to line up correctly
	QuikTells_createConfigColumnHeaderLabel(configPanel, "Right Click Action", c.configXCoords[5] + 20) -- add 20 to line up correctly

	for i = 1, table.getn(QuikTellsSavedVariableTable) do
		local yCoord = c.configFirstYCoord + (i * c.configYCoordSpacing)
		local currentValues = QuikTellsSavedVariableTable[i]

		-- Create enabled on/off check boxes
		QuikTells_createConfigCheckBox(configPanel, i, c.configXCoords[1], yCoord, currentValues)

		-- Create button name entry fields
		QuikTells_createConfigTextEntry(configPanel, i, c.configButtonNameWidth, c.configXCoords[2], yCoord, currentValues, c.quikTellsTableNameColumn)

		-- Create text entry fields
		QuikTells_createConfigTextEntry(configPanel, i, c.configButtonTextWidth, c.configXCoords[3], yCoord, currentValues, c.quikTellsTableTextColumn)

		-- Create left button click actions
		QuikTells_createConfigChannelDropdown(configPanel, i, c.configXCoords[4], yCoord + 3, currentValues, c.quikTellsTableLeftActionColumn) -- add 3 to line up correctly

		-- Create right button click actions
		QuikTells_createConfigChannelDropdown(configPanel, i, c.configXCoords[5], yCoord + 3, currentValues, c.quikTellsTableRightActionColumn) -- add 3 to line up correctly
	end
end

function QuikTells_createConfigColumnHeaderLabel(parentFrame, name, xCoord)
	local header = parentFrame:CreateFontString("ARTWORK")
	header:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", xCoord, c.configHeaderYCoord)
	header:SetFontObject("GameFontNormal")
	header:SetText(name)
end

function QuikTells_createConfigCheckBox(parentFrame, buttonNumber, xCoord, yCoord, currentValues)
	local checkBoxButton = CreateFrame("CheckButton", "checkBox" .. buttonNumber, parentFrame, "ChatConfigCheckButtonTemplate")
	checkBoxButton:SetPoint("TOPLEFT", xCoord, yCoord)
	checkBoxButton:SetWidth(c.configCheckBoxSize)
	checkBoxButton:SetHeight(c.configCheckBoxSize)
	checkBoxButton:SetHitRectInsets(0, 0, 0, 0)
	checkBoxButton:SetChecked(currentValues[c.quikTellsTableEnabledColumn] == c.quikTellsRowEnabled)
	checkBoxButton:SetScript("OnClick", function(self)
		if (self:GetChecked() == true) then
			currentValues[c.quikTellsTableEnabledColumn] = c.quikTellsRowEnabled
		else
			currentValues[c.quikTellsTableEnabledColumn] = c.quikTellsRowDisabled
		end

		-- Reload the tool bar now that a button was hidden or shown
		QuikTells_ReloadTellPanel()
	end)
end

function QuikTells_createConfigTextEntry(parentFrame, buttonNumber, width, xCoord, yCoord, currentValues, index)
	local textEntry = CreateFrame("EditBox", "textEntry" .. buttonNumber, parentFrame, "InputBoxTemplate")
	textEntry:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", xCoord, yCoord)
	textEntry:SetFontObject("GameFontWhite")
	textEntry:SetWidth(width)
	textEntry:SetHeight(c.configRowHeight)
	textEntry:SetText(currentValues[index])
	textEntry:SetScript("OnLeave", function(self, motion)
		currentValues[index] = self:GetText()

		-- If this is the name column, reload the tool bar as a name was changed
		if (index == c.quikTellsTableNameColumn) then
			QuikTells_ReloadTellPanel()
		end
	end)
end

function QuikTells_createConfigChannelDropdown(parentFrame, buttonNumber, xCoord, yCoord, currentValues, index)
	local dropDown = CreateFrame("FRAME", "WPDemoDropDown", parentFrame, "UIDropDownMenuTemplate")
	dropDown:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", xCoord, yCoord)
	UIDropDownMenu_SetWidth(dropDown, c.configDropDownWidth)
	UIDropDownMenu_SetText(dropDown, currentValues[index])

	UIDropDownMenu_Initialize(dropDown, function(self, level, menuList)
		local info = UIDropDownMenu_CreateInfo()

		if (level == 1) then
			for i = 1, table.getn(c.channelOptions) do
				info.text = c.channelOptions[i]
				info.arg1 = c.channelOptions[i]
				info.menuList = c.channelOptions[i]

				if (c.channelOptions[i] == "Emote" or c.channelOptions[i] == "Custom") then
					info.hasArrow = true
				else
					info.func = self.SetValue
				end

				UIDropDownMenu_AddButton(info)
			end
		else 
			if (menuList == "Emote") then 
				for i = 1, table.getn(emoteOptions) do
					info.text = c.emoteOptions[i]
					info.arg1 = c.emoteOptions[i]	
					info.func = self.SetValue
					UIDropDownMenu_AddButton(info, level)
				end
			else 
				if (menuList == "Custom") then
					for i = 1, table.getn(customOptions) do
						info.text = c.customOptions[i]
						info.arg1 = c.customOptions[i]	
						info.func = self.SetValue
						UIDropDownMenu_AddButton(info, level)
					end
				end
			end
		end
	end)

	function dropDown:SetValue(newValue)
		currentValues[index] = newValue
		UIDropDownMenu_SetText(dropDown, newValue)
		CloseDropDownMenus()
	end
end
