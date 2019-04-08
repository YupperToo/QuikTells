-- Author   		: Theodas
-- Last Modified By	: MasterZeus
-- Addon			: QuikTells
-- Create Date  	: 02.23.2012
-- Last Updated		: 03.09.2019

-- TODO: Refactor all these!
function Button23_OnClick()
	if (GetMouseButtonClicked() == "RightButton") then
		SendChatMessage("Hello all :)", "YELL")
	else
		SendChatMessage("Hello all :)", "SAY")
	end
end

function Button24_OnClick()
	if (GetMouseButtonClicked() == "RightButton") then
		SendChatMessage("KILL ADD!!!!", "YELL")
	else
		SendChatMessage("Kill add!", "SAY")
	end
end

function Button25_OnClick()
	if (GetMouseButtonClicked() == "RightButton") then
		SendChatMessage("Focus fire on main mob", "YELL")
	else
		SendChatMessage("Focus fire on main mob", "SAY")
	end
end

function Button26_OnClick()
	if (GetMouseButtonClicked() == "RightButton") then
		SendChatMessage("LOL", "YELL")
	else
		SendChatMessage("lol", "SAY")
	end
end

function Button27_OnClick()
	if (GetMouseButtonClicked() == "RightButton") then
		SendChatMessage("Thanks all! :)", "YELL")
	else
		SendChatMessage("Thanks all! :)", "SAY")
	end
end

function Button28_OnClick()
	if (GetMouseButtonClicked() == "RightButton") then
		SendChatMessage("Grab your gems!", "YELL")
	else
		SendChatMessage("Grab your gems!", "SAY")
	end
end

function Button29_OnClick()
	if (GetMouseButtonClicked() == "RightButton") then
		DEFAULT_CHAT_FRAME.editBox:SetText("/pull 10") 
		ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
	else
		SendChatMessage("Pulling", "SAY")
	end
end

function Button30_OnClick()
	if (GetMouseButtonClicked() == "RightButton") then
		SendChatMessage("STAY BACK!", "YELL")
	else
		SendChatMessage("Stay back to not pull boss", "SAY")
	end
end

function Button31_OnClick()
	if (GetMouseButtonClicked() == "RightButton") then
		SendChatMessage("Taunt Him!", "YELL")
	else
		SendChatMessage("Taunt him pease", "SAY")
	end
end

function Button32_OnClick()
	if (GetMouseButtonClicked() == "RightButton") then
		SendChatMessage("ONE AT A TIME!", "YELL")
	else
		SendChatMessage("One group at a time please", "SAY")
	end
end

function Button33_OnClick()
	if (GetMouseButtonClicked() == "RightButton") then
		SendChatMessage("Turn off pet taunt please!", "YELL")
	else
		SendChatMessage("Turn off pet taunt please!", "SAY")
	end
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(self, event, arg1)
	if event == "ADDON_LOADED" and arg1 == "QuikTells" then
		-- Get the saved values or set the defaults
		if (QuikTellsSavedVariableTable == nil) then
			-- TODO: Move these somewhere more convenient
			-- TODO: Add new rows to saved values when new rows are added to defaults
			QuikTellsSavedVariableTable = {
				{"Enabled", "Hi", "Hello everyone!", "Say", "Raid"},
				{"Enabled", "Bye", "Goodbye all!", "Say", "Raid"},
				{"Enabled", "Thx", "Thank you!", "Say", "Raid"},
				{"Enabled", "LOL", "LOL!", "Say", "Raid"},
				{"Enabled", "Add", "Focus fire on Add", "Say", "Raid"},
				{"Enabled", "Main", "Focus fire on Main", "Say", "Raid"},
				{"Enabled", "Salute", "Props to you", "Say", "Emote Salute"},
				{"Enabled", "Pet", "Oh, so cute!", "Say", "Emote Pet"},
				{"Enabled", "Dance", "Dance Party!", "Say", "Emote Dance"},
				{"Enabled", "Pull", "Pulling in 10!", "Raid", "Pull In 10"},
				{"Disabled", "Inter", "Interupt the caster!", "Yell", "Raid"},
				{"Disabled", "Reload", "BRB in 1 min", "Raid", "Reload UI"},
				{"Disabled", "Chick", "Chickin!", "Say", "Emote Chicken"},
				{"Disabled", "Flirt", "How you doin'?", "Say", "Emote Flirt"},
				{"Disabled", "Cheer", "Yeah!!!!!", "Say", "Emote Cheer"}}
		end

		-- Create hide/show button
		LoadHideShowPanel()

		-- Create button frames
		LoadTellPanel()

		-- Show the button bar(s) on launch?
		if (QuikTellsShowButtons == nil) then
			QuikTellsShowButtons = true
		else
			if (QuikTellsShowButtons == true) then 
				TellButtons:Show()
			else
				TellButtons:Hide()
			end
		end
	
		-- Load the config panel
		LoadConfigPanel()

		-- Unregister so we don't get more notifications
		self:UnregisterEvent("ADDON_LOADED")
	end
