-- Native SRL lib
-- SRL -> SoftwareRenderingLibrary	
SRL = {}
local keys = {}
local pressedKeys = {}

-- FPS counter stuff

local init = false
local startT = 0
local lastTime = 0

local fps = 0
local sCnt = 0.0

function Key_Down(keyCode)
	keys[keyCode] = true
end

function Key_Up(keyCode)
	keys[keyCode] = false
end

function Key_Pressed(keyCode)
	pressedKeys[keyCode] = true
end

function SRL.placeText(x,y,text,textSize,r,g,b,a)
	GR2D_setRGB(r,g,b)
	GR2D_setAlpha(a)
	GR2D_setXY(x,y)
	GR2D_placeText(text, textSize)
end

function SRL.drawRect(x,y,w,h,r,g,b,a)
	GR2D_setRGB(r,g,b)
	GR2D_setAlpha(a)
	GR2D_setXY(x,y)
	GR2D_drawRect(w,h)
end

function SRL.setPixel(x,y,r,g,b,a)
	SRL.drawRect(x,y,1,1,0,255,0,a)
end

function SRL.drawArc(x,y,rad,aS,aE,r,g,b,a)
	GR2D_setRGB(r,g,b)
	GR2D_setAlpha(a)
	GR2D_setXY(x,y)
	GR2D_drawArc(rad,aS,aE)
end

function SRL.drawLine(x1,y1,x2,y2,r,g,b,a)
	GR2D_setRGB(r,g,b)
	GR2D_setAlpha(a)
	GR2D_setXY(x,y)
	GR2D_drawLine(x2,y2)
end

function SRL.clearScreen(r,g,b)
	GR2D_clearAll(r,g,b)
end

function SRL.isKeyDown(keyCode)
	return keys[keyCode]
end

function SRL.checkFps()
	sCnt = sCnt + 1
	if not init then
		startT = SYS_GETMILLITIME()
		init = true
	else
		lastTime = SYS_GETMILLITIME()
		if (lastTime - startT) > 1000 then
			fps = sCnt
			sCnt = 0
			startT = lastTime
		end
	end
end

function SRL.getCurrentFPS()
	return fps
end

function SRL.Render()
	sleep(1)
end

function SRL.Update(delta)

end

function SRL.getDelta()
	return SYS_getDelta()
end

function SRL.exit()
	SRL.running = false
end

function SYS_execute()
	SRL.Update(SRL.getDelta())
	SRL.Render()
end