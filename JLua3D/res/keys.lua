local keys = {}
local pressedKeys = {}
Keys = {}

KeyCodes = {}
KeyCodes.arrowKeys = {}
KeyCodes.arrowKeys.up = 38
KeyCodes.arrowKeys.right = 39
KeyCodes.arrowKeys.left = 37
KeyCodes.arrowKeys.down = 40

function SYS_KeyAction(updown, keyCode)
	if updown then
		Key_Down(keyCode)
	else
		Key_Up(keyCode)
	end
end

function Key_Down(keyCode)
	keys[keyCode] = true
end

function Key_Up(keyCode)
	keys[keyCode] = false
end

function Keys.isKeyDown(keyCode)
	if keys[keyCode] then
		return keys[keyCode]
	else
		return nil
	end
end