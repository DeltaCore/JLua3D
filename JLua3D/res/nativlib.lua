local clock = os.clock
function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end

SRL = {}

-- Native SRL lib
-- SRL -> SoftwareRenderingLibrary	

require 'res/keys'

-- FPS counter stuff

local init = false
local startT = 0
local lastTime = 0

local fps = 0
local sCnt = 0.0

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

function SRL.capFps(cFps)
	if cFps < fps then
		--sleep(0.1)
		sleep((1 / fps)/2)
	end
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

function print_r(tbl, tabIndex)
	local tback = tabIndex
	if tabIndex == nil then
		tback = 0
	end
	local tab = ""
	for i = 0, tback do
		tab = tab .. "  "
	end
	if type(tbl) == "table" then
		for index, value in pairs(tbl) do
			if type(value) == "table" then
				local str = '"' .. index .. '" => '
				print(tab .. str .. "[")
				tabIndex = tonumber(tback)
				local b = ""
				for i = 1, string.len(str)  do
					b = b .. " "
				end
				print_r(value, tabIndex+(string.len(str) / 2))
				tback = tback - 2
				print(tab .. b .. "[")
			else
				print(tab .. '"' .. index .. '" => "', value ,'"')
			end
		end
	else
		print(tab .. "[" .. tbl .. "]")
	end	
end

function SYS_execute()
	SRL.Update(SRL.getDelta())
	SRL.Render()
end