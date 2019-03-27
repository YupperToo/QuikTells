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

-- TODO: Save this value in config
local open=0;
function QuikTells_OnClick()
	if (open==0) then 
		TellButtons:Hide();
		open=1;
	else
		TellButtons:Show();
		open=0;
	end	
end

function LoadQuikTells()
	-- TODO: Create button frames
	QuikTells_OnClick()
	LoadConfigPanel()
end

local configXCoords = {20, 70, 130, 270, 395}
local configYCoords = {-75, -100, -125, -150, -175, -200, -225, -250, -275, -300, -325, -350}
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
	createConfigColumnHeaderLabel(configPanel, "Show", configXCoords[1])
	createConfigColumnHeaderLabel(configPanel, "Name", configXCoords[2])
	createConfigColumnHeaderLabel(configPanel, "Text", configXCoords[3])
	createConfigColumnHeaderLabel(configPanel, "Left Click Action", configXCoords[4] + 20) -- add 20 to line up correctly
	createConfigColumnHeaderLabel(configPanel, "Right Click Action", configXCoords[5] + 20) -- add 20 to line up correctly

	for i = 1, table.getn(configYCoords) do
		-- Create enabled on/off check boxes
		createConfigCheckBox(configPanel, i, configXCoords[1], configYCoords[i])

		-- Create button name entry fields
		createConfigTextEntry(configPanel, i, 50, configXCoords[2], configYCoords[i], 50)

		-- Create text entry fields
		createConfigTextEntry(configPanel, i, 100, configXCoords[3], configYCoords[i], 150)

		-- Create left button click actions
		createConfigChannelDropdown(configPanel, i, configXCoords[4], configYCoords[i] + 3) -- add 3 to line up correctly

		-- Create right button click actions
		createConfigChannelDropdown(configPanel, i, configXCoords[5], configYCoords[i] + 3) -- add 3 to line up correctly
	end
end

function createConfigColumnHeaderLabel(parentFrame, name, xCoord)
	local header = parentFrame:CreateFontString("ARTWORK")
	header:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", xCoord, -50)
	header:SetFontObject("GameFontNormal")
	header:SetText(name)
end

function createConfigCheckBox(parentFrame, buttonNumber, xCoord, yCoord)
	local checkBoxButton = CreateFrame("CheckButton", "checkBox" .. buttonNumber, parentFrame, "ChatConfigCheckButtonTemplate")
	checkBoxButton:SetPoint("TOPLEFT", xCoord, yCoord)
	checkBoxButton:SetWidth(20)
	checkBoxButton:SetHeight(20)
	checkBoxButton:SetScript("OnClick", 
	  function()
		--TODO: Save the value
	  end
	)
end

function createConfigTextEntry(parentFrame, buttonNumber, width, xCoord, yCoord, width)
	local textEntry = CreateFrame("EditBox", "textEntry" .. buttonNumber, parentFrame, "InputBoxTemplate")
	textEntry:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", xCoord, yCoord)
	textEntry:SetFontObject("GameFontNormal")
	textEntry:SetWidth(width)
	textEntry:SetHeight(20)
	textEntry:SetText("text here") -- TODO: Get save value to display here
end

local channelOptions = {"Say", "Yell", "Raid", "Emote", "Custom"}
local emoteOptions = {"Emote Dance", "Emote Salute"}
local customOptions = {"DMB Pull", "Reload UI"}

function createConfigChannelDropdown(parentFrame, buttonNumber, xCoord, yCoord)
	local dropDown = CreateFrame("FRAME", "WPDemoDropDown", parentFrame, "UIDropDownMenuTemplate")
	dropDown:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", xCoord, yCoord)
	UIDropDownMenu_SetWidth(dropDown, 100)
	UIDropDownMenu_SetText(dropDown, "Say") -- TODO: Get saved value to display here
	
	-- Create and bind the initialization function to the dropdown menu
	UIDropDownMenu_Initialize(dropDown, 
	function(self, level, menuList)
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