	screen 0,320,320,1,300,200
	cls 4
	title "�e���T���v��"
;�O�p�֐��e�[�u���쐬-------------------------------------------------
	dim sin,360 : dim cos,360	
	cos.0=10000 : sin.0=0
	cos.1=9999 : sin.1=175
	
	repeat 358,1
		ent=cnt+1
		cos.ent=((cos.1*cos.cnt)-(sin.1*sin.cnt))/10000
		sin.ent=((sin.1*cos.cnt)+(cos.1*sin.cnt))/10000
	loop
;----------------------------------------------------------------------
	color 255,255,255
	font "�l�r�@�S�V�b�N",16
;--------�e�̔z����m��--------------
	tmax=1000		;�e�ő吔
	dim tx,tmax	;x���W (1000�{�Ōv�Z�E�Œ菬���_���j
	dim ty,tmax	;y���W (1000�{
	dim tf,tmax	;�t���O
	dim txv,tmax	;�ړ���x
	dim tyv,tmax	;�ړ���y
	dim tx2,tmax	;x���W�i�\���p�E���ۂ̍��W�j
	dim ty2,tmax	;y���W�i�\���p�E���ۂ̍��W)
	dim tc,tmax	;�F
;-------���C�����[�`��--------
*main
	time+			;�t���[����
	redraw 2
	color 0,0,0 : boxf
	shot=0
	getkey k,1 : if k=1 : tama=0 : shot=1		;���N���b�N�ŉ~�e��
	getkey k,2 : if k=1 : tama=1 : shot=1		;�E�N���b�N�ŉQ�e��
	gosub *bborn				;�e����
	gosub *bmove				;�e�ړ�
	redraw 1
	await 16
goto *main
;----------�e����-----------
*bborn
	if shot=1 {
		if (tama=0)&(time\15=0) :pt+ : pt=pt\2: gosub *bullet0
		if (tama=1)&(time\5=0) :gosub *bullet1
	}
return
;--------�e0�E36�����E�~�e��--------------
*bullet0	
	repeat tmax
		if tf.cnt>0 :continue				;�󂫃t���O��T��
		eh+
		eh2=(eh-1)*10+(pt*5) : if eh2>359 : eh2-=360	;���ˊp�x�����߂�
		tf.cnt=1					;�t���O�I��
		tc.cnt=255				;�F
		tx.cnt=mousex*1000 :ty.cnt=mousey*1000	;�J�[�\���̈ʒu�ɒe����(1000�{�j
		txv.cnt=cos.eh2/10 : tyv.cnt=sin.eh2/10	;�ړ�����
		if eh=36 : eh=0 : break			;36�����˂��ă��[�v�𔲂���
	loop
return
;--------�e1�E360�����E�Q�e��---------------
*bullet1		
	repeat tmax
		if tf.cnt>0 :continue
		eh+
		eh2=(eh-1)*30+(time\60) : if eh2>359 : eh2-=360
		tf.cnt=1
		tc.cnt=255
		tx.cnt=mousex*1000 : ty.cnt=mousey*1000
		txv.cnt=cos.eh2/10 : tyv.cnt=sin.eh2/10
		if eh=12 : eh=0 : break
	loop
return
;--------------�e�ړ�---------------------
*bmove
	repeat tmax
		if tf.cnt<1 :continue				;���݂���e����
		tx.cnt+=txv.cnt : ty.cnt+=tyv.cnt			;�ړ�����
		tx2.cnt=tx.cnt/1000 : ty2.cnt=ty.cnt/1000		;�\���p���W�����߂�
		
		if (tx2.cnt>328)|(tx2.cnt<-8)|(ty2.cnt<-8)|(ty2.cnt>328) {
			tf.cnt=0 :continue
		}						;��ʊO�Ȃ����
		
		tc.cnt- : if tc.cnt<0 : tc.cnt=0			;�F���Â�����
		color tc.cnt,tc.cnt,tc.cnt
		pos tx2.cnt-4,ty2.cnt-4 : mes "*"			;�\��
	loop
return