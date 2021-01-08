##0 "hspdef.as"






















































































































##0 "main.hsp"
##0 "hspda.as"



#uselib "hspda.dll"
#func sortval sortval $83
#func sortstr sortstr $202
#func sortnote sortnote $202
#func sortget sortget $83
#func sortbye sortbye $100

#func csvstr csvstr $202
#func csvnote csvnote $87

#func xnotesel xnotesel $83
#func xnoteadd xnoteadd 6

#func rndf_ini rndf_ini $202
#func rndf_get rndf_get $202
#func rndf_geti rndf_geti $202

#func csvsel csvsel 1
#func csvres csvres $83
#func csvflag csvflag 0
#func csvopt csvopt 0
#func csvfind csvfind 6







##1 "hsptmp"
##0 "d3m.hsp"








goto@hsp *_d3m_exit









#deffunc d3rotate var v01@d3m,var v02@d3m,double v03@d3m,double v04@d3m,double v05@d3m

v01@d3m = v03@d3m * cos@hsp(v05@d3m) - v04@d3m * sin@hsp(v05@d3m)
v02@d3m = v03@d3m * sin@hsp(v05@d3m) + v04@d3m * cos@hsp(v05@d3m)

return@hsp















#deffunc d3setcamx double ssx@d3m,double ssy@d3m,double ssz@d3m,double ppx@d3m,double ppy@d3m,double ppz@d3m


cpx@d3m = ssx@d3m
cpy@d3m = ssy@d3m
cpz@d3m = ssz@d3m


ax@d3m = cpx@d3m - ppx@d3m
ay@d3m = cpy@d3m - ppy@d3m
az@d3m = cpz@d3m - ppz@d3m

bx@d3m = sqrt@hsp((ax@d3m) * (ax@d3m) + ( ay@d3m) * ( ay@d3m) + (0) * (0)) 
by@d3m = sqrt@hsp((ax@d3m) * (ax@d3m) + ( ay@d3m) * ( ay@d3m) + ( az@d3m) * ( az@d3m)) 

if@hsp bx@d3m ! 0.0 {
cosxy@d3m = ay@d3m / bx@d3m
sinxy@d3m = ax@d3m / bx@d3m
}
if@hsp by@d3m ! 0.0 {
cosaz@d3m = -bx@d3m / by@d3m
sinaz@d3m = az@d3m / by@d3m
}


wincx@d3m = 0.0 +  ginfo@hsp(12) / 2
wincy@d3m = 0.0 +  ginfo@hsp(13) / 2
zoom@d3m  = 0.1 +  ginfo@hsp(13)


mref@hsp df@d3m, 64

return@hsp











































#deffunc d3transx double v01@d3m,double v02@d3m,double v03@d3m

vx@d3m=( v01@d3m)-cpx@d3m : vy@d3m=( v02@d3m)-cpy@d3m : vz@d3m=( v03@d3m)-cpz@d3m : 	dy@d3m = vx@d3m * sinxy@d3m + vy@d3m * cosxy@d3m : 	dz@d3m = (dy@d3m * cosaz@d3m - vz@d3m * sinaz@d3m) / zoom@d3m : 	df@d3m = (dz@d3m > 0.05) : 	if@hsp df@d3m { 		dx@d3m = wincx@d3m + (vy@d3m * sinxy@d3m - vx@d3m * cosxy@d3m) / dz@d3m : 		dy@d3m = wincy@d3m + (dy@d3m * sinaz@d3m + vz@d3m * cosaz@d3m) / dz@d3m 	}

return@hsp



























#deffunc d3line double ppx@d3m,double ppy@d3m,double ppz@d3m,double ssx@d3m,double ssy@d3m,double ssz@d3m

vx@d3m=( ppx@d3m)-cpx@d3m : vy@d3m=( ppy@d3m)-cpy@d3m : vz@d3m=( ppz@d3m)-cpz@d3m : 	 dy@d3m = vx@d3m * sinxy@d3m + vy@d3m * cosxy@d3m : 	 dz@d3m = ( dy@d3m * cosaz@d3m - vz@d3m * sinaz@d3m) / zoom@d3m : 	 df@d3m = ( dz@d3m > 0.05) : 	if@hsp  df@d3m { 		  dx@d3m = wincx@d3m + (vy@d3m * sinxy@d3m - vx@d3m * cosxy@d3m) /  dz@d3m : 		 dy@d3m = wincy@d3m + ( dy@d3m * sinaz@d3m + vz@d3m * cosaz@d3m) /  dz@d3m 	}
vx@d3m=( ssx@d3m)-cpx@d3m : vy@d3m=( ssy@d3m)-cpy@d3m : vz@d3m=( ssz@d3m)-cpz@d3m : 	 ey@d3m = vx@d3m * sinxy@d3m + vy@d3m * cosxy@d3m : 	 ez@d3m = ( ey@d3m * cosaz@d3m - vz@d3m * sinaz@d3m) / zoom@d3m : 	 ef@d3m = ( ez@d3m > 0.05) : 	if@hsp  ef@d3m { 		  ex@d3m = wincx@d3m + (vy@d3m * sinxy@d3m - vx@d3m * cosxy@d3m) /  ez@d3m : 		 ey@d3m = wincy@d3m + ( ey@d3m * sinaz@d3m + vz@d3m * cosaz@d3m) /  ez@d3m 	}


if@hsp df@d3m & ef@d3m {
line@hsp dx@d3m, dy@d3m, ex@d3m, ey@d3m
return@hsp
}


if@hsp df@d3m | ef@d3m {
if@hsp df@d3m {
pos@hsp dx@d3m, dy@d3m
ax@d3m = ppx@d3m : ay@d3m = ppy@d3m : az@d3m = ppz@d3m
bx@d3m = ssx@d3m : by@d3m = ssy@d3m : bz@d3m = ssz@d3m
} else@hsp {
pos@hsp ex@d3m, ey@d3m
ax@d3m = ssx@d3m : ay@d3m = ssy@d3m : az@d3m = ssz@d3m
bx@d3m = ppx@d3m : by@d3m = ppy@d3m : bz@d3m = ppz@d3m
}
repeat@hsp 10
cx@d3m = (ax@d3m + bx@d3m) / 2
cy@d3m = (ay@d3m + by@d3m) / 2
cz@d3m = (az@d3m + bz@d3m) / 2
vx@d3m=( cx@d3m)-cpx@d3m : vy@d3m=( cy@d3m)-cpy@d3m : vz@d3m=( cz@d3m)-cpz@d3m : 	 ey@d3m = vx@d3m * sinxy@d3m + vy@d3m * cosxy@d3m : 	 ez@d3m = ( ey@d3m * cosaz@d3m - vz@d3m * sinaz@d3m) / zoom@d3m : 	 af@d3m = ( ez@d3m > 0.05) : 	if@hsp  af@d3m { 		  ex@d3m = wincx@d3m + (vy@d3m * sinxy@d3m - vx@d3m * cosxy@d3m) /  ez@d3m : 		 ey@d3m = wincy@d3m + ( ey@d3m * sinaz@d3m + vz@d3m * cosaz@d3m) /  ez@d3m 	}
if@hsp af@d3m {
ax@d3m = cx@d3m : ay@d3m = cy@d3m : az@d3m = cz@d3m
line@hsp ex@d3m, ey@d3m
} else@hsp {
bx@d3m = cx@d3m : by@d3m = cy@d3m : bz@d3m = cz@d3m
}
loop@hsp
}

return@hsp




#deffunc d3arrow double v11@d3m,double v12@d3m,double v13@d3m,double v14@d3m,double v15@d3m,double v16@d3m

d3line v11@d3m, v12@d3m, v13@d3m,  v14@d3m, v15@d3m, v16@d3m

if@hsp df@d3m & ef@d3m {

vx@d3m=( (v11@d3m * 9 + v14@d3m) / 10)-cpx@d3m : vy@d3m=( (v12@d3m * 9 + v15@d3m) / 10)-cpy@d3m : vz@d3m=( (v13@d3m * 9 + v16@d3m) / 10)-cpz@d3m : 	 ay@d3m = vx@d3m * sinxy@d3m + vy@d3m * cosxy@d3m : 	 az@d3m = ( ay@d3m * cosaz@d3m - vz@d3m * sinaz@d3m) / zoom@d3m : 	 af@d3m = ( az@d3m > 0.05) : 	if@hsp  af@d3m { 		  ax@d3m = wincx@d3m + (vy@d3m * sinxy@d3m - vx@d3m * cosxy@d3m) /  az@d3m : 		 ay@d3m = wincy@d3m + ( ay@d3m * sinaz@d3m + vz@d3m * cosaz@d3m) /  az@d3m 	}


a@d3m = atan@hsp(dy@d3m-ey@d3m, dx@d3m-ex@d3m)
r@d3m = sqrt@hsp((v11@d3m-v14@d3m) * (v11@d3m-v14@d3m) + ( v12@d3m-v15@d3m) * ( v12@d3m-v15@d3m) + ( v13@d3m-v16@d3m) * ( v13@d3m-v16@d3m))  / az@d3m / 30
bx@d3m = cos@hsp(a@d3m) * r@d3m
by@d3m = sin@hsp(a@d3m) * r@d3m


line@hsp dx@d3m, dy@d3m,  ax@d3m - by@d3m, ay@d3m + bx@d3m
line@hsp dx@d3m, dy@d3m,  ax@d3m + by@d3m, ay@d3m - bx@d3m
}

return@hsp




#deffunc d3box double v11@d3m,double v12@d3m,double v13@d3m,double v14@d3m,double v15@d3m,double v16@d3m

d3line v11@d3m, v12@d3m, v13@d3m,  v14@d3m, v12@d3m, v13@d3m
d3line v11@d3m, v15@d3m, v13@d3m,  v14@d3m, v15@d3m, v13@d3m
d3line v11@d3m, v15@d3m, v16@d3m,  v14@d3m, v15@d3m, v16@d3m
d3line v11@d3m, v12@d3m, v13@d3m,  v11@d3m, v12@d3m, v16@d3m
d3line v11@d3m, v15@d3m, v13@d3m,  v11@d3m, v12@d3m, v13@d3m
d3line v11@d3m, v15@d3m, v16@d3m,  v11@d3m, v15@d3m, v13@d3m
d3line v11@d3m, v12@d3m, v16@d3m,  v11@d3m, v15@d3m, v16@d3m
d3line v14@d3m, v12@d3m, v16@d3m,  v11@d3m, v12@d3m, v16@d3m
d3line v14@d3m, v15@d3m, v13@d3m,  v14@d3m, v15@d3m, v16@d3m
d3line v14@d3m, v12@d3m, v13@d3m,  v14@d3m, v15@d3m, v13@d3m
d3line v14@d3m, v12@d3m, v16@d3m,  v14@d3m, v12@d3m, v13@d3m
d3line v14@d3m, v15@d3m, v16@d3m,  v14@d3m, v12@d3m, v16@d3m

