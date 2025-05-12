pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--globals
function _init()
	cls()
	c_c = 7
	b_c = 0
	last_t = t()
-- todo: replace w/ non-rnd()
	for y=0,127,1 do
		for x=0,127,1 do
			if rnd() >= 0.92 then
				pset(x,y,c_c)
			else
				pset(x,y,b_c)
			end
		end
	end
end

-- rules
function count_neighbors(x,y)
	local neighbors=0
	-- |-1,-1| 0,-1| 1,-1|
	-- |-1, 0| self| 1, 0|
	-- |-1, 1| 0, 1| 1, 1|
	for ny=-1,1,1 do
		for nx=-1,1,1 do
			if nx==0 and ny==0 then
				neighbors += 0
			else
				if pget(x+nx,y+ny) == c_c then
					neighbors+=1
				end
			end
		end
	end
	if pget(x,y)==b_c then
		-- i know this is inefficient
		if neighbors==3 then
			return true
		else
			return false
		end
	end
	if neighbors>1 and neighbors<4 then
		return true
	end
	-- under/over population
	return false
end

function _draw()
	--commented out 1sec intervals
	--now = t()
	--dt = now - last_t
	--if dt >= 1 then
	--	last_t = now
		for y=0,127,1 do
			for x=0,127,1 do
				if count_neighbors(x,y) then
					pset(x,y,c_c)
				else
					pset(x,y,b_c)
				end
			end
		end
	--end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
