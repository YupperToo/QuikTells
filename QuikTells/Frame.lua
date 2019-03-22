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

local favoriteNumber = 42
function LoadQuikTells()
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

	-- Create button name entry fields

	-- Create text entry fields

	-- Create left button click actions
	createChannelDropdown(configPanel, 1, 100, -100)
	createChannelDropdown(configPanel, 2, 100, -125)
	createChannelDropdown(configPanel, 3, 100, -150)
	createChannelDropdown(configPanel, 4, 100, -175)
	createChannelDropdown(configPanel, 4, 100, -200)

	-- Create right button click actions
	createChannelDropdown(configPanel, 1, 200, -100)
	createChannelDropdown(configPanel, 2, 200, -125)
	createChannelDropdown(configPanel, 3, 200, -150)
	createChannelDropdown(configPanel, 4, 200, -175)
	createChannelDropdown(configPanel, 4, 200, -200)

	-- Create custom action entry fields
end

local channelOptions = {"Say", "Yell", "Raid", "Custom"}
function createChannelDropdown(parentFrame, buttonNumber, xCoord, yCoord)
	local dropDown = CreateFrame("FRAME", "WPDemoDropDown", parentFrame, "UIDropDownMenuTemplate")
	dropDown:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", xCoord, yCoord)
	UIDropDownMenu_SetWidth(dropDown, 75)
	UIDropDownMenu_SetText(dropDown, "Say")
	
	-- Create and bind the initialization function to the dropdown menu
	UIDropDownMenu_Initialize(dropDown, 
	function(self, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		for i = 1, table.getn(channelOptions) do
			info.text = channelOptions[i]
			info.arg1 = buttonNumber
			UIDropDownMenu_AddButton(info)
		end
	end)

	function dropDown:SetValue(newValue)
		UIDropDownMenu_SetText(dropDown, newValue)
		CloseDropDownMenus()
	end
end