return@hsp




#deffunc d3circle double v01@d3m,double v02@d3m,double v03@d3m,double v04@d3m,int v05@d3m

vx@d3m=( v01@d3m)-cpx@d3m : vy@d3m=( v02@d3m)-cpy@d3m : vz@d3m=( v03@d3m)-cpz@d3m : 	dy@d3m = vx@d3m * sinxy@d3m + vy@d3m * cosxy@d3m : 	dz@d3m = (dy@d3m * cosaz@d3m - vz@d3m * sinaz@d3m) / zoom@d3m : 	df@d3m = (dz@d3m > 0.05) : 	if@hsp df@d3m { 		dx@d3m = wincx@d3m + (vy@d3m * sinxy@d3m - vx@d3m * cosxy@d3m) / dz@d3m : 		dy@d3m = wincy@d3m + (dy@d3m * sinaz@d3m + vz@d3m * cosaz@d3m) / dz@d3m 	}

if@hsp df@d3m {
r@d3m = v04@d3m / dz@d3m
circle@hsp dx@d3m - r@d3m, dy@d3m - r@d3m, dx@d3m + r@d3m, dy@d3m + r@d3m, v05@d3m
}
return@hsp




#deffunc d3mes str pmsg@d3m,double ppx@d3m,double ppy@d3m,double ppz@d3m

vx@d3m=( ppx@d3m)-cpx@d3m : vy@d3m=( ppy@d3m)-cpy@d3m : vz@d3m=( ppz@d3m)-cpz@d3m : 	dy@d3m = vx@d3m * sinxy@d3m + vy@d3m * cosxy@d3m : 	dz@d3m = (dy@d3m * cosaz@d3m - vz@d3m * sinaz@d3m) / zoom@d3m : 	df@d3m = (dz@d3m > 0.05) : 	if@hsp df@d3m { 		dx@d3m = wincx@d3m + (vy@d3m * sinxy@d3m - vx@d3m * cosxy@d3m) / dz@d3m : 		dy@d3m = wincy@d3m + (dy@d3m * sinaz@d3m + vz@d3m * cosaz@d3m) / dz@d3m 	}

if@hsp df@d3m {
pos@hsp 0, -32000
mes@hsp pmsg@d3m
pos@hsp dx@d3m -  ginfo@hsp(14) / 2, dy@d3m -  ginfo@hsp(15) / 2
mes@hsp pmsg@d3m
}
return@hsp









#deffunc d3lineto double ppx@d3m,double ppy@d3m,double ppz@d3m

ex@d3m = dx@d3m
ey@d3m = dy@d3m
ef@d3m = df@d3m

vx@d3m=( ppx@d3m)-cpx@d3m : vy@d3m=( ppy@d3m)-cpy@d3m : vz@d3m=( ppz@d3m)-cpz@d3m : 	dy@d3m = vx@d3m * sinxy@d3m + vy@d3m * cosxy@d3m : 	dz@d3m = (dy@d3m * cosaz@d3m - vz@d3m * sinaz@d3m) / zoom@d3m : 	df@d3m = (dz@d3m > 0.05) : 	if@hsp df@d3m { 		dx@d3m = wincx@d3m + (vy@d3m * sinxy@d3m - vx@d3m * cosxy@d3m) / dz@d3m : 		dy@d3m = wincy@d3m + (dy@d3m * sinaz@d3m + vz@d3m * cosaz@d3m) / dz@d3m 	}

if@hsp df@d3m & ef@d3m {
line@hsp dx@d3m, dy@d3m, ex@d3m, ey@d3m
}
return@hsp



















#deffunc d3particle int ppi@d3m,double ppx@d3m,double ppy@d3m,double ppz@d3m,double ppr@d3m

vx@d3m=( ppx@d3m)-cpx@d3m : vy@d3m=( ppy@d3m)-cpy@d3m : vz@d3m=( ppz@d3m)-cpz@d3m : 	dy@d3m = vx@d3m * sinxy@d3m + vy@d3m * cosxy@d3m : 	dz@d3m = (dy@d3m * cosaz@d3m - vz@d3m * sinaz@d3m) / zoom@d3m : 	df@d3m = (dz@d3m > 0.05) : 	if@hsp df@d3m { 		dx@d3m = wincx@d3m + (vy@d3m * sinxy@d3m - vx@d3m * cosxy@d3m) / dz@d3m : 		dy@d3m = wincy@d3m + (dy@d3m * sinaz@d3m + vz@d3m * cosaz@d3m) / dz@d3m 	}

if@hsp df@d3m {
r@d3m = int@hsp(ppr@d3m / dz@d3m)
if@hsp (r@d3m > 0) & (abs@hsp(dx@d3m) < 10000) & (abs@hsp(dy@d3m) < 10000) {
y@d3m = ppi@d3m * 112

if@hsp r@d3m <= 10 {


pos@hsp dx@d3m - r@d3m, dy@d3m - r@d3m
gcopy@hsp 29,  112, (r@d3m-1)*r@d3m + y@d3m, r@d3m*2, r@d3m*2

} else@hsp {


pdx@d3m = -r@d3m + dx@d3m,  r@d3m + dx@d3m,  r@d3m + dx@d3m, -r@d3m + dx@d3m
pdy@d3m = -r@d3m + dy@d3m, -r@d3m + dy@d3m,  r@d3m + dy@d3m,  r@d3m + dy@d3m

psx@d3m = 0,  111, 111, 0
psy@d3m = y@d3m, y@d3m, y@d3m + 111, y@d3m + 111

gsquare@hsp 29, pdx@d3m, pdy@d3m, psx@d3m, psy@d3m
}
}
}

return@hsp




#deffunc d3particlem int ppi@d3m,double ppr@d3m

if@hsp df@d3m {
r@d3m = int@hsp(ppr@d3m / dz@d3m)
if@hsp (r@d3m > 0) & (abs@hsp(dx@d3m) < 10000) & (abs@hsp(dy@d3m) < 10000) {
y@d3m = ppi@d3m * 112

if@hsp r@d3m <= 10 {


pos@hsp dx@d3m - r@d3m, dy@d3m - r@d3m
gcopy@hsp 29,  112, (r@d3m-1)*r@d3m + y@d3m, r@d3m*2, r@d3m*2

} else@hsp {


pdx@d3m = -r@d3m + dx@d3m,  r@d3m + dx@d3m,  r@d3m + dx@d3m, -r@d3m + dx@d3m
pdy@d3m = -r@d3m + dy@d3m, -r@d3m + dy@d3m,  r@d3m + dy@d3m,  r@d3m + dy@d3m

psx@d3m = 0,  111, 111, 0
psy@d3m = y@d3m, y@d3m, y@d3m + 111, y@d3m + 111

gsquare@hsp 29, pdx@d3m, pdy@d3m, psx@d3m, psy@d3m
}
}
}

return@hsp




#deffunc d3createptc int ppi@d3m,int v02@d3m,int v03@d3m,int v04@d3m,int v05@d3m,int v06@d3m


b@d3m =  ginfo@hsp(3)



if@hsp ptc_inited@d3m ! 100 {
buffer@hsp 29, 112 + 10 * 2, 112 * 32
ptc_inited@d3m = 100
} else@hsp {
gsel@hsp 29
}
y@d3m = 112 * ppi@d3m



if@hsp v05@d3m {


pos@hsp 0, y@d3m
gzoom@hsp 112, 112, v02@d3m, v03@d3m, v04@d3m, v05@d3m, v06@d3m, 1

} else@hsp {


a@d3m = 112 / 2
color@hsp
boxf@hsp , y@d3m, , y@d3m + 111
repeat@hsp a@d3m
f@d3m = 1.0 + cnt@hsp



f@d3m = f@d3m * (f@d3m + a@d3m) / a@d3m / a@d3m / 2	

color@hsp f@d3m * v02@d3m, f@d3m * v03@d3m, f@d3m * v04@d3m
circle@hsp cnt@hsp, y@d3m + cnt@hsp, 112 - cnt@hsp, y@d3m + 112 - cnt@hsp
loop@hsp
}



repeat@hsp 10, 1
r@d3m = cnt@hsp
pos@hsp 112, (r@d3m-1)*r@d3m + y@d3m
gzoom@hsp r@d3m*2, r@d3m*2,  29,  0, y@d3m, 112, 112,  1
loop@hsp



gsel@hsp b@d3m

return@hsp




















#deffunc d3texture array aryx@d3m,array aryy@d3m,array aryz@d3m,int ppi@d3m,int ppx@d3m,int ppy@d3m,int ppw@d3m,int pph@d3m


repeat@hsp 4
vx@d3m=( double@hsp( aryx@d3m(cnt@hsp) ))-cpx@d3m : vy@d3m=( double@hsp( aryy@d3m(cnt@hsp) ))-cpy@d3m : vz@d3m=( double@hsp( aryz@d3m(cnt@hsp) ))-cpz@d3m : 	dy@d3m = vx@d3m * sinxy@d3m + vy@d3m * cosxy@d3m : 	dz@d3m = (dy@d3m * cosaz@d3m - vz@d3m * sinaz@d3m) / zoom@d3m : 	df@d3m = (dz@d3m > 0.05) : 	if@hsp df@d3m { 		dx@d3m = wincx@d3m + (vy@d3m * sinxy@d3m - vx@d3m * cosxy@d3m) / dz@d3m : 		dy@d3m = wincy@d3m + (dy@d3m * sinaz@d3m + vz@d3m * cosaz@d3m) / dz@d3m 	}


if@hsp abs@hsp(dx@d3m) > 30000 | abs@hsp(dy@d3m) > 30000 : df@d3m = 0

if@hsp df@d3m = 0 : break@hsp 

pdx@d3m(cnt@hsp) = int@hsp( dx@d3m )
pdy@d3m(cnt@hsp) = int@hsp( dy@d3m )
loop@hsp

if@hsp df@d3m {
if@hsp ppi@d3m >= 0 {
psx@d3m = ppx@d3m, ppx@d3m+ppw@d3m-1, ppx@d3m+ppw@d3m-1, ppx@d3m
psy@d3m = ppy@d3m, ppy@d3m,       ppy@d3m+pph@d3m-1, ppy@d3m+pph@d3m-1
gsquare@hsp ppi@d3m, pdx@d3m, pdy@d3m, psx@d3m, psy@d3m
} else@hsp {
gsquare@hsp ppi@d3m, pdx@d3m, pdy@d3m
}
}

return@hsp















#uselib "winmm.dll"
#cfunc d3timer "timeGetTime"




#defcfunc d3getfps 

