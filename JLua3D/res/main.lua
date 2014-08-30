require 'math'
require 'res/classes'

function Star_e(spread, speed)
	local self = Entity("star")
	self.spread = spread
	self.speed = speed
	self.x = 0
	self.y = 0
	self.z = 0
	self.r = 255
	self.g = 255
	self.b = math.random(200,255)
	self.rad = math.random(10,25)
	
	function self.a()
		if (255 / self.z) > 0 and (255 / self.z) < 256 then 
			return (255 / self.z) 
		elseif (255 / self.z) > 255 then 
			return 255 
		else 
			return 0 
		end
	end

	function self.reinit()
		self.y = (math.random() - 0.5) * self.spread
		self.x = (math.random() - 0.5) * self.spread
		self.z = (math.random() + 0.0001) * self.spread
		self.r = 255
		self.g = 255
		self.b = math.random(200, 255)
		self.rad = math.random(10,25)
	end

	function self.Render()
		local x = ((self.x/self.z) * (GR2D_WIDTH/2) + (GR2D_WIDTH/2))
		local y = ((self.y/self.z) * (GR2D_HEIGHT/2) + (GR2D_HEIGHT/2))
		if (x < 0 or x > GR2D_WIDTH) or (y < 0 or y > GR2D_HEIGHT) then
			self.reinit()
		else
			SRL.drawArc(x,y,self.rad/self.z,0,360,self.r, self.g, self.b, self.a())
		end	
	end

	function self.Update(delta)
		self.z = self.z - (self.speed * delta)
		if self.z < 0 then
			self.reinit()
		end
	end

	return self
end

function Planet_e(spread, speed)
	local self = Entity("planet")
	self.spread = spread
	self.speed = speed
	self.x = 0
	self.y = 0
	self.z = 0
	self.r = math.random(100,255)
	self.g = math.random(100,150)
	self.b = math.random(200,255)
	self.rad = math.random(10,75)

	function self.a()
		if (255 / self.z) > 0 and (255 / self.z) < 256 then 
			return (255 / self.z) 
		elseif (255 / self.z) > 255 then 
			return 255 
		else 
			return 0 
		end
	end

	function self.reinit()
		self.y = (math.random() - 0.5) * self.spread
		self.x = (math.random() - 0.5) * self.spread
		self.z = (math.random() + 0.0001) * self.spread
		self.r = math.random(100,150)
		self.g = math.random(100,150)
		self.b = math.random(200,255)
		self.rad = math.random(10,50)
	end

	function self.Render()
		local x = ((self.x/self.z) * (GR2D_WIDTH/2) + (GR2D_WIDTH/2))
		local y = ((self.y/self.z) * (GR2D_HEIGHT/2) + (GR2D_HEIGHT/2))
		if (x < 0 or x > GR2D_WIDTH) or (y < 0 or y > GR2D_HEIGHT) then
			self.reinit()
		else
			SRL.drawArc(x,y,self.rad/self.z,0,360,self.r, self.g, self.b, self.a())
		end	
	end

	function self.Update(delta)
		self.z = self.z - (self.speed * delta)
		if self.z < 0 then
			self.reinit()
		end
	end

	return self
end

function SunSystem(spread,entities,stpp,speed)
	local self = Entity("SunSystem")
	self.ees = {}

	local cnt = 0

	for i = 1,(entities/100*stpp) do
		self.ees[#self.ees + 1] = Planet_e(spread, speed)
		cnt = cnt + 1
	end

	for i = cnt, entities do
		self.ees[#self.ees + 1] = Star_e(spread, speed)
	end

	function self.Render()
		for i = 1, #self.ees do
			self.ees[i].Render()
		end
	end

	function self.Update(delta)
		for i = 1, #self.ees do
			self.ees[i].Update(delta)
		end
	end

	return self
end

--[[function StarField(stars, spread, speed)
	local self = {}
	self.stars = stars
	self.spread = spread
	self.speed = speed

	self.x = {}
	self.y = {}
	self.z = {}
	self.r = {}
	self.g = {}
	self.b = {}
	self.rad = {}

	for i = 1, stars do
		self.x[#self.x + 1] = 0
		self.y[#self.y + 1] = 0
		self.z[#self.z + 1] = 0
		self.r[#self.r + 1] = 0
		self.g[#self.g + 1] = 0
		self.b[#self.b + 1] = 0
		self.rad[#self.rad + 1] = 0
	end

	function self.initStar(i)
		self.y[i] = (math.random() - 0.5) * self.spread
		self.x[i] = (math.random() - 0.5) * self.spread
		self.z[i] = (math.random() + 0.0001) * self.spread
		self.r[i] = math.random(0, 255)
		self.g[i] = math.random(0, 255)
		self.b[i] = math.random(0, 255)
		self.rad[i] = math.random(25,100)
	end

	for i = 1, stars do
		self.initStar(i)
	end

	function self.update(delta)
		for i = 1, self.stars do
			local x = self.x[i]
			local y = self.y[i]
			local z = self.z[i]
			self.z[i] = self.z[i] - (self.speed * delta)
			if z < 0 then
				self.initStar(i)
			end
		end
	end

	function self.render()
		for i = 1, self.stars do
			local x = ((self.x[i]/self.z[i]) * (GR2D_WIDTH/2) + (GR2D_WIDTH/2))
			local y = ((self.y[i]/self.z[i]) * (GR2D_HEIGHT/2) + (GR2D_HEIGHT/2))
			if (x < 0 or x > GR2D_WIDTH) or (y < 0 or y > GR2D_HEIGHT) then
				self.initStar(i)
			else
				--SRL.drawRect(x,y,x+1,y+1,self.r[i],self.g[i],self.b[i], 255)
				local a = 0
				if (255/self.z[i]) > 0 and (255/self.z[i]) < 256 then
					a = (255 / self.z[i])
				elseif (255/self.z[i]) > 255 then
					a = 255
				end
				SRL.setPixel(x,y,self.r[i],self.g[i],self.b[i],a)
				--SRL.drawArc(x,y,(self.rad[i]/self.z[i]),0,360,self.r[i],self.g[i],self.b[i],255)
				--SRL.drawArc(x,y,100,0,360,self.r[i],self.g[i],self.b[i],0)
				--SetPixel(x,y,255,255,255)
				--SetPixel(x,y,math.random(0, 255),math.random(0, 255),math.random(0, 255))
			end
		end
	end

	return self
end]]

--local scene = StarField(1024, 20, 4)

local scene = SunSystem(20,1024,10,4)

function SRL.Update(delta)
	SRL.checkFps()
	scene.Update(delta)
end

function SRL.Render()
	SRL.clearScreen(0,0,0)
	scene.Render()
	SRL.placeText(10, 50, "FPS: " .. SRL.getCurrentFPS(), 40, 255, 255, 255, 255)
end