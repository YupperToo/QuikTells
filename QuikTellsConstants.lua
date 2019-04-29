-- Author			: Yupyup - Area 52
-- Addon			: QuikTells
-- Last Updated		: 04.28.2019

QuikTellsConfig = {
	quikTellsTableEnabledColumn = 1,
	quikTellsTableNameColumn = 2,
	quikTellsTableTextColumn = 3,
	quikTellsTableLeftActionColumn = 4,
	quikTellsTableRightActionColumn = 5,

	quikTellsRowEnabled = "Enabled",
	quikTellsRowDisabled = "Disabled",

	quikTellsTableDefaultVariables = {
		{"Enabled", "Hi", "Hello everyone!", "Say", "Raid"},
		{"Enabled", "Bye", "Goodbye all!", "Say", "Raid"},
		{"Enabled", "Thx", "Thank you!", "Say", "Raid"},
		{"Enabled", "LOL", "LOL!", "Say", "Raid"},
		{"Enabled", "Oops", "Oops sorry!", "Say", "Raid"},
		{"Enabled", "Grats", "Congrats!", "Say", "Raid"},
		{"Enabled", "Salute", "Props to you", "Say", "Emote Salute"},
		{"Enabled", "Pet", "Oh, so cute!", "Say", "Emote Pet"},
		{"Enabled", "Dance", "Dance Party!", "Say", "Emote Dance"},
		{"Enabled", "Pull", "Pulling in 10!", "Raid", "Pull In 10"},
		{"Disabled", "Inter", "Interupt the caster!", "Yell", "Raid"},
		{"Disabled", "Reload", "BRB in 1 min", "Raid", "Reload UI"},
		{"Disabled", "Scared", "Chickin!", "Say", "Emote Chicken"},
		{"Disabled", "Flirt", "How you doin'?", "Say", "Emote Flirt"},
		{"Disabled", "Cheer", "Yeah!!!!!", "Say", "Emote Cheer"}
	},

	hideShowButtonPanelWidth = 100,
	hideShowButtonPanelHeight = 30,
	hideShowButtonPanelBuffer = 3,
		
	tellButtonWidth = 50,
	tellButtonFrameHeight = 30,
	tellButtonHeight = 22,
	tellButtonXSpacing = 2,
	tellButtonYSpacing = 3,
		
	configXCoords = {20, 70, 130, 320, 445},
	configHeaderYCoord = -55,
	configFirstYCoord = -50, -- Note: first y coord will include configYCoordSpacing because arrays start at 1 in LUA
	configYCoordSpacing = -25,
	configButtonNameWidth = 50,
	configButtonTextWidth = 200,
	configCheckBoxSize = 20,
	configRowHeight = 20,
	configDropDownWidth = 100,
		
	channelOptions = {"Say", "Yell", "Party", "Raid", "Guild", "Emote", "Custom"},
	emoteOptions = {
		"Emote Cheer", "Emote Chicken", "Emote Dance", "Emote Flirt", "Emote Hi", 
		"Emote Pet", "Emote Salute", "Emote Sit", "Emote Sleep"
	},
	customOptions = {"Pull In 10", "Reload UI"}
}