a@d3m = d3timer() / 500
fpss@d3m(   a@d3m  & 7)++
fpss@d3m((a@d3m+1) & 7) = 0
fpss@d3m((a@d3m+2) & 7) = 0

return@hsp fpss@d3m((a@d3m-1) & 7) + fpss@d3m((a@d3m-2) & 7)



*_d3m_exit


dim@hsp fpss@d3m, 8
d3setcamx  -1000,  0,  0, 0, 0, 0
##2 "hsptmp"
##0 "dsoundex.as"
#uselib	"dsoundex.hpi"













#func ds_getdev	ds_getdev	$11
#func ds_setdev	ds_setdev	$0

#func ds_init	ds_init	$22
#func ds_load	ds_load	$6
#func ds_load2	ds_load2	$1
#func ds_memload	ds_memload	$1
#func ds_create	ds_create	$0
#func ds_write	ds_write	$1
#func ds_play	ds_play	$0
#func ds_loop	ds_loop	$0
#func ds_stop	ds_stop	$0
#func ds_getf	ds_getf	$0
#func ds_setf	ds_setf	$0
#func ds_getp	ds_getp	$0
#func ds_setp	ds_setp	$0
#func ds_stat	ds_stat	$0
#func ds_vol	ds_vol	$0
#func ds_pan	ds_pan	$0
#func ds_dup	ds_dup	$0
#func ds_rel	ds_rel	$0
#func ds_bye	ds_bye	$0
#func ds_free	ds_free	$100
#func timer	timer	$0

#func seq_read	seq_read	$1
#func seq_play	seq_play	$0
#func seq_stat	seq_stat	$0
#func seq_isplay	seq_isplay	$0
#func seq_stop	seq_stop	$0
#func seq_bye	seq_bye	$100

##3 "hsptmp"
##0 "hmm.as"
#uselib "hmm.dll"


#func hmminit HMMINIT 2
#func hmmend HMMEND $100


#func dsinit DSINIT 2
#func dsend DSEND 0
#func dsrelease DSRELEASE 0


#func dsloadfname DSLOADFNAME $202
#func dsloadfname2 DSLOADFNAME2 $202
#func dsloadmemory DSLOADMEMORY 1
#func dsoggloadfname DSOGGLOADFNAME $202
#func dsoggloadfnamethread DSOGGLOADFNAMETHREAD $202
#func dsoggloadingcheck DSOGGLOADINGCHECK $202


#func dsplay DSPLAY 0
#func dsstop DSSTOP 0


#func dsgetvolume DSGETVOLUME 0
#func dssetvolume DSSETVOLUME 0
#func dsgetmastervolume DSGETMASTERVOLUME 0
#func dssetmastervolume DSSETMASTERVOLUME 0
#func dssetmasterformat DSSETMASTERFORMAT 0
#func dscheckplay CHECKPLAY 0
#func dsduplicate DSDUPLICATE 0


#func dminit DMINIT 2
#func dmend DMEND 0
#func dmloadfname DMLOADFNAME 6
#func dmloadmemory DMLOADMEMORY 1
#func dmplay DMPLAY 0
#func dmstop DMSTOP 2

#func diinit DIINIT 2
#func diend DIEND 0
#func digetjoynum DIGETJOYNUM 0
#func digetjoystate DIGETJOYSTATE 1
#func digetpastjoystate DIGETPASTJOYSTATE 1
#func digetkeepjoystate DIGETKEEPJOYSTATE 1
#func digetmomentjoystate DIGETMOMENTJOYSTATE 1
#func digetkeystate DIGETKEYSTATE 1
#func digetpastkeystate DIGETPASTKEYSTATE 1
#func digetkeepkeystate DIGETKEEPKEYSTATE 1
#func digetmomentkeystate DIGETMOMENTKEYSTATE 1
#func distick DISTICK 1
#func diplayeffect DIPLAYEFFECT 0
#func distopeffect DISTOPEFFECT 0

#func hmmbiton HMMBITON 1
#func hmmbitoff HMMBITOFF 1
#func hmmbitcheck HMMBITCHECK 0

#func hmmgetfps HMMGETFPS 1
#func hmmgetsin HMMGETSIN 1

#func hmmhitcheck HMMHITCHECK $202
#func hmmhitchecksetindex HMMHITCHECKSETINDEX $202


#func ddinit DDINIT 2
#func ddscreen DDSCREEN 0
#func ddgsel DDGSEL 0
#func ddloadfname DDLOADFNAME 6
#func ddbuffer DDBUFFER 0
#func ddsetrect DDSETRECT 0
#func ddgcopy DDGCOPY 0
#func ddboxf DDBOXF 0
#func ddcolor DDCOLOR 0
#func ddprint DDPRINT 6
#func dddrawtext DDDRAWTEXT 6
#func ddredraw DDREDRAW 0
#func ddsetrenewaltiming DDSETRENEWALTIMING 0
#func ddend DDEND 0
#func ddblendgcopy DDBLENDGCOPY 0
#func ddreverse DDREVERSE 0
#func ddaddgcopy DDADDGCOPY 0
#func ddsubgcopy DDSUBGCOPY 0
#func ddloadmemory DDLOADMEMORY 1
#func ddgzoom DDGZOOM 0
#func ddpos DDPOS 0
#func ddrotategcopy DDROTATEGCOPY 0
#func ddgcopy2 DDGCOPY2 0
#func ddaddgcopyall DDADDGCOPYALL 1
#func ddbgcopy DDBGCOPY 0
#func ddpaintgcopy DDPAINTGCOPY $202

#func dginit DGINIT 2
#func dgend DGEND 0
#func dgscreen DGSCREEN $202
#func dgcolor DGCOLOR 0
#func dgclear DGCLEAR 0
#func dgrenewaltiming DGRENEWALTIMING 0
#func dgredraw DGREDRAW 0
#func dggsel DGGSEL 0
#func dgbuffer DGBUFFER 0
#func dgloadfname DGLOADFNAME 6
#func dgloadmemory DGLOADMEMORY 1
#func dgpos DGPOS 0
#func dgrect DGRECT 0
#func dgscaleandangle DGSCALEANDANGLE 0
#func dgblendmode DGBLENDMODE 0
#func dggcopy DGGCOPY 0
#func dgfont DGFONT 6
#func dgdrawtext DGDRAWTEXT 6
#func dgbmpsave DGBMPSAVE 6
#func dgtexture DGTEXTURE 0
#func dgaddprimitive DGADDPRIMITIVE 0
#func dgdrawprimitive DGDRAWPRIMITIVE 0
#func dgcreateprimitive DGCREATEPRIMITIVE 0
#func dgline DGLINE 0

#func dshinit DSHINIT 2
#func dshend DSHEND 0
#func dshloadfname DSHLOADFNAME 6
#func dshplay DSHPLAY $202
#func dshstop DSHSTOP 0
#func dshpause DSHPAUSE 0
#func dshsetfullscreen DSHSETFULLSCREEN 0
#func dshsetseek DSHSETSEEK 0
#func dshsetrate DSHSETRATE 0
#func dshsetvideoparam DSHSETVIDEOPARAM $202
#func dshgetoriginalvideosize DSHGETORIGINALVIDEOSIZE $202
#func dshcheckplay DSHCHECKPLAY 0
#func dshsetvolume DSHSETVOLUME 0
#func dshgetplayposition DSHGETPLAYPOSITION $202
#func dshsetvideovisible DSHSETVIDEOVISIBLE 0
#func dshsetmovietodgbuffer DSHSETMOVIETODGBUFFER 0








































































##4 "hsptmp"

ds_init
hmminit 2

goto@hsp *start

#deffunc getick 

name=0


getkey@hsp left,37
getkey@hsp right,39
getkey@hsp up,38
getkey@hsp down,40
getkey@hsp sps,32


getkey@hsp ent,13
getkey@hsp xkey,88


if@hsp left=1:name+=1
if@hsp right=1:name+=4
if@hsp up=1:name+=2
if@hsp down=1:name+=8
if@hsp sps=1:name+=16

if@hsp ent=0:buf=0
if@hsp ent=1&buf=0{
buf=1
name+=32
}

if@hsp xkey=0:buf2=0
if@hsp xkey=1&buf2=0{
buf2=1
name+=64
}

return@hsp name
*start

randomize@hsp





















screen@hsp 0,440,440
cls@hsp 
color@hsp 0,0,0
pos@hsp 0,0
mes@hsp "now loading"
*top


dim@hsp sina,360 : dim@hsp cosa,360	
cosa.0=10000 : sina.0=0
cosa.1=9999 : sina.1=175

repeat@hsp 358,1
ent=cnt@hsp+1
cosa.ent=((cosa.1*cosa.cnt@hsp)-(sina.1*sina.cnt@hsp))/10000
sina.ent=((sina.1*cosa.cnt@hsp)+(cosa.1*sina.cnt@hsp))/10000
loop@hsp


tmax=1000				


dim@hsp tf,tmax				






dim@hsp tcx,tmax			
dim@hsp tcy,tmax			




dim@hsp dis,tmax			
dim@hsp objtimek2,tmax		
dim@hsp objtimek3,tmax		
dimtype@hsp  kaitendo,3,tmax,0,0,0		


maxdansu=100



dim@hsp shotf,maxdansu			






dim@hsp shotdis,maxdansu	




ket=220				
 sdim@hsp enemydate,2000
dansu=2				
life=10				
drawhantei=0		
sp=1				
waitkaunt=1			
chp=150				
kasurikaunter=300
waponx=440
sdim@hsp replay,16400
replayname="replay1"
ketx=180



buffer@hsp 3,,,
picload@hsp "mychar.bmp",1
buffer@hsp 4,,,
picload@hsp "zako.gif",1
buffer@hsp 5,,,
picload@hsp "alltama.bmp",1
buffer@hsp 6,,,
picload@hsp "haikei.gif",1
buffer@hsp 7,1470,64,
picload@hsp "chuboss.bmp",1
buffer@hsp 8,,,
picload@hsp "system.bmp",1
buffer@hsp 9,,,
picload@hsp "boss.gif",1





dmloadfname "stage1.mid", 4
dmloadfname "boss01a.mid", 2
dmloadfname "boss01b.mid", 3


ds_load "bom.wav",2
ds_load "zasizasi.wav",3
ds_load "bokan.wav",4
ds_load "poka.wav",5
ds_load "bachi.wav",6
ds_load "poi2.wav",7
ds_load "kin.wav",8
ds_load "bishao.wav",10

















d3createptc  0,  255,  255,  255 
d3createptc  1,   64,  192,  255 
d3createptc  2,   255,  0, 	0 

*titleloop

gsel@hsp 0	
redraw@hsp 2

ct++
redraw@hsp 0

color@hsp , 8, 24
boxf@hsp

d3setcamx  0, 0, -500, 0, 0, 0

randomize@hsp 0
repeat@hsp 100