end)

function LoadHideShowPanel()
	local hideShowPanel = CreateFrame("Frame", "QuikTellsHideShowFrame", UIParent)
	hideShowPanel:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	hideShowPanel:SetWidth(100)
	hideShowPanel:SetHeight(30)
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
	hideShowButton:SetPoint("TOPLEFT", hideShowPanel, "TOPLEFT", 3, -3)
	hideShowButton:SetWidth(94)
	hideShowButton:SetHeight(22)
	hideShowButton:SetScript("OnClick", function(self)
		QuikTells_OnClick()
	end)
end

local tellButtonWidth = 50
local tellButtonXSpacing = 2
local tellButtonPanel = CreateFrame("Frame", "QuikTellsTellButtonFrame", UIParent)

function LoadTellPanel()
	local numberOfEnabledButtons = 0
	for i = 1, table.getn(QuikTellsSavedVariableTable) do
		local currentValues = QuikTellsSavedVariableTable[i]
		if currentValues[1] == "Enabled" then
			numberOfEnabledButtons = numberOfEnabledButtons + 1
		end
	end

	local panelWidth = (numberOfEnabledButtons * tellButtonWidth) + (numberOfEnabledButtons  * tellButtonXSpacing) + tellButtonXSpacing
	tellButtonPanel:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	tellButtonPanel:SetWidth(panelWidth)
	tellButtonPanel:SetHeight(30)
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

	-- Show the button bar(s) on launch?
	if (QuikTellsShowButtons == nil) then
		QuikTellsShowButtons = true
	else
		if (QuikTellsShowButtons == true) then 
			tellButtonPanel:Show()
		else
			tellButtonPanel:Hide()
		end
	end

	local enabledButtonNumber = 0
	for i = 1, table.getn(QuikTellsSavedVariableTable) do
		local currentValues = QuikTellsSavedVariableTable[i]
		if currentValues[1] == "Enabled" then
			local xCoord = (enabledButtonNumber * tellButtonWidth) + (enabledButtonNumber * tellButtonXSpacing)
			local tellButton = CreateFrame("Button", "QuikTellsTellButton" .. i, tellButtonPanel, "UIPanelButtonTemplate")
			tellButton:SetText(currentValues[2])
			tellButton:SetPoint("TOPLEFT", tellButtonPanel, "TOPLEFT", xCoord + tellButtonXSpacing, -3)
			tellButton:SetWidth(tellButtonWidth)
			tellButton:SetHeight(22)
			tellButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
			tellButton:SetScript("OnClick", function(self, button, down)
				TellButton_OnClick(i, button)
			end)
			enabledButtonNumber = enabledButtonNumber + 1
		end
	end
end

function QuikTells_OnClick()
	if (QuikTellsShowButtons == true) then 
		TellButtons:Hide()
		tellButtonPanel:Hide()
		QuikTellsShowButtons = false
	else
		TellButtons:Show()
		tellButtonPanel:Show()
		QuikTellsShowButtons = true
	end	
end

function TellButton_OnClick(buttonNumber, mouseButtonName)
	local currentValues = QuikTellsSavedVariableTable[buttonNumber]
	local actionString = "None"
	if (mouseButtonName == "LeftButton") then
		actionString = currentValues[4]
	else 
		if (mouseButtonName == "RightButton") then
			actionString = currentValues[5]
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
				SendChatMessage(currentValues[3], string.upper(actionString))
			end
		end
	end
end

-- TODO: Reload button bar when config closed or values change
local configXCoords = {20, 70, 130, 320, 445}
local configHeaderYCoord = -55
local configFirstYCoord = -50 -- Note: first y coord will include configYCoordSpacing because arrays start at 1 in LUA
local configYCoordSpacing = -25

