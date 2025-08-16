pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

function _init()
	poke(0x5f2d,0x1)
	bg=0
	txt=6
	b = {ul={x=63,y=63},br={x=65,y=65},c=3}
	state = mstate()
	count=0
	cooldown=false
	last = t()
	refreshrate = 2
	debug = false
	shopopen = false
	clickprice = 1
end

function mstate()
	return {
		x=stat(32),
		y=stat(33),
		b=stat(34),
		h=stat(35),
		v=stat(36),
		}
end

function rndcolor()
	 return flr(rnd(16))
end

function withinbutton()
	local after_ul = state.x >= b.ul.x and state.y >= b.ul.y
	local before_br = state.x <= b.br.x and state.y <= b.br.y
	return after_ul and before_br
end

function keypressed()
	return state.b > 0
end

function drawbutton()
	local c = b.c
	if withinbutton() then
		c = 32 - bg + c
		if keypressed() then
			c = c + 7
		end
	end
	rectfill(
		b.ul.x,
		b.ul.y,
		b.br.x,
		b.br.y,
		c
	)
end

function drawmouse()
	pset(state.x,state.y,txt+7)
end

function debugmouse()
	print("mx: "..state.x,0,100,txt)
	print("my: "..state.y,txt)
	print("mb: "..state.b,txt)
	print("mh: "..state.h,txt)
	print("mv: "..state.v,txt)
end

function showstats()
	print("clicks: "..count,txt)
	if count > 0 then
		if not cooldown then 
			print("click: ready!")
		else
			print("click: wait...")
		end
		print("cooldown: "..refreshrate)
	end
end

function refreshcooldown()
	local now = t()
	if now - last >= refreshrate then
		cooldown = false
		last = t()
	end
end

function showshop()
	-- todo: find a better way to calculate offset
	print("autoclick: "..clickprice, 127-(11*5)-((clickprice*3)/10),0,txt)
end

function _update()
	state = mstate()
	if withinbutton() and keypressed() then
		if not cooldown then
			count += 1
			cooldown = true
		end
	end
	if count > 9 and not shopopen then
		shopopen = true
	end
	refreshcooldown()
end

function _draw()
	cls(bg)
	if debug then
		debugmouse()
	end
	showstats()
	if shopopen then
		showshop()
	end
	drawbutton()
	drawmouse()
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