x = rnd@hsp(8000) - 4000
y = rnd@hsp(8000) - 4000
z = rnd@hsp(8000)
v = rnd@hsp(50) + 50

z = (ct * v + z) \ 8000 - 8000


gmode@hsp 5, , , 64
d3particle 1,  x, y, -z, 150


gmode@hsp 5, , , 255
d3particlem  0, 50

loop@hsp

color@hsp 255,0,0
font@hsp "MS ゴシック",20
pos@hsp 100,100
mes@hsp "トイレへＧＯ３"
gmode@hsp 5, , , 255
d3particle  0,-85,110,0, 50
gmode@hsp 2,42,51,
pos@hsp 100,120:gcopy@hsp 3,0,50,42,51


font@hsp "MS ゴシック",16:color@hsp 255,0,0
pos@hsp 200,220:mes@hsp " Play "
pos@hsp 200,240:mes@hsp " Replay"
pos@hsp 200,260:mes@hsp " Option"
pos@hsp 200,280:mes@hsp " Exit "
pos@hsp ketx,ket:mes@hsp "→ "
pos@hsp 380,420:mes@hsp "fps="+fps


gosub@hsp *key
if@hsp kettei=1:goto@hsp *stagestart


fps=d3getfps()
if@hsp fps>60:waitkaunt=double@hsp(waitkaunt)+0.1
if@hsp fps<40:waitkaunt=double@hsp(waitkaunt)-0.1
if@hsp waitkaunt<=0.0:waitkaunt=0
await@hsp waitkaunt

redraw@hsp 1
goto@hsp *titleloop
*key

stick@hsp keyin

if@hsp keyin&8:ket+=20:menu+=1
if@hsp keyin&2:ket-=20:menu-=1

ket=limit@hsp(ket,220,280)
menu=limit@hsp(menu,0,3)
if@hsp keyin&36:kettei=1

return@hsp

*stagestart
kettei=0
if@hsp menu=1:goto@hsp *replayload
if@hsp menu=2:goto@hsp *titleloop
if@hsp menu=3:goto@hsp *endo
*stagestart2


cls@hsp
mes@hsp "Now loading"
dmplay 0, 4
mx=160:my=440
mapy=0

d3setcamx  0, 0, 10, 0, 0, 0


bload@hsp "stage1.dat",enemydate
notesel@hsp enemydate
sdim@hsp one,20, noteinfo@hsp(0)
sdim@hsp enemyline,20, noteinfo@hsp(0)	
csvline=""
repeat@hsp  noteinfo@hsp(0)
noteget@hsp one,cnt@hsp
csvnote csvline,one
enemyline.cnt@hsp=csvline
loop@hsp
gsel@hsp 0

*mainloop

ct++
frame+=1
redraw@hsp 0

color@hsp 0,0,0
boxf@hsp 0,0,440,440

gosub@hsp *backg_screen
gosub@hsp *write_stage
gosub@hsp *keychk

gosub@hsp *write_status
gosub@hsp *write_mychar
gosub@hsp *put_shot
gosub@hsp *call_enemy

gosub@hsp *object_move

if@hsp hissatuf=1:gosub@hsp *moreta_wapon

redraw@hsp 1
gosub@hsp *hitchk

fps=d3getfps()	
if@hsp fps>=60:waitkaunt=double@hsp(waitkaunt)+0.1
if@hsp fps<=40:waitkaunt=double@hsp(waitkaunt)-0.1
if@hsp waitkaunt<=0.0:waitkaunt=0
await@hsp waitkaunt


goto@hsp *mainloop

*backg_screen


pos@hsp 0,mapy:gcopy@hsp 6,0,0,352,440
pos@hsp 0,mapy-440:gcopy@hsp 6,0,0,352,440

mapy+=1
if@hsp mapy>=440:mapy=0

if@hsp frame\50=0{
repeat@hsp tmax
if@hsp tf.cnt@hsp>0 :continue@hsp							
rrr=rnd@hsp(350)		
rr2=rnd@hsp(5)
eh+
eh2.cnt@hsp=90										
tf.cnt@hsp=1										
tc.cnt@hsp=255										
ts.cnt@hsp=11
tx.cnt@hsp=rrr*1000 :ty.cnt@hsp=0*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/4+rr2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/4+rr2	


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp
}

return@hsp
*write_stage



if@hsp titlex>=440:return@hsp
color@hsp 255,255,255
pos@hsp titlex,100:font@hsp "MS ゴシック",30:mes@hsp "Stage1"
titlex+=1







if@hsp titlex>=50:return@hsp
my-=3

return@hsp
*keychk


if@hsp replayf=0{

getick
keyon=stat@hsp
poke@hsp replay,frame,keyon
}
if@hsp replayf=1{
memcpy@hsp keyon,replay,1,0,frame
}


ido=4
if@hsp keyon&16:ido=2

if@hsp kaiwaf>=1{
if@hsp keyon&32{
kaiwaf+=1
}
}

if@hsp keyon&2{
if@hsp my>=0:my-=ido
}
if@hsp keyon&8{
if@hsp my<=410:my+=ido
}
if@hsp keyon&4{
if@hsp mx<=310:mx+=ido
}
if@hsp keyon&1{
if@hsp mx>=0:mx-=ido
}

if@hsp keyon&64{
if@hsp kasurikaunter>=300{
hissatuf=1
ds_play 8
}
}



return@hsp
*write_status


font@hsp "MS ゴシック",16
color@hsp 255,255,255

pos@hsp 350,0:mes@hsp "Score"
pos@hsp 400,20:mes@hsp score
pos@hsp 355,40:mes@hsp "life"
pos@hsp 355,80:mes@hsp "Bom"
pos@hsp 355,100:mes@hsp "****"
pos@hsp 350,130:mes@hsp "ShotItem:"+shotpower

if@hsp shotpower=20{
shotpower=0
shotlv+=1
dansu+=2
ds_play 7
}

pos@hsp 350,160:mes@hsp "ShotLv:"+shotlv
pos@hsp 355,200:mes@hsp "FPS="+fps
mes@hsp "wait="+waitkaunt
mes@hsp "object:"+sonzai
mes@hsp "kasuri="+kasurikaunter
line@hsp 355,400,355+kasurikaunter/10,400
mes@hsp "Frame="+frame


if@hsp life<=0:return@hsp
repeat@hsp life
pos@hsp 355+5*cnt@hsp,60:mes@hsp "|"
loop@hsp

return@hsp
*write_mychar

if@hsp mutekif=0:gmode@hsp 2,40,30,
if@hsp mutekif=1:gmode@hsp 2,40,30,
if@hsp mutekif>=2{
if@hsp frame\5=1:gmode@hsp 5,,,200:else@hsp:gmode@hsp 2,40,30
mutekif+=1
if@hsp mutekif>=100:mutekif=0
}
pos@hsp mx,my:gcopy@hsp 3,0,0,40,30
gmode@hsp 2,10,17

pos@hsp mx+1,my+10:gcopy@hsp 3,jetx2,32,10,17
pos@hsp mx+25,my+10:gcopy@hsp 3,jetx2,32,10,17


mycharcenterx=mx+18
mycharcentery=my+15

mycharuppery=3
mycharrightx=3

kasury=15
kasurx=20

return@hsp
*put_shot
if@hsp utta=1:uttakaunter+=1
if@hsp uttakaunter>=6:utta=0:uttakaunter=0
if@hsp utta=1:return@hsp


repeat@hsp dansu
gdansu=cnt@hsp

repeat@hsp maxdansu

if@hsp shotf.cnt@hsp>0 :continue@hsp									
eh+


if@hsp gdansu\2=0{
shotxmove=0
}else@hsp{
shotxmove=10
}

if@hsp gdansu=0:eh3.cnt@hsp=270		
if@hsp gdansu=1:eh3.cnt@hsp=270	
if@hsp gdansu=2:eh3.cnt@hsp=268
if@hsp gdansu=3:eh3.cnt@hsp=272
if@hsp gdansu=4:eh3.cnt@hsp=266
if@hsp gdansu=5:eh3.cnt@hsp=274
if@hsp gdansu=6:eh3.cnt@hsp=264
if@hsp gdansu=7:eh3.cnt@hsp=274
if@hsp gdansu=8:eh3.cnt@hsp=262
if@hsp gdansu=9:eh3.cnt@hsp=276
if@hsp gdansu=10:eh3.cnt@hsp=260
if@hsp gdansu=11:eh3.cnt@hsp=278
if@hsp gdansu=12:eh3.cnt@hsp=258
if@hsp gdansu=13:eh3.cnt@hsp=280
if@hsp gdansu=14:eh3.cnt@hsp=256
if@hsp gdansu=15:eh3.cnt@hsp=282


shotf.cnt@hsp=1												

shotx.cnt@hsp=(mx+14+shotxmove)*1000: shoty.cnt@hsp=my*1000		
shotxv.cnt@hsp=cosa(eh3.cnt@hsp)*sp : shotyv.cnt@hsp=sina(eh3.cnt@hsp)*sp			
if@hsp eh=1 : eh=0 : break@hsp									

loop@hsp

loop@hsp
shothitx=1
shothity=11
utta=1
return@hsp
*moreta_wapon
if@hsp kasurikaunter<300:hissatuf=0:return@hsp



if@hsp waponx>=-400{

pos@hsp waponx,220
gmode@hsp 2,51,44
gcopy@hsp 3,90,48,51,44
pos@hsp waponx+60:font@hsp "MS　ゴシック",30
mes@hsp "もれ太スパーク！！"
waponx-=10
}
if@hsp waponx<=0{
repeat@hsp 2
wcnt=cnt@hsp
repeat@hsp maxdansu

if@hsp shotf.cnt@hsp>0 :continue@hsp									
eh+
if@hsp wcnt=0:rand=0
if@hsp wcnt=1:rand=180
eh3.cnt@hsp=rand
shotf.cnt@hsp=2												
shotx.cnt@hsp=(mx+14+shotxmove)*1000: shoty.cnt@hsp=my*1000		
shotxv.cnt@hsp=cosa(eh3.cnt@hsp)*sp : shotyv.cnt@hsp=sina(eh3.cnt@hsp)*sp			
if@hsp eh=1 : eh=0 : break@hsp									

loop@hsp
loop@hsp
kasurikaunter-=300:waponx=440:hissatuf=0
}

return@hsp
*call_enemy

notesel@hsp enemyline.turn
noteget@hsp enemyname,0


if@hsp enemyname="sleep":gosub@hsp *sleeping
if@hsp enemyname="kaiwa1":gosub@hsp *k1
if@hsp enemyname="kaiwa2":gosub@hsp *k2
if@hsp enemyname="kaiwa3":gosub@hsp *k3
if@hsp enemyname="stop":gosub@hsp *teisi
if@hsp enemyname="enemy1":gosub@hsp *put_enemy1
if@hsp enemyname="enemy2":gosub@hsp *put_enemy2
if@hsp enemyname="enemy3":gosub@hsp *put_enemy3
if@hsp enemyname="midle1":gosub@hsp *midle1
if@hsp enemyname="boss1":gosub@hsp *boss1

