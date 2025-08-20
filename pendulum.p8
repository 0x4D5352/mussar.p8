pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- constants
pi = 3.1415
gravity = 1
angle_v = 0
angle_a = 0
radius = 15
friction = 0.995

function rndcolor()
	-- to avoid choosing black
	return flr(rnd(15)) + 1
end

function _init()
	origin = {x=64, y=0}
	angle = pi / 4
	bob = {x=0,y=0}
	length = 100
	clr = rndcolor()
	party = false
end

function _update()
	force = gravity / radius * sin(angle)
	angle_a = (-1 * force) / length
	angle_v += angle_a
	angle_v *= friction
	angle += angle_v
	bob['x'] = length * sin(angle) + origin['x']
	bob['y'] = length * -cos(angle) + origin['y']
	if rnd() > 0.5 and party then
		clr = rndcolor()
	end
	if btnp(❎) and party == false then 
		party = true 
	else if btnp(❎) and party == true then 
		party = false 
	end
	end

	-- if btn('1') then
	-- 	angle_v *= 1.01
	-- 	angle += .01
	-- end
end

function _draw()
	cls()
	line(origin['x'],origin['y'],bob['x'],bob['y'],clr)
	circfill(bob['x'],bob['y'],radius,clr)
	line(0,127,127,127, 2)
	print("x: "..bob['x'], 7)
	print("y: "..bob['y'], 7)
	-- print(party,7)
	print('press ❎ to party!', 0, 120, 7)
	-- print('press ➡️ to push!', 0, 110, 7)
end


__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
