pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
-- klock
-- by manuel nila


-- creative programming
-- "ways of telling time"

frame = 1

offset_x = 46
offset_y = 24

angle = 0.0375
anglev = -0.00125

parts = {}

eye_states = {
	{0, false},
	{1, false},
	{1, true},
	{0, true},
	{0, true},
	{1, true},
	{1, false},
	{0, false}
}

function addline(x1,y1,x2,y2,col)
	add(parts,{
		x1=x1+offset_x,
		x2=x2+offset_x,
		y1=y1+offset_y,
		y2=y2+offset_y,
		c=col,
		draw=function(this)
			line(this.x1,this.y1,this.x2,this.y2,this.c)
		end
	})
end

function addcircle(x,y,rad,col)
	add(parts, {
		x=x+offset_x,
		y=y+offset_y,
		r=rad,
		c=col,
		draw=function (this)
			circfill(this.x,this.y,this.r,this.c)
		end
	})
end

function addsprite(sprn,x,y,hflip,vflip)
	add(parts, {
		n=sprn,
		x=x+offset_x,
		y=y+offset_y,
		h=hflip,
		v=vflip,
		draw=function(this)
			spr(this.n, this.x, this.y, 1, 1, this.h, this.v)
		end
	})
end

function cat()

		--body
	addcircle(16,36,13,0)
	addcircle(16,42,13,0)
	addcircle(16,48,13,0)
	addcircle(16,51,13,0)
	
		--head
	addcircle(16,15,13,0)
	
	--mouth
	addsprite(18,8,18)
	addsprite(18,16,18,true)
	addsprite(18,17,18,true)

	--paws	
	addsprite(17,0+1,0+26)
	addsprite(17,23+1,0+26,true)
	addsprite(17,0+1,31+26,false,true)
	addsprite(17,23+1,31+26,true,true)
	
	--bowtie
	addline(16,26,16,29,8)
	addsprite(2,8,24)
	addsprite(2,17,24,true,true)
	
	--ears
	addsprite(16,2,2,false,false)
	addsprite(16,2+21,2,true,false)	
end

function clock()
	
	local radius = 14.5
	local offsetx = 16
	local offsety = 46

	local hour = stat(0x5d)
	local minute = stat(0x5e)
	local second = stat(0x5f)
	
	if hour > 12 then hour = hour - 12 end
	
	local sect = ((second + 1) / 60) - 0.5
	local mint = ((minute + 1) / 60) - 0.5
 local hourt = (hour / 12)	- 0.5
	
	
	local secx = offsetx + ((radius - 1) * sin(sect))
	local secy = offsety + ((radius - 1) * cos(sect))

	local minx = offsetx + ((radius - 4) * sin(mint))
	local miny = offsety + ((radius - 4) * cos(mint))

	local hourx = offsetx + ((radius - 8) * sin(hourt))
	local houry = offsety + ((radius - 8) * cos(hourt))
	
	addcircle(offsetx,offsety,radius+2,0)
	addcircle(offsetx,offsety,radius,7)

	for i=1,12 do
		local x=offsetx + ((radius - 2) * sin(i/12))
		local y=1+offsety + ((radius - 2) * cos(i/12))
		addline(flr(x),flr(y),flr(x),flr(y),0)
	end

	addline(offsetx,offsety, flr(hourx), flr(houry),0) 
	addline(offsetx,offsety, flr(minx),flr(miny),0)
	addline(offsetx,offsety, flr(secx),flr(secy),8)
	
end

function eyes()
	addsprite(eye_states[1 + flr(frame / 15) % 8][1],8,8,eye_states[1 + flr(frame / 15)  % 8][2])
	addsprite(eye_states[1 + flr(frame / 15) % 8][1],17,8,eye_states[1 + flr(frame / 15) % 8][2])	
	frame=frame+1
end

function tail()
	
	if angle >= 0.0375 then anglev = -0.00125 end
	if angle <= -0.0375 then anglev = 0.00125 end
	
	angle = angle + anglev

	local offsetx = 16
	local offsety = 64
	
	for r=0,18,3 do 
		local x = offsetx + (r * cos(angle - 0.25))
		local y = offsety + (r * sin(angle - 0.25))
		addcircle(x, y, 3, 0)
	end
end

function _update60()
	parts = {}
	cat()
	eyes()
	clock()
	tail()
end

function _draw()
	palt(12)
	cls(12)
	foreach(parts,function (p)
		p:draw()
	end)
end
__gfx__
0070770000707700cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0700777007000770cee8cccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7700777777000777e88888ce00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7007777777000777e88888e800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70077777770007778888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77007777770007778888e8c800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0700777007000770c88ecccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070770000707700cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000cccccccc00ccccccccc700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0777000ccc00000c7777777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07777700c00007007700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07777700c0070070c777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c077700c000070ccc777770e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c07700cc00700ccccc77707e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c0000cccc007cccccccc777e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
cc00cccccc00cccccccccc7700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc0000ccccccc0000000ccccccc0000ccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc0777000c0000000000000c0007770ccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc07777700000000000000000777770ccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc07777700000000000000000777770ccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc077700000000000000000007770cccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc077000000000000000000000770cccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc000000077070000077070000000cccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccc0000077700700077700700000ccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccc0000777700770777700770000ccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccc0000777770070777770070000ccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc000007777700707777700700000cccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc000007777007707777007700000cccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc000000777007000777007000000cccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc000000077070000077070000000cccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc000000000000000000000000000cccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc000000000000000000000000000cccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc000000000000777000000000000cccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccc0000777777777777777770000ccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccc0000770000000000000770000ccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccc0000077777700077777700000ccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccc0000777770eee0777770000cccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccc000077707eee707770000ccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccc00000777eee77700000cccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccc0ee8007777700e880ccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccc00ce888880e8808e8888c00cccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc00000e88888e888888888800000cccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc0000708888888888e88888e070000ccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc0070078888e8088e088888e700700ccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccc0000700088e0000000008ee00070000cccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccc0070000000000000000000000000700cccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc00700000000777777700000000700ccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc000000077777777777770000000cccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc000000777777707777777000000cccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc000077777777777777777770000cccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc000777077777777777707777000cccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc007777777777777777777777700cccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc00077777777777777777777777000ccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc00777777777777777777770777700ccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccc0077077777777777777777077077700cccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccc0077777777777777777770777777700cccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccc0077777770777777777707777777700cccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccc007777777770077777700777777777700ccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccc007777777777707777077777777777700ccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccc007777777777770070777777777777700ccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccc007777777777777787777777777777700ccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccc007077777777777787777777777707700ccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccc007777777777777787777777777777700ccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccc007777777777777787777777777777700ccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccc0077777777777778777777777777700cccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccc0077777777777778777777777777700cccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccc0077777777777778777777777777700cccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc00707777777777877777777707700ccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc00077777777777877777777777000ccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc007777777777787777777777700cccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccc0077777777778777777777700ccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc000077077777787777707770000cccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc00700007777777877777770000700ccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccc0070000007777778777777000000700cccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccc0000700000007777777000000070000cccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc00700700000000000000000700700ccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc00007000000000000000000070000ccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc00000cc0000000000000cc00000cccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccc00cccccc0000000cccccc00cccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc00000000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc00000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

__sfx__
000100002835028350283502835025350253502535025350253502535025350253502535025350263502635026350123500f3500c35017350223502335024350213501e3501b3501635014350103500d35028350