return@hsp
*k1
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{
pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 8,0,123,80,99


if@hsp kaiwakaunter>=140{
pos@hsp 100,310
mes@hsp "通信士\n\nわが軍の領内にUNKNOWN機が進入！"
}
kaiwakaunter+=10
}

if@hsp kaiwaf=2{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,0,123,80,99

pos@hsp 100,310
mes@hsp "通信士\n\n機体確認信号に答えません！\n隊長！どうしますか！？"

}
if@hsp kaiwaf=3{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
mes@hsp "隊長\n\n全員、攻撃の用意!\n\n抵抗した場合は撃墜してもかまわん！"

}
if@hsp kaiwaf=4{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 2,,,
pos@hsp 10,310
gcopy@hsp 3,90,48,51,44


pos@hsp 100,310
mes@hsp "もれ太\n\nトイレは何処だろうかナァ。"

}
if@hsp kaiwaf=5{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,310:gmode@hsp 2,,,
gcopy@hsp 3,90,48,51,44

pos@hsp 100,310
mes@hsp "もれ太\n\nくそ、銃のトリガーがこわれてて\nたれ流しだ。"

}
if@hsp kaiwaf=6{
kaiwaf=0
turn+=1
kaiwakaunter=0
}

return@hsp
*k2
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 8,0,123,80,99


if@hsp kaiwakaunter>=140{
pos@hsp 100,310
mes@hsp "通信士\n\n防衛線を突破されました！"
}
kaiwakaunter+=10
}

if@hsp kaiwaf=2{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
mes@hsp "隊長\n\nなんという強さだ・・。\n試作機だが、'NOSTRA'を出動させろ！"


}
if@hsp kaiwaf=3{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
mes@hsp "隊長\n\nしかし、奴の目的は\n何なんだ・・・？"

}
if@hsp kaiwaf=4{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 2,,,
pos@hsp 10,310
gcopy@hsp 3,90,48,51,44


pos@hsp 100,310
mes@hsp "もれ太\n\nうートイレトイレ。"
mmstop@hsp
}

if@hsp kaiwaf=5{
kaiwaf=0
turn+=1
kaiwakaunter=0
dmplay 0,2

}

return@hsp
*k3
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 8,82,123,80,99


if@hsp kaiwakaunter>=140{
pos@hsp 100,310
mes@hsp "隊長\n\nまだまだ！ﾌｧﾝﾈﾙがのこっている！"
}
kaiwakaunter+=10
}

if@hsp kaiwaf=2{
kaiwaf=0
turn+=1
kaiwakaunter=0
gook=1
}

return@hsp

*put_enemy1

noteget@hsp exa,1
noteget@hsp eya,2



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 :continue@hsp							
eh+
eh2.cnt@hsp=90										
tf.cnt@hsp=1										
tc.cnt@hsp=255										

ts.cnt@hsp=1										

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5	


hitchklenghx.cnt@hsp=13
hitchklenghy.cnt@hsp=13


tcplusx.cnt@hsp=12
tcplusy.cnt@hsp=12

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*put_enemy2
noteget@hsp exa,1
noteget@hsp eya,2



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 :continue@hsp							
eh+
eh2.cnt@hsp=89										
tf.cnt@hsp=1										
tc.cnt@hsp=255										
ts.cnt@hsp=5

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5	


hitchklenghx.cnt@hsp=13
hitchklenghy.cnt@hsp=13


tcplusx.cnt@hsp=12
tcplusy.cnt@hsp=12

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1	
return@hsp
*put_enemy3
noteget@hsp exa,1
noteget@hsp eya,2



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 :continue@hsp							
eh+
eh2.cnt@hsp=180										

tf.cnt@hsp=1										
tc.cnt@hsp=255										
ts.cnt@hsp=9

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/3 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/3	


hitchklenghx.cnt@hsp=13
hitchklenghy.cnt@hsp=13


tcplusx.cnt@hsp=12
tcplusy.cnt@hsp=12

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1	
return@hsp
*midle1

noteget@hsp exa,1
noteget@hsp eya,2
noteget@hsp chp,3
chp=int@hsp(chp)


repeat@hsp tmax
if@hsp tf.cnt@hsp>0 :continue@hsp							
eh+
eh2.cnt@hsp=125											
tf.cnt@hsp=1										
tc.cnt@hsp=255										
ts.cnt@hsp=6

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000		
txv.cnt@hsp=cosa(eh2.cnt@hsp)/10 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/10			


hitchklenghx.cnt@hsp=32
hitchklenghy.cnt@hsp=32


tcplusx.cnt@hsp=32
tcplusy.cnt@hsp=32

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*boss1

noteget@hsp exa,1
noteget@hsp eya,2
noteget@hsp dhp,3
bhp=int@hsp(dhp)


repeat@hsp tmax
if@hsp tf.cnt@hsp>0 :continue@hsp							
eh+
eh2.cnt@hsp=90											
tf.cnt@hsp=1										
tc.cnt@hsp=255										
ts.cnt@hsp=12

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000		
txv.cnt@hsp=cosa(eh2.cnt@hsp)/10 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/10			


hitchklenghx.cnt@hsp=64
hitchklenghy.cnt@hsp=32


tcplusx.cnt@hsp=60
tcplusy.cnt@hsp=32

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*put_item


repeat@hsp tmax
if@hsp tf.cnt@hsp>0 :continue@hsp							
eh+
eh2.cnt@hsp=270 
tf.cnt@hsp=1										
ts.cnt@hsp=4


hitchklenghx.cnt@hsp=20
hitchklenghy.cnt@hsp=20


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=9

tc.cnt@hsp=255											
tx.cnt@hsp=(tx2.target+9)*1000 :ty.cnt@hsp=ty2.target*1000	
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5	
if@hsp eh=1 : eh=0 : break@hsp								
loop@hsp

return@hsp
*put_enemyshot1

if@hsp mutekif>=1:return@hsp



kyorx=tx2.target-mx
kyory=ty2.target-my
if@hsp tx2.target>mx:hantenx=1:else@hsp:hantenx=0
if@hsp ty2.target>my:hanteny=1:else@hsp:hanteny=0


kyory=abs@hsp(kyory)
kyorx=abs@hsp(kyorx)
if@hsp kyorx=0 :kyorx+=1
if@hsp kyory=0 :kyory+=1


zahyo=double@hsp(kyory)/double@hsp(kyorx)
a=atan@hsp(zahyo)
b=a*180/3.1415926535897932384626433832795
b=int@hsp(b)

if@hsp hantenx=1:b=180-b
if@hsp hanteny=1:b=360-b
if@hsp b>=360:b=4
if@hsp b<=0:b=4


repeat@hsp tmax
if@hsp tf.cnt@hsp>0 :continue@hsp							
eh+
eh2.cnt@hsp=b-2										
tf.cnt@hsp=1										
tc.cnt@hsp=255										
ts.cnt@hsp=2										

tx.cnt@hsp=tx2.target*1000 :ty.cnt@hsp=ty2.target*1000		
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5
tyv.cnt@hsp=sina(eh2.cnt@hsp)/5	


hitchklenghx.cnt@hsp=2
hitchklenghy.cnt@hsp=2


tcplusx.cnt@hsp=2
tcplusy.cnt@hsp=2

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

return@hsp
*endanmak

if@hsp mutekif>=1:return@hsp

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 :continue@hsp							
eh+
eh2.cnt@hsp=(eh-1)*10+(pt*5) : if@hsp eh2>359 : eh2-=360	
tf.cnt@hsp=1										
ts.cnt@hsp=2

tc.cnt@hsp=255										
tx.cnt@hsp=(tx2.target+8)*1000 :ty.cnt@hsp=(ty2.target-3)*1000	
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5			

if@hsp ts.target=12:tx.cnt@hsp=(tcx.target)*1000 :ty.cnt@hsp=(tcy.target)*1000	


hitchklenghx.cnt@hsp=3
hitchklenghy.cnt@hsp=3


tcplusx.cnt@hsp=2
tcplusy.cnt@hsp=2

if@hsp eh=36 : eh=0 : break@hsp							
loop@hsp

return@hsp
*danmak2

if@hsp mutekif>=1:return@hsp


kyorx=tx2.target-mx
kyory=ty2.target-my
if@hsp tx2.target>mx:hantenx=1:else@hsp:hantenx=0
if@hsp ty2.target>my:hanteny=1:else@hsp:hanteny=0


kyory=abs@hsp(kyory)
kyorx=abs@hsp(kyorx)
if@hsp kyorx=0 :kyorx+=1
if@hsp kyory=0 :kyory+=1


zahyo=double@hsp(kyory)/double@hsp(kyorx)
a=atan@hsp(zahyo)
b=a*180/3.1415926535897932384626433832795
b=int@hsp(b)

if@hsp hantenx=1:b=180-b
if@hsp hanteny=1:b=360-b
if@hsp b>=360:b=2
if@hsp b<=0:b=2

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 :continue@hsp							
eh+
if@hsp eh\2=0:maikai=-1:else@hsp:maikai=1

eh2.cnt@hsp=b-2+(eh*5*(maikai)) : if@hsp eh2.cnt@hsp>359 : eh2.cnt@hsp-=360
tf.cnt@hsp=1										
ts.cnt@hsp=7

tc.cnt@hsp=255										
tx.cnt@hsp=(tx2.target+8)*1000 :ty.cnt@hsp=(ty2.target-3)*1000	
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5			


if@hsp ts.target=6{
tx.cnt@hsp=(tcx.target-14)*1000 :ty.cnt@hsp=tcy.target*1000
txv.cnt@hsp=cosa(eh2.cnt@hsp)/3:tyv.cnt@hsp=sina(eh2.cnt@hsp)/3
}
if@hsp ts.target=12{
tx.cnt@hsp=(tcx.target-5)*1000 :ty.cnt@hsp=(tcy.target)*1000
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2:tyv.cnt@hsp=sina(eh2.cnt@hsp)/2
}


hitchklenghx.cnt@hsp=3
hitchklenghy.cnt@hsp=3


tcplusx.cnt@hsp=2
tcplusy.cnt@hsp=2

if@hsp eh=6 : eh=0 : break@hsp							
loop@hsp

return@hsp
*danmak3

if@hsp mutekif>=1:return@hsp


kyorx=tx2.target-mx
kyory=ty2.target-my
if@hsp tx2.target>mx:hantenx=1:else@hsp:hantenx=0
if@hsp ty2.target>my:hanteny=1:else@hsp:hanteny=0


