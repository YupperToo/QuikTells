-- Author   		: Theodas
-- Last Modified By	: MasterZeus
-- Addon			: QuikTells
-- Create Date  	: 02.23.2012
-- Last Updated		: 03.09.2019

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

-- End Groups
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
	QuikTells_OnClick()
	LoadConfigPanel()
end

local xCoords = {20, 70, 200, 325, 450}
local yCoords = {-75, -100, -125, -150, -175, -200, -225, -250, -275, -300, -325, -350}
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
	createConfigColumnHeaderLabel(configPanel, "Show", xCoords[1])
	createConfigColumnHeaderLabel(configPanel, "Name", xCoords[2])
	createConfigColumnHeaderLabel(configPanel, "Text", xCoords[3])
	createConfigColumnHeaderLabel(configPanel, "Left Click Action", xCoords[4] + 25) -- add 25 to line up correctly
	createConfigColumnHeaderLabel(configPanel, "Right Click Action", xCoords[5] + 25) -- add 25 to line up correctly

	for i = 1, table.getn(yCoords) do
		-- Create enabled on/off check boxes

		-- Create button name entry fields

		-- Create text entry fields

		-- Create left button click actions
		createConfigChannelDropdown(configPanel, i, xCoords[4], yCoords[i])

		-- Create right button click actions
		createConfigChannelDropdown(configPanel, i, xCoords[5], yCoords[i])
	end
end

function createConfigColumnHeaderLabel(parentFrame, name, xCoord)
	local header = parentFrame:CreateFontString("ARTWORK")
	header:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", xCoord, -50)
	header:SetFontObject("GameFontNormal")
	header:SetText(name)
end

local channelOptions = {"Say", "Yell", "Raid", "Emote", "Custom"}
local emoteOptions = {"Emote Dance", "Emote Salute"}
local customOptions = {"DMB Pull"}

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