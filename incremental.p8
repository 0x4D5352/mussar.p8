pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- pico8 functions
function _init()
	bg=0
	txt=6
	--main button
	mb = {
		ul = {
			x=64,
			y=64
		}, br = {
			x=64,
			y=64
		}, c = bg + 3
	}
	-- shop
	s = {
		ul = {
			x = 2,
			y = 124
		},br = {
			x = 4,
			y = 126
		}, c = bg + 4
	}
 -- z button - size
	z = {
		ul = {
			x = 11,
			y = 124
		}, br = {
			x = 13,
			y = 126
		}, c = bg + 5
	}
	-- d button - cooldown!
	d = {
		ul = {
			x = 20,
			y = 124
		},br = {
			x = 22,
			y = 126
		},c = bg + 6
	}
	clix=0
	cooldown=false
	last = t()
	refreshrate = 6
	debug = false
	shopopen = false
	sizeopen = false
	refreshopen = false
	ac = {n=0,c=128}
	bs = {n=1,c=256}
	rr = {n=1,c=512}
end

function _update()
	addclix()
	checkshop()
	refreshcooldown()
	autoclick()
	buttonsizer()
	refreshtimer()
end

function _draw()
	cls(bg)
	drawclix()
	drawbuttons()
	showstats()
	-- todo: fix the scaling
	print("❎",61,58-bs.n^0.33,txt)
	if (shopopen) print("🅾️",0,118,txt)
	if ac.n > 0 then
		print(ac.n,2,111,txt)
	end
	if sizeopen then
		print("⬆️",9,118,txt)
		print(bs.n^2,11,111,txt)
	end
	if refreshopen then
		print("⬇️",18,118,txt)
		print(refreshrate/rr.n,20,111,txt)
	end
	if false then
	print("⬅️",27,118,txt)
	print("➡️",36,118,txt)
	end
end
-->8
-- system functions
function keypressed()
	local ct_x = tonum(btnp(❎)) * 2
	local ct_y = tonum(btnp(🅾️)) * 4
	local ct_u = tonum(btnp(⬆️)) * 8
 local ct_d = tonum(btnp(⬇️)) * 16
	return 0|ct_x|ct_y|ct_u|ct_d
end

function addclix()
	if (keypressed() < 1) return
	if (keypressed() > 3) return
	if	(keypressed() == 2) clix += 1
	if clix > 127 and not shopopen then
		shopopen = true
	end
end

function checkshop() 
	if (keypressed() < 1) return
	if (clix < ac.c) return
	if (ac.n >= bs.n^2) return
	if keypressed() == 4 then
		clix -= ac.c
		ac.n += 1
		ac.c = flr(ac.c * 1.25)
	end
end

function buttonsizer()
	if clix > bs.c and not sizeopen then
		sizeopen = true
	end
	if (keypressed() < 1) return
	if (clix < bs.c) return
	if keypressed() == 8 then
		clix -= bs.c
		bs.n *= 2
		bs.c *= 2
		resizemainbutton()
	end
end

function refreshtimer()
	if clix > rr.c and not refreshopen then
		refreshopen = true
	end
	if (keypressed() < 1) return
	if (clix < rr.c) return
	if keypressed() == 16 then
		clix -= rr.c
		rr.n += 0.1
		rr.c = flr(rr.c * 1.5)
	end
end

function autoclick()
	if (ac.n < 1) return 
	if (cooldown) return
	clix += 1 * ac.n
	cooldown = true
end

function refreshcooldown()
	local now = t()
	if now - last >= refreshrate / rr.n then
		cooldown = false
		last = t()
	end
end
-->8
-- draw functions
function drawbuttons()
	drawmainbutton()
	if (shopopen) drawacbutton()
	if (sizeopen) drawbsbutton()
	if (refreshopen) drawrrbutton()
end


function drawrrbutton()
	local c = d.c
	if keypressed() == 16 then
		if clix < bs.c then
			c = c + 7
		else
			c = c + 9
		end
	end
	rectfill(
		d.ul.x,
		d.ul.y,
		d.br.x,
		d.br.y,
		c
	)
end


function drawbsbutton()
	local c = z.c
	if keypressed() == 8 then
		if clix < bs.c then
			c = c + 7
		else
			c = c + 9
		end
	end
	rectfill(
		z.ul.x,
		z.ul.y,
		z.br.x,
		z.br.y,
		c
	)
end


function drawacbutton()
	local c = s.c
	if keypressed() == 4 then
		if clix < ac.c then
			c = c + 7
		else
			c = c + 8
		end
	end
	rectfill(
		s.ul.x,
		s.ul.y,
		s.br.x,
		s.br.y,
		c
	)
end


function drawmainbutton()
	local c = mb.c
	if keypressed() == 2 then
		c = c + 7
	end
	rectfill(
		mb.ul.x,
		mb.ul.y,
		mb.br.x,
		mb.br.y,
		c
	)
end

function resizemainbutton()
	mb.ul.x -= 1
	mb.ul.y -= 1
	mb.br.x += 1
	mb.br.y += 1
end

function drawclix()
	if (clix < 1) return
	local cols = clix % 128
	local rows = (clix \ 128) % 128
	local limit = 128*128
	fc = 1 + clix\limit
	if rows > 0 then
		rectfill(0,0,127,rows-1,bg+fc)
	end
	line(0,rows,cols,rows,bg+fc)
end

function rndcolor()
	 return flr(rnd(16))
end
-->8
-- hud functions
function showstats()
	if (not debug) return
	print("keypressed(): "..keypressed(),txt)
	print("clicks: "..clix,txt)
	print("ac count: "..ac.n, txt)
	print("ac cost: "..ac.c, txt)
	print("button size: "..bs.n^2, txt)
	print("button cost: "..bs.c,txt)
	print("cooldown: "..refreshrate-flr(t()%6).." sec",txt)
	print("cooldown cost: "..rr.c,txt)
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