kyory=abs@hsp(kyory)
kyorx=abs@hsp(kyorx)
if@hsp kyorx=0 :kyorx+=1
if@hsp kyory=0 :kyory+=1


zahyo=double@hsp(kyory)/double@hsp(kyorx)
a=atan@hsp(zahyo)
b=a*180/3.1415926535897932384626433832795
b=int@hsp(b)

if@hsp hantenx=1:b=180-b
if@hsp hanteny=1:b=360-b
if@hsp b>=360:b=2
if@hsp b<=0:b=2

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 :continue@hsp							
eh+
if@hsp eh\2=0:maikai=-1:else@hsp:maikai=1

eh2.cnt@hsp=b-2+(eh*5*(maikai)) : if@hsp eh2.cnt@hsp>359 : eh2.cnt@hsp-=360
tf.cnt@hsp=1										
ts.cnt@hsp=10

tc.cnt@hsp=255										
tx.cnt@hsp=(tx2.target+8)*1000 :ty.cnt@hsp=(ty2.target-3)*1000	
txv.cnt@hsp=cosa(eh2.cnt@hsp)/3 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/3			

if@hsp ts.target=12{
tx.cnt@hsp=(tcx.target-14)*1000 :ty.cnt@hsp=(tcy.target+10)*1000
txv.cnt@hsp=cosa(eh2.cnt@hsp)/3:tyv.cnt@hsp=sina(eh2.cnt@hsp)/3
}


hitchklenghx.cnt@hsp=3
hitchklenghy.cnt@hsp=3


tcplusx.cnt@hsp=2
tcplusy.cnt@hsp=2

if@hsp eh=3 : eh=0 : break@hsp							
loop@hsp

return@hsp
*danmak4

if@hsp mutekif>=1:return@hsp

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 :continue@hsp							
eh+
if@hsp eh\2=0:maikai=-1:else@hsp:maikai=1

eh2.cnt@hsp=0
tf.cnt@hsp=1										
ts.cnt@hsp=13

tc.cnt@hsp=255										
if@hsp eh=1:	tx.cnt@hsp=(tcx.target+52)*1000	:	ty.cnt@hsp=(tcy.target-15)*1000
if@hsp eh=2:	tx.cnt@hsp=(tcx.target-57)*1000	:	ty.cnt@hsp=(tcy.target-15)*1000
if@hsp eh=3:	tx.cnt@hsp=(tcx.target+50)*1000	:	ty.cnt@hsp=(tcy.target-30)*1000
if@hsp eh=4:	tx.cnt@hsp=(tcx.target-55)*1000	:	ty.cnt@hsp=(tcy.target-30)*1000
if@hsp eh=5:	tx.cnt@hsp=(tcx.target+50)*1000	:	ty.cnt@hsp=(tcy.target+7)*1000
if@hsp eh=6:	tx.cnt@hsp=(tcx.target-55)*1000	:	ty.cnt@hsp=(tcy.target+7)*1000

txv.cnt@hsp=0 : tyv.cnt@hsp=0			


hitchklenghx.cnt@hsp=3
hitchklenghy.cnt@hsp=3


tcplusx.cnt@hsp=2
tcplusy.cnt@hsp=2

if@hsp eh=6 : eh=0 : break@hsp							
loop@hsp

return@hsp
*uzudanmak
if@hsp mutekif=1:return@hsp

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 :continue@hsp							
eh+
tf.cnt@hsp=1										
ts.cnt@hsp=10
if@hsp type=0:ts.cnt@hsp=10
if@hsp type=1:ts.cnt@hsp=7	
tc.cnt@hsp=255										
eh2.cnt@hsp=(eh-1)*30+(frame\60) : if@hsp eh2.cnt@hsp>359 : eh2.cnt@hsp-=360
if@hsp ts.target=12:tx.cnt@hsp=(tcx.target)*1000 :ty.cnt@hsp=(tcy.target)*1000	
txv.cnt@hsp=cosa(eh2.cnt@hsp)/spd : tyv.cnt@hsp=sina(eh2.cnt@hsp)/spd


hitchklenghx.cnt@hsp=3
hitchklenghy.cnt@hsp=3


tcplusx.cnt@hsp=2
tcplusy.cnt@hsp=2

if@hsp eh=12 : eh=0 : break@hsp							
loop@hsp

return@hsp

*object_move


sonzai=0
repeat@hsp tmax
if@hsp tf.cnt@hsp<1 :continue@hsp						
sonzai+=1

tx.cnt@hsp+=txv.cnt@hsp : ty.cnt@hsp+=tyv.cnt@hsp			
tx2.cnt@hsp=tx.cnt@hsp/1000 : ty2.cnt@hsp=ty.cnt@hsp/1000	


tcx.cnt@hsp=tx2.cnt@hsp+tcplusx.cnt@hsp
tcy.cnt@hsp=ty2.cnt@hsp+tcplusy.cnt@hsp

if@hsp (tx2.cnt@hsp>355)|(tx2.cnt@hsp<-64)|(ty2.cnt@hsp<-64)|(ty2.cnt@hsp>440){

tf(cnt@hsp)=0
ts(cnt@hsp)=0
objtimek.cnt@hsp=0
txv.cnt@hsp=0
tyv.cnt@hsp=0
continue@hsp

}

pos@hsp tx2.cnt@hsp-4,ty2.cnt@hsp-4







if@hsp ts.cnt@hsp=1{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,32,32
gcopy@hsp 4,0,0,32,32
if@hsp objtimek.cnt@hsp<=150&objtimek.cnt@hsp>=100{
if@hsp objtimek.cnt@hsp<=100+0*1&objtimek.cnt@hsp>=100{
target=cnt@hsp
gosub@hsp *put_enemyshot1
target=0
objtimek.cnt@hsp=0
}
}
}else@hsp{

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000

if@hsp dis.cnt@hsp=1{
target=cnt@hsp
gosub@hsp *put_item
target=0
dis.cnt@hsp=2
}
objtimek.cnt@hsp+=1

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*32
gmode@hsp 2,32,32
gcopy@hsp 4,objtimek3.cnt@hsp,0,32,32
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0
txv.cnt@hsp=0 : tyv.cnt@hsp=0
}				
}				
}






if@hsp ts.cnt@hsp=5{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,32,32
gcopy@hsp 4,0,31,31,31
if@hsp objtimek.cnt@hsp<=150&objtimek.cnt@hsp>=50{
if@hsp objtimek.cnt@hsp<=50+1*30&objtimek.cnt@hsp>=50{
target=cnt@hsp
if@hsp objtimek.cnt@hsp\30=1:gosub@hsp *endanmak
target=0
}
}
if@hsp objtimek.cnt@hsp=50{
eh2.cnt@hsp=270
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5
}

}else@hsp{

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000

if@hsp dis.cnt@hsp=1{
target=cnt@hsp
gosub@hsp *put_item
target=0
dis.cnt@hsp=2
}
objtimek.cnt@hsp+=1

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*32
gmode@hsp 2,32,32
gcopy@hsp 4,objtimek3.cnt@hsp,31,31,31
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0

}

}

}






if@hsp ts.cnt@hsp=9{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,35,30
gcopy@hsp 4,0,62,35,30
if@hsp objtimek.cnt@hsp<=150&objtimek.cnt@hsp>=20{
eh2.cnt@hsp+=20
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5
if@hsp objtimek.cnt@hsp<=20+0*1&objtimek.cnt@hsp>=20{
target=cnt@hsp
gosub@hsp *danmak3
target=0
objtimek.cnt@hsp=0
}
}
}else@hsp{
if@hsp dis.cnt@hsp=1{
target=cnt@hsp
gosub@hsp *put_item
target=0
dis.cnt@hsp=2
}
objtimek.cnt@hsp+=1


hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*32
gmode@hsp 2,32,32
gcopy@hsp 4,objtimek3.cnt@hsp,0,32,32
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0

}				
}				
}


if@hsp ts.cnt@hsp=6{

if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,64,64
gcopy@hsp 7,0,0,64,64

if@hsp objtimek.cnt@hsp<=150&objtimek.cnt@hsp>=50{
if@hsp objtimek.cnt@hsp<=50+2*30&objtimek.cnt@hsp>=50{
eh2.cnt@hsp=180
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5
target=cnt@hsp
if@hsp objtimek.cnt@hsp\30=1:gosub@hsp *endanmak
target=0
}
}
if@hsp objtimek.cnt@hsp<=650&objtimek.cnt@hsp>=150{
if@hsp objtimek.cnt@hsp<=150+20*25&objtimek.cnt@hsp>=150{
eh2.cnt@hsp=0
txv.cnt@hsp=0 : tyv.cnt@hsp=0
target=cnt@hsp
if@hsp objtimek.cnt@hsp\25=1:gosub@hsp *danmak2
target=0
}
}
if@hsp objtimek.cnt@hsp<=700&objtimek.cnt@hsp>=650{
if@hsp objtimek.cnt@hsp<=650+20*25&objtimek.cnt@hsp>=650{
eh2.cnt@hsp=0
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5
target=cnt@hsp
if@hsp objtimek.cnt@hsp\25=1:gosub@hsp *danmak2
target=0
target=cnt@hsp
if@hsp objtimek.cnt@hsp\30=1:gosub@hsp *endanmak
target=0
}
}
if@hsp objtimek.cnt@hsp>=700:objtimek.cnt@hsp=0	
}else@hsp{

objtimek.cnt@hsp+=1

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*64
gmode@hsp 2,64,64
gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0

hitchklenghx.cnt@hsp=20
hitchklenghy.cnt@hsp=20


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=9
gook=1
}
}
}

