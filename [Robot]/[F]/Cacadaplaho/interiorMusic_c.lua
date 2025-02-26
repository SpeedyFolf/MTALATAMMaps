addEventHandler("onClientResourceStart", getRootElement(), function()
	setInteriorSoundsEnabled(false)
	outputChatBox("Press M to turn casino music ON/OFF")
end )

addEventHandler("onClientResourceStop", getRootElement(), function()
	setInteriorSoundsEnabled(true)
end )

function toggleSong()
	setInteriorSoundsEnabled(not getInteriorSoundsEnabled())
end
addCommandHandler("togglemusic",toggleSong)
bindKey("m","down","togglemusic")
