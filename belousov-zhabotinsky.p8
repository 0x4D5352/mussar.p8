pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
	-- rules
	-- 1. a cell exists in n states
	-- at n, a cell becomes healthy
	-- if cell >0 & <n, cell =
		-- avg(neighbor) + g
		-- where g is a constant for
		-- the infection rate
	-- if a cell is healthy, it
		-- becomes the average of
		-- the number of infected
		-- neighbors
			-- e.g if cell a is healthy,
			-- neighbor 1 is at 10,
			-- neighbor 2 is at 5,
			-- neighbor 3 is at 60,
			-- and neighbor 4 is at 30,
			-- a = (10 + 5 + 60 + 30) / 4
			-- aka a = 26
			-- or is it just count(nbr)?
function _init()
	n = 15
	healthy = 0
	g = 1
			cls(healthy)
end

function average_neighbors(x,y)
	local neighbors=0
	-- |-1,-1| 0,-1| 1,-1|
	-- |-1, 0| self| 1, 0|
	-- |-1, 1| 0, 1| 1, 1|
	for ny=-1,1,1 do
		for nx=-1,1,1 do
			if nx==0 and ny==0 then
				neighbors += 0
			else
				neighbors += pget(nx,ny)
			end
		end
	end
	return neighbors / 8
end

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
				if pget(nx,ny) != healthy then
				neighbors += 1
				end
			end
		end
	end
	return neighbors / 8
end


-- todo: double check this algorithm
function _draw()
	for y=0,127,1 do
		for x=0,127,1 do
			if pget(x,y) == n then
				pset(x,y,healthy)
			elseif pget(x,y) == healthy then
				pset(x,y,count_neighbors(x,y))
			else
				local health = pget(x,y)
				pset(x,y,average_neighbors(x,y) + health + g)
			end
		end
	end
end


__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