if@hsp ts.cnt@hsp=12{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2
gcopy@hsp 9,0,0,128,64

if@hsp objtimek.cnt@hsp=249{
dmplay 100,3
}
if@hsp objtimek.cnt@hsp<=850&objtimek.cnt@hsp>=100{
tx.cnt@hsp-=txv.cnt@hsp:ty.cnt@hsp-=tyv.cnt@hsp
}
if@hsp objtimek.cnt@hsp<=860&objtimek.cnt@hsp>=850{
eh2.cnt@hsp=180
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/2
}
if@hsp objtimek.cnt@hsp=860{
ds_play 10
}
if@hsp objtimek.cnt@hsp<=1000&objtimek.cnt@hsp>=860{
if@hsp objtimek.cnt@hsp<=1000+10*10&objtimek.cnt@hsp>=860{
tx.cnt@hsp-=txv.cnt@hsp:ty.cnt@hsp-=tyv.cnt@hsp
target=cnt@hsp
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *danmak4
target=0
}				
}
if@hsp objtimek.cnt@hsp<=1010&objtimek.cnt@hsp>=1000{
eh2.cnt@hsp=0
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/2
}
if@hsp objtimek.cnt@hsp<=300&objtimek.cnt@hsp>=250{
if@hsp objtimek.cnt@hsp<=250+4*6&objtimek.cnt@hsp>=250{
target=cnt@hsp
if@hsp objtimek.cnt@hsp\6=0:gosub@hsp *endanmak
target=0
}
}
if@hsp objtimek.cnt@hsp<=400&objtimek.cnt@hsp>=300{
if@hsp objtimek.cnt@hsp<=400+20*10&objtimek.cnt@hsp>=300{
target=cnt@hsp
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *danmak2
target=0
}
}
if@hsp objtimek.cnt@hsp<=500&objtimek.cnt@hsp>=400{
if@hsp objtimek.cnt@hsp<=500+10*10&objtimek.cnt@hsp>=400{
target=cnt@hsp
ds_play 10
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *danmak4
target=0
}
}
if@hsp objtimek.cnt@hsp<=750&objtimek.cnt@hsp>=550{
if@hsp objtimek.cnt@hsp<=750+20*10&objtimek.cnt@hsp>=550{
target=cnt@hsp:spd=5:type=0			
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *uzudanmak
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp<=850&objtimek.cnt@hsp>=750{
if@hsp objtimek.cnt@hsp<=850+10*5&objtimek.cnt@hsp>=750{
target=cnt@hsp:spd=2:type=1			
if@hsp objtimek.cnt@hsp\5=0:gosub@hsp *uzudanmak
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp>=1010:objtimek.cnt@hsp=250
}else@hsp{
objtimek.cnt@hsp+=1

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000

eh2.cnt@hsp=90
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*64
gmode@hsp 2,64,64
gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-4,ty2.cnt@hsp-4:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-20,ty2.cnt@hsp-4:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp+30,ty2.cnt@hsp-40:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-10,ty2.cnt@hsp+20:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0

hitchklenghx.cnt@hsp=20
hitchklenghy.cnt@hsp=20


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=9
gook=1
}
}
}






if@hsp ts.cnt@hsp=2|ts.cnt@hsp=7|ts.cnt@hsp=10|ts.cnt@hsp=13{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2
if@hsp ts.cnt@hsp=2:gcopy@hsp 5,2,0,14,14
if@hsp ts.cnt@hsp=7:gcopy@hsp 5,2,14,13,13
if@hsp ts.cnt@hsp=10:gcopy@hsp 5,2,62,13,13
if@hsp ts.cnt@hsp=13{
gcopy@hsp 5,2,61,13,13
if@hsp objtimek.cnt@hsp<=60&objtimek.cnt@hsp>=50{
target=cnt@hsp

kyorx=tx2.target-mx
kyory=ty2.target-my
if@hsp tx2.target>mx:hantenx=1:else@hsp:hantenx=0
if@hsp ty2.target>my:hanteny=1:else@hsp:hanteny=0


kyory=abs@hsp(kyory)
kyorx=abs@hsp(kyorx)
if@hsp kyorx=0 :kyorx+=1
if@hsp kyory=0 :kyory+=1


zahyo=double@hsp(kyory)/double@hsp(kyorx)
a=atan@hsp(zahyo)
b=a*180/3.1415926535897932384626433832795
b=int@hsp(b)

if@hsp hantenx=1:b=180-b
if@hsp hanteny=1:b=360-b
if@hsp b>=360:b=2
if@hsp b<=0:b=2

eh2.cnt@hsp=b
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/2

}
}
}else@hsp{
objtimek.cnt@hsp+=1

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000

txv.cnt@hsp=0:tyv.cnt@hsp=0

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*13
if@hsp objtimek2.cnt@hsp>2{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
tf.cnt@hsp=0:ts.cnt@hsp=0:dis.cnt@hsp=0
txv.cnt@hsp=0
tyv.cnt@hsp=0

}
gmode@hsp 2
if@hsp ts.cnt@hsp=2:gcopy@hsp 5,15+objtimek3.cnt@hsp,0,13,13
if@hsp ts.cnt@hsp=7:gcopy@hsp 5,15+objtimek3.cnt@hsp,14,13,13
if@hsp ts.cnt@hsp=10:gcopy@hsp 5,15+objtimek3.cnt@hsp,14,13,13
if@hsp ts.cnt@hsp=13:gcopy@hsp 5,15+objtimek3.cnt@hsp,62,13,13
}
}





if@hsp ts.cnt@hsp=3{
objtimek.cnt@hsp+=1

gmode@hsp 5,,,255
d3setcamx  0, 0, 450, 0, 0, 0
d3particle 1,-ty2.cnt@hsp+220,-tx2.cnt@hsp+220,0,10

if@hsp objtimek.cnt@hsp=50{
mx=150:my=350
mutekif=2
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
tf.cnt@hsp=0:ts.cnt@hsp=0
txv.cnt@hsp=0
tyv.cnt@hsp=0
}
}



if@hsp ts.cnt@hsp=8{
objtimek.cnt@hsp+=1

gmode@hsp 5,,,150
d3setcamx  0, 0, 450, 0, 0, 0
d3particle 1,-ty2.cnt@hsp+220,-tx2.cnt@hsp+220,0,4
gmode@hsp 2,,

if@hsp objtimek.cnt@hsp=20{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
tf.cnt@hsp=0:ts.cnt@hsp=0
txv.cnt@hsp=0
tyv.cnt@hsp=0
}
}



if@hsp ts.cnt@hsp=15{
objtimek.cnt@hsp+=1

gmode@hsp 5,,,150
d3setcamx  0, 0, 450, 0, 0, 0
d3particle 2,-ty2.cnt@hsp+220,-tx2.cnt@hsp+220,0,10
gmode@hsp 2,,

if@hsp objtimek.cnt@hsp=10{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
tf.cnt@hsp=0:ts.cnt@hsp=0
txv.cnt@hsp=0
tyv.cnt@hsp=0
}
}



if@hsp ts.cnt@hsp=11{
objtimek.cnt@hsp+=1

color@hsp 0,0,0
gmode@hsp 4,,,100
gcopy@hsp 8,0,229,69,34
gmode@hsp 2,,

}





if@hsp ts.cnt@hsp=4{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,12,18
gcopy@hsp 5,54,0,12,18
if@hsp objtimek.cnt@hsp<=10&objtimek.cnt@hsp>=1{
eh2.cnt@hsp=270
txv.cnt@hsp=cosa(eh2.cnt@hsp)/objtimek.cnt@hsp
tyv.cnt@hsp=sina(eh2.cnt@hsp)/objtimek.cnt@hsp
}
if@hsp objtimek.cnt@hsp>11{
eh2.cnt@hsp=90
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/2
}

}else@hsp{

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000

objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0
}
}

loop@hsp

repeat@hsp maxdansu
if@hsp shotf.cnt@hsp<1 :continue@hsp						
if@hsp shotf.cnt@hsp=1{
shoty.cnt@hsp+=shotyv.cnt@hsp
shotx.cnt@hsp+=shotxv.cnt@hsp
shotx2.cnt@hsp=shotx.cnt@hsp/1000
shoty2.cnt@hsp=shoty.cnt@hsp/1000
shotcx.cnt@hsp=shotx2.cnt@hsp+1
shotcy.cnt@hsp=shoty2.cnt@hsp+11

pos@hsp shotx2.cnt@hsp,shoty2.cnt@hsp
gmode@hsp 2,2,22:gcopy@hsp 5,0,0,2,22

if@hsp (shotx2.cnt@hsp>355)|(shotx2.cnt@hsp<-50)|(shoty2.cnt@hsp<-50)|(shoty2.cnt@hsp>500) {
shotf.cnt@hsp=0
continue@hsp
}
if@hsp shotdis.cnt@hsp=1{
shotf.cnt@hsp=0
shotdis.cnt@hsp=0
shotx2.cnt@hsp=0
shoty2.cnt@hsp=0
shotcx.cnt@hsp=0
shotcy.cnt@hsp=0
}
}

if@hsp shotf.cnt@hsp=2{
shottimek.cnt@hsp+=1
kaiten+=1
shoty.cnt@hsp+=shotyv.cnt@hsp
shotx.cnt@hsp+=shotxv.cnt@hsp
shotx2.cnt@hsp=shotx.cnt@hsp/1000
shoty2.cnt@hsp=shoty.cnt@hsp/1000
shotcx.cnt@hsp=shotx2.cnt@hsp+1
shotcy.cnt@hsp=shoty2.cnt@hsp+11

if@hsp shottimek.cnt@hsp<=10&shottimek.cnt@hsp>=0{

pos@hsp shotx2.cnt@hsp,shoty2.cnt@hsp
gmode@hsp 2,34,34:grotate@hsp 5,0,27,kaiten,34,34

}
if@hsp shottimek.cnt@hsp<=50&shottimek.cnt@hsp>=11{

shoty.cnt@hsp-=shotyv.cnt@hsp
shotx.cnt@hsp-=shotxv.cnt@hsp
pos@hsp shotx2.cnt@hsp,shoty2.cnt@hsp
gmode@hsp 2,34,34:grotate@hsp 5,0,27,kaiten,34,34
target=cnt@hsp
gosub@hsp *spark_on
target=0

}
if@hsp shottimek.cnt@hsp<=100&shottimek.cnt@hsp>=50{
repeat@hsp tmax
if@hsp tf.cnt@hsp<1:continue@hsp
if@hsp ts.cnt@hsp=1|ts.cnt@hsp=6|ts.cnt@hsp=5|ts.cnt@hsp=9|ts.cnt@hsp=12{
targets=cnt@hsp
break@hsp
}

loop@hsp




kyorx=shotx2.cnt@hsp-tx2.targets
kyory=shoty2.cnt@hsp-ty2.targets
if@hsp shotx2.cnt@hsp>tx2.targets:hantenx=1:else@hsp:hantenx=0
if@hsp shoty2.cnt@hsp>ty2.targets:hanteny=1:else@hsp:hanteny=0


kyory=abs@hsp(kyory)
kyorx=abs@hsp(kyorx)
if@hsp kyorx=0 :kyorx+=1
if@hsp kyory=0 :kyory+=1


zahyo=double@hsp(kyory)/double@hsp(kyorx)
a=atan@hsp(zahyo)
b=a*180/3.1415926535897932384626433832795
b=int@hsp(b)

if@hsp hantenx=1:b=180-b
if@hsp hanteny=1:b=360-b

if@hsp b>=360:b=2
if@hsp b<=0:b=2
eh3.cnt@hsp=b
shotxv.cnt@hsp=cosa(eh3.cnt@hsp)*sp : shotyv.cnt@hsp=sina(eh3.cnt@hsp)*sp

pos@hsp shotx2.cnt@hsp,shoty2.cnt@hsp
gmode@hsp 2,34,34:grotate@hsp 5,0,27,kaiten,34,34
target=cnt@hsp
gosub@hsp *spark_on
target=0
}
if@hsp shottimek.cnt@hsp>=100{
pos@hsp shotx2.cnt@hsp,shoty2.cnt@hsp
gmode@hsp 2,34,34:grotate@hsp 5,0,27,kaiten,34,34
}
if@hsp (shotx2.cnt@hsp>440)|(shotx2.cnt@hsp<-150)|(shoty2.cnt@hsp<-150)|(shoty2.cnt@hsp>550) {
shotf.cnt@hsp=0
shotdis.cnt@hsp=0
shotx2.cnt@hsp=0
shoty2.cnt@hsp=0
shotcx.cnt@hsp=0
shotcy.cnt@hsp=0
shotxv.cnt@hsp=0 : shotyv.cnt@hsp=0
eh3.cnt@hsp=0
continue@hsp
}
}
loop@hsp


