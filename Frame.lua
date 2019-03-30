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

function QuikTells_OnClick()
	if (QuikTellsShowButtons == true) then 
		TellButtons:Hide()
		QuikTellsShowButtons = false
	else
		TellButtons:Show()
		QuikTellsShowButtons = true
	end	
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(self, event, arg1)
	if event == "ADDON_LOADED" and arg1 == "QuikTells" then
		-- Get the saved values or set the defaults
		if (QuikTellsSavedVariableTable == nil) then
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
				{"Enabled", "Pull", "Pulling in 10!", "Raid", "DMB Pull"}}
		end

		-- TODO: Create hide/show button

		-- TODO: Create button frames

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

local configXCoords = {20, 70, 130, 320, 445}
local configHeaderYCoord = -55
local configFirstYCoord = -50 -- Note: first y coord will include ycoordspace because arrays start at 1
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
		local checked = currentValues[1]
		createConfigCheckBox(configPanel, i, configXCoords[1], yCoord, checked == "Enabled")

		-- Create button name entry fields
		local buttonName = currentValues[2]
		createConfigTextEntry(configPanel, i, 50, configXCoords[2], yCoord, 50, buttonName)

		-- Create text entry fields
		local textValue = currentValues[3]
		createConfigTextEntry(configPanel, i, 100, configXCoords[3], yCoord, 200, textValue)

		-- Create left button click actions
		local leftClick = currentValues[4]
		createConfigChannelDropdown(configPanel, i, configXCoords[4], yCoord + 3, leftClick) -- add 3 to line up correctly

		-- Create right button click actions
		local rightClick = currentValues[5]
		createConfigChannelDropdown(configPanel, i, configXCoords[5], yCoord + 3, rightClick) -- add 3 to line up correctly
	end
end

function createConfigColumnHeaderLabel(parentFrame, name, xCoord)
	local header = parentFrame:CreateFontString("ARTWORK")
	header:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", xCoord, configHeaderYCoord)
	header:SetFontObject("GameFontNormal")
	header:SetText(name)
end

function createConfigCheckBox(parentFrame, buttonNumber, xCoord, yCoord, enabled)
	local checkBoxButton = CreateFrame("CheckButton", "checkBox" .. buttonNumber, parentFrame, "ChatConfigCheckButtonTemplate")
	checkBoxButton:SetPoint("TOPLEFT", xCoord, yCoord)
	checkBoxButton:SetWidth(20)
	checkBoxButton:SetHeight(20)
	checkBoxButton:SetHitRectInsets(0, 0, 0, 0)
	checkBoxButton:SetChecked(enabled)
	checkBoxButton:SetScript("OnClick", function(self)
		--TODO: Save the value
	end)
end

function createConfigTextEntry(parentFrame, buttonNumber, width, xCoord, yCoord, width, currentValue)
	local textEntry = CreateFrame("EditBox", "textEntry" .. buttonNumber, parentFrame, "InputBoxTemplate")
	textEntry:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", xCoord, yCoord)
	textEntry:SetFontObject("GameFontWhite")
	textEntry:SetWidth(width)
	textEntry:SetHeight(20)
	textEntry:SetText(currentValue)
	textEntry:SetScript("OnEnterPressed", function(self)
		self:ClearFocus()
		-- TODO: Save the value
	end)
end

local channelOptions = {"Say", "Yell", "Party", "Raid", "Emote", "Custom"}
local emoteOptions = {"Emote Dance", "Emote Salute", "Emote Flirt", "Emote Pet", "Emote Sit", "Emote Sleep"}
local customOptions = {"DMB Pull", "Reload UI"}

function createConfigChannelDropdown(parentFrame, buttonNumber, xCoord, yCoord, currentValue)
	local dropDown = CreateFrame("FRAME", "WPDemoDropDown", parentFrame, "UIDropDownMenuTemplate")
	dropDown:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", xCoord, yCoord)
	UIDropDownMenu_SetWidth(dropDown, 100)
	UIDropDownMenu_SetText(dropDown, currentValue)
	
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
		UIDropDownMenu_SetText(dropDown, newValue) -- TODO: Save the choosen value
		CloseDropDownMenus()
	end
end