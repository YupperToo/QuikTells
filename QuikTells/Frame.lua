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

local function createDropdown(parentFrame, displayText, yCoord)
	local dropDown = CreateFrame("Button", displayText, parentFrame, UIDropDownMenuTemplate)
	dropDown:SetText(displayText)
	dropDown:SetSize(30,100)
	dropDown:SetPoint("TOPLEFT", panel, "TOPLEFT", 5, yCoord)
	return dropDown
end

function LoadQuikTells()
	local panel = CreateFrame("Frame", "QuikTellsOptions", InterfaceOptionsFramePanelContainer)
	panel.name = "QuikTells"

	createDropdown(panel, "Button1", 10)
	createDropdown(panel, "Button2", 40)
	createDropdown(panel, "Button3", 70)
	createDropdown(panel, "Button4", 100)

	InterfaceOptions_AddCategory(panel)
end