return@hsp
*hitchk

if@hsp mutekif=1:return@hsp
yhit=0:xhit=0
ykasuri=0:xkasuri=0

repeat@hsp tmax
if@hsp tf.cnt@hsp<1:continue@hsp
if@hsp ts.cnt@hsp=3:continue@hsp

yhit=0:xhit=0
ykasuri=0:xkasuri=0

if@hsp drawhantei=1{
color@hsp 255,0,0
boxf@hsp tcx.cnt@hsp,tcy.cnt@hsp,tcx.cnt@hsp+hitchklenghx.cnt@hsp,tcy.cnt@hsp+hitchklenghy.cnt@hsp
boxf@hsp tcx.cnt@hsp,tcy.cnt@hsp,tcx.cnt@hsp+hitchklenghx.cnt@hsp,tcy.cnt@hsp-hitchklenghy.cnt@hsp
boxf@hsp tcx.cnt@hsp,tcy.cnt@hsp,tcx.cnt@hsp-hitchklenghx.cnt@hsp,tcy.cnt@hsp+hitchklenghy.cnt@hsp
boxf@hsp tcx.cnt@hsp,tcy.cnt@hsp,tcx.cnt@hsp-hitchklenghx.cnt@hsp,tcy.cnt@hsp+hitchklenghy.cnt@hsp
}



kyoriy=tcy.cnt@hsp-mycharcentery
kyorix=tcx.cnt@hsp-mycharcenterx

kyoriy=abs@hsp(kyoriy)
kyorix=abs@hsp(kyorix)

if@hsp kyoriy<mycharuppery+hitchklenghy.cnt@hsp:yhit=1
if@hsp kyorix<mycharrightx+hitchklenghx.cnt@hsp:xhit=1
if@hsp kyoriy<kasury+hitchklenghy.cnt@hsp:ykasuri=1
if@hsp kyorix<kasurx+hitchklenghx.cnt@hsp:xkasuri=1

if@hsp ykasuri+xkasuri=2{
if@hsp ts.cnt@hsp=2|ts.cnt@hsp=7|ts.cnt@hsp=10|ts.cnt@hsp=13{
score+=1:kasurikaunter+=1
gosub@hsp *kasuri_on
}
}

if@hsp yhit+xhit=2{

if@hsp ts.cnt@hsp=1|ts.cnt@hsp=5|ts.cnt@hsp=6|ts.cnt@hsp=9{
if@hsp mutekif>=2:break@hsp
dis.cnt@hsp=1		
gosub@hsp *mycharhit	
}
if@hsp ts.cnt@hsp=2|ts.cnt@hsp=7|ts.cnt@hsp=10|ts.cnt@hsp=13{
if@hsp mutekif>=2:break@hsp
gosub@hsp *mycharhit	
}
if@hsp ts.cnt@hsp=4{			
shotpower+=1:score+=100
dis.cnt@hsp=1:ds_play 5
}	
}

if@hsp ts.cnt@hsp=1|ts.cnt@hsp=5|ts.cnt@hsp=6|ts.cnt@hsp=9|ts.cnt@hsp=12{
target=cnt@hsp
repeat@hsp maxdansu

if@hsp shotf.cnt@hsp<1:continue@hsp

yhit2=0:xhit2=0

kyoriy2=tcy.target-shotcy.cnt@hsp
kyorix2=tcx.target-shotcx.cnt@hsp

kyoriy2=abs@hsp(kyoriy2)
kyorix2=abs@hsp(kyorix2)

if@hsp kyoriy2<shothity+hitchklenghy.target:yhit2=1
if@hsp kyorix2<shothitx+hitchklenghx.target:xhit2=1

if@hsp yhit2+xhit2=2{

if@hsp ts.target=1|ts.target=5|ts.target=9{

hitchklenghx.target=-1000
hitchklenghy.target=-1000


tcplusx.target=-1000
tcplusy.target=-1000

ds_play 2 
score+=100
dis.target=1:shotdis.cnt@hsp=1
}

if@hsp ts.target=6{
score+=100:shotdis.cnt@hsp=1
chp-=1:ds_play 2
pos@hsp tx2.target-4,ty2.target-4
gcopy@hsp 7,63,0,64,64

if@hsp chp<=0:dis.target=1
}
if@hsp ts.target=12{
score+=100:shotdis.cnt@hsp=1
bhp-=1
ds_play 2

gosub@hsp *damage_on


if@hsp bhp<=0:dis.target=1:gosub@hsp *bosshit
}
}
loop@hsp	
}
loop@hsp



return@hsp
*mycharhit

ds_play 3

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 :continue@hsp							
eh+
eh2.cnt@hsp=(eh-1)*10+(pt*5) : if@hsp eh2>359 : eh2-=360	
tf.cnt@hsp=1										
ts.cnt@hsp=3


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

tc.cnt@hsp=255										
tx.cnt@hsp=(mx+20)*1000 :ty.cnt@hsp=my*1000				
txv.cnt@hsp=cosa(eh2.cnt@hsp)/3 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/3	
if@hsp eh=36 : eh=0 : break@hsp							
loop@hsp

life-=1
mx=-1000:my=-1000
mutekif=1

repeat@hsp tmax
if@hsp tf.cnt@hsp<1:continue@hsp
if@hsp ts.cnt@hsp=2|ts.cnt@hsp=7|ts.cnt@hsp=10|ts.cnt@hsp=13|dis.cnt@hsp=1
loop@hsp

if@hsp life<=0:goto@hsp *gameov

return@hsp
*kasuri_on
yobareta3+=1
if@hsp yobareta3>=10:yobareta3=0
if@hsp yobareta3>=2:return@hsp

ds_play 6

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 :continue@hsp							
eh+
rand=rnd@hsp(360)
eh2.cnt@hsp=rand : if@hsp eh2>359 : eh2-=360	
tf.cnt@hsp=1										
ts.cnt@hsp=8


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

tc.cnt@hsp=255										
tx.cnt@hsp=(mx+20)*1000 :ty.cnt@hsp=my*1000				
txv.cnt@hsp=cosa(eh2.cnt@hsp)/3 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/3	
if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

return@hsp
*spark_on

yobareta+=1
if@hsp yobareta>=10:yobareta=0
if@hsp yobareta>=2:return@hsp

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 :continue@hsp							
eh+
rand=rnd@hsp(360)
eh2.cnt@hsp=rand : if@hsp eh2>359 : eh2-=360	
tf.cnt@hsp=1										
ts.cnt@hsp=8


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

tc.cnt@hsp=255										
tx.cnt@hsp=(shotx2.target+20)*1000 :ty.cnt@hsp=shoty2.target*1000				
txv.cnt@hsp=cosa(eh2.cnt@hsp)/3 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/3	
if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp



return@hsp
*damage_on

yobareta2+=1
if@hsp yobareta2>=5:yobareta2=0
if@hsp yobareta2>=2:return@hsp

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 :continue@hsp							
eh+
rand=rnd@hsp(360)
eh2.cnt@hsp=rand : if@hsp eh2>359 : eh2-=360	
tf.cnt@hsp=1										
ts.cnt@hsp=15


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

tc.cnt@hsp=255										
tx.cnt@hsp=(tcx.target)*1000 :ty.cnt@hsp=tcy.target*1000				
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/2	
if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp



return@hsp
*bosshit


repeat@hsp tmax
if@hsp tf.cnt@hsp>0 :continue@hsp							
eh+
eh2.cnt@hsp=(eh-1)*10+(pt*5) : if@hsp eh2>359 : eh2-=360	
tf.cnt@hsp=1										
ts.cnt@hsp=3


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

tc.cnt@hsp=255										
tx.cnt@hsp=(tcx.target+20)*1000 :ty.cnt@hsp=tcy.target*1000				
txv.cnt@hsp=cosa(eh2.cnt@hsp)/3 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/3	
if@hsp eh=36 : eh=0 : break@hsp							
loop@hsp


repeat@hsp tmax
if@hsp tf.cnt@hsp<1:continue@hsp
if@hsp ts.cnt@hsp=2|ts.cnt@hsp=7|ts.cnt@hsp=10|ts.cnt@hsp=13|dis.cnt@hsp=1
loop@hsp


return@hsp
*sleeping

noteget@hsp par,1
par=int@hsp(par)

if@hsp kauntpar>=par{
kauntpar=0:turn+=1
}

kauntpar+=1
return@hsp
*teisi

if@hsp gook=1:turn+=1:gook=0
return@hsp
*disall
repeat@hsp tmax
if@hsp tf.cnt@hsp<1:continue@hsp
if@hsp ts.cnt@hsp=2|ts.cnt@hsp=7|ts.cnt@hsp=10|ts.cnt@hsp=13{

tf.cnt@hsp=0 
ts.cnt@hsp=0
dis.cnt@hsp=0


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000
}


loop@hsp

return@hsp
*gameov
cls@hsp 
color@hsp 0,0,0
mes@hsp "ゲームおーばー"

if@hsp replayf=1:button@hsp "戻る",*top:stop@hsp
mes@hsp "リプレイを保存しますか？"
button@hsp "ＯＫ",*ok:button@hsp "NO",*no

stop@hsp
*ok
mes@hsp "リプレイの名前を入れてください"
input@hsp replayname:button@hsp "保存",*hozon
stop@hsp
*hozon
objprm@hsp 3,replayname
dialog@hsp replayname
bsave@hsp "replay/"+replayname+".rep",replay
*no
end@hsp
*replayload
cls@hsp
color@hsp 0,0,0

dirlist@hsp clent,"replay/*.rep"
notesel@hsp clent
repeat@hsp  noteinfo@hsp(0)

noteget@hsp filename.cnt@hsp,cnt@hsp
mes@hsp filename.cnt@hsp

loop@hsp

objsize@hsp 100,32:combox@hsp choice,,clent
button@hsp "ロードする",*replayload2
stop@hsp
*replayload2
bload@hsp "replay/"+filename.choice,replay

replayf=1
goto@hsp *stagestart2
*endo
end@hsp
