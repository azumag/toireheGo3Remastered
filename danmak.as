	screen 0,320,320,1,300,200
	cls 4
	title "弾幕サンプル"
;三角関数テーブル作成-------------------------------------------------
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
	font "ＭＳ　ゴシック",16
;--------弾の配列を確保--------------
	tmax=1000		;弾最大数
	dim tx,tmax	;x座標 (1000倍で計算・固定小数点数）
	dim ty,tmax	;y座標 (1000倍
	dim tf,tmax	;フラグ
	dim txv,tmax	;移動量x
	dim tyv,tmax	;移動量y
	dim tx2,tmax	;x座標（表示用・実際の座標）
	dim ty2,tmax	;y座標（表示用・実際の座標)
	dim tc,tmax	;色
;-------メインルーチン--------
*main
	time+			;フレーム数
	redraw 2
	color 0,0,0 : boxf
	shot=0
	getkey k,1 : if k=1 : tama=0 : shot=1		;左クリックで円弾幕
	getkey k,2 : if k=1 : tama=1 : shot=1		;右クリックで渦弾幕
	gosub *bborn				;弾発生
	gosub *bmove				;弾移動
	redraw 1
	await 16
goto *main
;----------弾発生-----------
*bborn
	if shot=1 {
		if (tama=0)&(time\15=0) :pt+ : pt=pt\2: gosub *bullet0
		if (tama=1)&(time\5=0) :gosub *bullet1
	}
return
;--------弾0・36方向・円弾幕--------------
*bullet0	
	repeat tmax
		if tf.cnt>0 :continue				;空きフラグを探す
		eh+
		eh2=(eh-1)*10+(pt*5) : if eh2>359 : eh2-=360	;発射角度を求める
		tf.cnt=1					;フラグオン
		tc.cnt=255				;色
		tx.cnt=mousex*1000 :ty.cnt=mousey*1000	;カーソルの位置に弾発生(1000倍）
		txv.cnt=cos.eh2/10 : tyv.cnt=sin.eh2/10	;移動方向
		if eh=36 : eh=0 : break			;36発発射してループを抜ける
	loop
return
;--------弾1・360方向・渦弾幕---------------
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
;--------------弾移動---------------------
*bmove
	repeat tmax
		if tf.cnt<1 :continue				;存在する弾だけ
		tx.cnt+=txv.cnt : ty.cnt+=tyv.cnt			;移動処理
		tx2.cnt=tx.cnt/1000 : ty2.cnt=ty.cnt/1000		;表示用座標を求める
		
		if (tx2.cnt>328)|(tx2.cnt<-8)|(ty2.cnt<-8)|(ty2.cnt>328) {
			tf.cnt=0 :continue
		}						;画面外なら消す
		
		tc.cnt- : if tc.cnt<0 : tc.cnt=0			;色を暗くする
		color tc.cnt,tc.cnt,tc.cnt
		pos tx2.cnt-4,ty2.cnt-4 : mes "*"			;表示
	loop
return