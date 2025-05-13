pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
function _init()
	x = 64
	y = 64
	r = 32
	white=7
	red=8
	green=11
	blue=12
	scalar = r * 0.125
	last = t()
	-- first address where i saw stuff happen
	mem_touched = 0x5f07
	mem_amount = 0x0
end

function _update()
	x_rotation = sin(t()) * scalar
	y_rotation = cos(t()) * scalar
	noise = (rnd(2) - 1) * scalar * 0.255
	local now = t()
	delta_time = now - last
	if delta_time > 1 then
		poke(mem_touched, mem_amount)
		mem_amount += 1
		last = now
	end
	if mem_amount >= 0xf then
		poke(mem_touched, 0)
		mem_touched += 1
		mem_amount = 0
	end
	if mem_touched >= 0x5f40 then
		mem_touched = 0x5f00
	end
end

function _draw()
	cls()
	local c_c = white
	local r_c = red
	local g_c = green
	local b_c = blue
	if rnd() >= 0.85 then 
		c_c = 0
		r_c += flr(rnd(16))
		g_c += flr(rnd(16))
		b_c += flr(rnd(16))
	end
	circfill(x+scalar+x_rotation+noise,y-scalar+y_rotation+noise,r,g_c)
	circfill(x-scalar+x_rotation+noise,y-scalar+y_rotation+noise,r,r_c)
	circfill(x+x_rotation+noise,y+scalar+y_rotation+noise,r,b_c)
	circfill(x+x_rotation,y+y_rotation,r+noise,c_c)
	print(mem_touched, white)
	print(mem_amount, white)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
