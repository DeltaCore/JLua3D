require 'math'

function Class(name)
	local c = {}
	c.className = name
	return c
end

function Entity(entityType)
	local self = Class("Entity")
	self.entityType = entityType

	function self.Render()

	end

	function self.Update(delta)

	end

	return self
end