function LoadConfigPanel()
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
	createConfigColumnHeaderLabel(configPanel, "Show", configXCoords[1] - 5) -- subtract 5 to line up correctly
	createConfigColumnHeaderLabel(configPanel, "Name", configXCoords[2])
	createConfigColumnHeaderLabel(configPanel, "Text", configXCoords[3])
	createConfigColumnHeaderLabel(configPanel, "Left Click Action", configXCoords[4] + 20) -- add 20 to line up correctly
	createConfigColumnHeaderLabel(configPanel, "Right Click Action", configXCoords[5] + 20) -- add 20 to line up correctly

	for i = 1, table.getn(QuikTellsSavedVariableTable) do
		local yCoord = configFirstYCoord + (i * configYCoordSpacing)
		local currentValues = QuikTellsSavedVariableTable[i]

		-- Create enabled on/off check boxes
		createConfigCheckBox(configPanel, i, configXCoords[1], yCoord, currentValues)

		-- Create button name entry fields
		createConfigTextEntry(configPanel, i, 50, configXCoords[2], yCoord, 50, currentValues, 2)

		-- Create text entry fields
		createConfigTextEntry(configPanel, i, 100, configXCoords[3], yCoord, 200, currentValues, 3)

		-- Create left button click actions
		createConfigChannelDropdown(configPanel, i, configXCoords[4], yCoord + 3, currentValues, 4) -- add 3 to line up correctly

		-- Create right button click actions
		createConfigChannelDropdown(configPanel, i, configXCoords[5], yCoord + 3, currentValues, 5) -- add 3 to line up correctly
	end
end

function createConfigColumnHeaderLabel(parentFrame, name, xCoord)
	local header = parentFrame:CreateFontString("ARTWORK")
	header:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", xCoord, configHeaderYCoord)
	header:SetFontObject("GameFontNormal")
	header:SetText(name)
end

function createConfigCheckBox(parentFrame, buttonNumber, xCoord, yCoord, currentValues)
	local checkBoxButton = CreateFrame("CheckButton", "checkBox" .. buttonNumber, parentFrame, "ChatConfigCheckButtonTemplate")
	checkBoxButton:SetPoint("TOPLEFT", xCoord, yCoord)
	checkBoxButton:SetWidth(20)
	checkBoxButton:SetHeight(20)
	checkBoxButton:SetHitRectInsets(0, 0, 0, 0)
	checkBoxButton:SetChecked(currentValues[1] == "Enabled")
	checkBoxButton:SetScript("OnClick", function(self)
		if (self:GetChecked() == true) then
			currentValues[1] = "Enabled"
		else
			currentValues[1] = "Disabled"
		end
	end)
end

function createConfigTextEntry(parentFrame, buttonNumber, width, xCoord, yCoord, width, currentValues, index)
	local textEntry = CreateFrame("EditBox", "textEntry" .. buttonNumber, parentFrame, "InputBoxTemplate")
	textEntry:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", xCoord, yCoord)
	textEntry:SetFontObject("GameFontWhite")
	textEntry:SetWidth(width)
	textEntry:SetHeight(20)
	textEntry:SetText(currentValues[index])
	textEntry:SetScript("OnLeave", function(self, motion)
		currentValues[index] = self:GetText()
	end)
end

-- TODO: Move these somewhere more convenient
local channelOptions = {"Say", "Yell", "Party", "Raid", "Emote", "Custom"}
local emoteOptions = {"Emote Cheer", "Emote Chicken", "Emote Dance", "Emote Flirt", "Emote Hi", "Emote Pet", "Emote Salute", "Emote Sit", "Emote Sleep"}
local customOptions = {"Pull In 10", "Reload UI"}

function createConfigChannelDropdown(parentFrame, buttonNumber, xCoord, yCoord, currentValues, index)
	local dropDown = CreateFrame("FRAME", "WPDemoDropDown", parentFrame, "UIDropDownMenuTemplate")
	dropDown:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", xCoord, yCoord)
	UIDropDownMenu_SetWidth(dropDown, 100)
	UIDropDownMenu_SetText(dropDown, currentValues[index])
	
	UIDropDownMenu_Initialize(dropDown, function(self, level, menuList)
		local info = UIDropDownMenu_CreateInfo()

		if (level == 1) then
			for i = 1, table.getn(channelOptions) do
				info.text = channelOptions[i]
				info.arg1 = channelOptions[i]
				info.menuList = channelOptions[i]

				if (channelOptions[i] == "Emote" or channelOptions[i] == "Custom") then
					info.hasArrow = true
				else
					info.func = self.SetValue
				end

				UIDropDownMenu_AddButton(info)
			end
		else 
			if (menuList == "Emote") then 
				for i = 1, table.getn(emoteOptions) do
					info.text = emoteOptions[i]
					info.arg1 = emoteOptions[i]	
					info.func = self.SetValue
					UIDropDownMenu_AddButton(info, level)
				end
			else 
				if (menuList == "Custom") then
					for i = 1, table.getn(customOptions) do
						info.text = customOptions[i]
						info.arg1 = customOptions[i]	
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