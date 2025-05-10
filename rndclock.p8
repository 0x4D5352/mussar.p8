pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
function rndcolor()
	 return flr(rnd(16))
end

function _init()
	current = flr(rnd(16))
	bg = 0
	r = 50
end

function _update()

	-- second hand
	second = {
		x = 64 + -sin(stat(95)/60) * r,
		y = 64 + -cos(stat(95)/60) * r
	}

	-- minute hand
	minute = {
		x = 64 + -sin(stat(94)/60) * r/1.15,
		y = 64 + -cos(stat(94)/60) * r/1.15
	}

	-- hour hand
	hour = {
	x = 64 + -sin(stat(93)/12) * r/2,
	y = 64 + -cos(stat(93)/12) * r/2
}


	
	if sin(t()) > -0.75 then
		time_delimiter = ":"
	else
		time_delimiter = " "
	end

	if stat(93) < 10 then
		hr = "0"..stat(93)
	else
		hr = stat(93)
	end

	if stat(94) < 10 then
		min = "0"..stat(94)
	else
		min = stat(94)
	end

	if stat(95) < 10 then
		sec = "0"..stat(95)
	else
		sec = stat(95)
	end

	time = hr..time_delimiter..min..time_delimiter..sec

	yr = stat(90)

	if stat(91) < 10 then
		mnth = "0"..stat(91)
	else
		mnth = stat(91)
	end

	if stat(92) < 10 then
		day = "0"..stat(92)
	else
		day = stat(92)
	end
	if sin(t()) > -0.75 then
		date_delimiter = ":"
	else
		date_delimiter = " "
	end
	
	date_delimiter = "/"
	today = yr..date_delimiter..mnth..date_delimiter..day
end


function _draw()
	if rnd() > 0.98 then
		current = rndcolor()
	end
 local lcolor = current + 4

	cls()
	circfill(64, 64, r, current)
	if current == 0 then
		circ(64,64,r,lcolor + 1)
	end

	line(64,64, second['x'], second['y'], lcolor + 2)

	print("12", 61, 15, lcolor)
	print("3", 111, 62, lcolor)
	print("6", 63, 109, lcolor)
	print("9", 15, 62, lcolor)


	line(64, 64, minute['x'], minute['y'], lcolor)

	line(64, 64, hour['x'], hour['y'], lcolor)


	print("hey look a clock",32,0, 7)
	print(time,0,120,7)
	print(today,86,120,7)
	
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
