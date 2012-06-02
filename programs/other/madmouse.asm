;
;   Mad Mouse
;   ���� �⮣� 㦠᭮ ��६���� ����: Sourcerer, 23.04.2010
;   popovpa (29.05.2012)
;   1. ��������� ������ ࠡ��� �ணࠬ��.
;   2. ��������� "���᪠�������" ᢥ��� � ���� :)
;   3. ��⨬����� ����.
;

use32	       ; �࠭����, �ᯮ����騩 32-� ࠧ�來� �������
org   0x0 ; ������ ���� ����, �ᥣ�� 0x0

  db 'MENUET01' 	; 1. �����䨪��� �ᯮ��塞��� 䠩�� (8 ����)
  dd 0x01		; 2. ����� �ଠ� ��������� �ᯮ��塞��� 䠩��
  dd START		; 3. ����, �� ����� ��⥬� ��।��� �ࠢ�����
			; ��᫥ ����㧪� �ਫ������ � ������
  dd I_END		; 4. ࠧ��� �ਫ������
  dd 0x100000		; 5. ���� ����室���� �ਫ������ �����
			; ����� �������� � ����� � ��������� �� 0x0
			; �� ���祭��, ��।��񭭮�� �����
  dd 0x100000		; 6. ���設� �⥪� � ��������� �����, 㪠������ ���
  dd 0x0		; 7. 㪠��⥫� �� ��ப� � ��ࠬ��ࠬ�.
			; �᫨ ��᫥ ����᪠ ��ࠢ�� ���, �ਫ������ �뫮
			; ����饭� � ��ࠬ��ࠬ� �� ��������� ��ப�
  dd 0x0		; 8. 㪠��⥫� �� ��ப�, � ������ ����ᠭ ����,
			; ��㤠 ����饭� �ਫ������


;---------------------------------------------------------------------
;---  ������ ���������  ----------------------------------------------
;---------------------------------------------------------------------

START:						;���� ��砫� �ணࠬ��

	mov	   eax,14			;�㭪�� 14 - ������� ࠧ��� ��࠭�
	int	   0x40

	mov	   ebx,eax
	shl	   ebx,16
	shr	   ebx,16
	mov	   edi,ebx			;��࠭�� �
	shr	   eax,16			;ᤢ����� eax ��ࠢ� �� 16 - ����砥� x
	mov	   esi,eax			;��࠭�� x

;---------------------------------------------------------------------
;---  ���� ��������� �������  ----------------------------------------
;---------------------------------------------------------------------

still:
;�࣠���㥬 ���� � 100 ��
	mov	   eax,5			;�㭪�� 5 - ��㧠, � ebx �६� � ��
	mov	   ebx,1			;����প� 100 ��
	int	   0x40
;����砥� ���न���� �����
	mov	   eax,37			;�㭪�� 37 - ࠡ�� � �����
	xor	   ebx,ebx			;������� 0 - ���न���� ���
						;�⭮�⥫쭮 ��࠭�
	int	   0x40

	mov	   ebx,eax			;���������� ���न����
	shr	   eax,16			;⥯��� � ��� ⮫쪮 x. �㦥� � y
	mov	   ecx,eax			;���������� x
	shl	   ebx,16			;ᤢ���� ���� �� 16
	shr	   ebx,16			;ᤢ����� �ࠢ� �� 16, � ��� ���� �

;------------------------------------------------------------------------------
;� esi � edi ���न���� ࠧ��� ��࠭� X � Y ᮮ⢥�ᢥ���
;� ecx � ebx ���न���� ����� X � Y ᮮ⢥⢥���
;------------------------------------------------------------------------------

;�ࠢ����� ���न��� x
	test	   ecx,ecx			;ࠢ�� 0?
	jz	   left_border			;���室 � ��ࠡ�⪥ � ������ ���

	cmp	   ecx,esi			;ࠢ�� �ਭ� ��࠭�?
	jz	   right_border 		;���室�� � ��ࠡ�⪥ � �ࠢ��� ���
;�ࠢ����� ���न��� y
	test	   ebx,ebx			;ࠢ�� 0?
	jz	   top_border			;�᫨ �� ����� ����� ������

	cmp	   ebx,edi			;ࠢ�� ���� ��࠭�?
	jz	   bottom_border		;���室 � ��ࠡ�⪥ � ������� ���

	jmp	   still			;���� ��祣� ������ �� �㦭�

left_border:
	mov	   edx,esi			;� edx ����� �ਭ� ��࠭�
	dec	   edx				;㬥��訬 �� 1
	shl	   edx,16			;⥯��� edx=(x-1)*65536
	add	   edx,ebx			;� ⥯��� edx=(x-1)*65536+y

	mov	   eax,18			;�㭪�� 18: ��⠭����� ����ன�� ���
	mov	   ebx,19			;����㭪�� 19
	mov	   ecx,4			;�������㭪�� 4: ��⠭����� ���������
						;�����
	int	   0x40
jmp still					;���堥�

right_border:					;����� � �ࠢ��� ���

	xor	   edx,edx
	inc	   edx				;edx=1
	shl	   edx,16			;edx = 1*65536
	add	   edx,ebx			;edx=1*65536+y

	mov	   eax,18			;�㭪�� 18: ��⠭����� ����ன�� ���
	mov	   ebx,19			;����㭪�� 19
	mov	   ecx,4			;�������㭪�� 4: ��⠭����� ���������
						;�����
	int	   0x40
jmp still					;���堥�

top_border:					;����� � ���孥�� ���

	mov	   edx,ecx			;� ���न��� �����
	shl	   edx,16			;⥯��� edx=(x)*65536
	add	   edx,edi			;� ⥯��� edx=(x)*65536+y
	dec	   edx				;� ⥯��� edx=(x)*65536+(�-1)

	mov	   eax,18			;�㭪�� 18: ��⠭����� ����ன�� ���
	mov	   ebx,19			;����㭪�� 19
	mov	   ecx,4			;�������㭪�� 4: ��⠭����� ���������
						;�����
	int	   0x40
jmp still					;� ���堥�

bottom_border:					;����� � ������� ���

	mov	   edx,ecx			;edx=ecx x ���न��� �����
	shl	   edx,16			;edx = �*65536
						;� ���न��� ࠢ�� 0
	mov	   eax,18			;�㭪�� 18: ��⠭����� ����ன�� ���
	mov	   ebx,19			;����㭪�� 19
	mov	   ecx,4			;�������㭪�� 4: ��⠭����� ���������
						;�����
	int	   0x40
jmp still					;� ���堥�


I_END:						; ��⪠ ���� �ணࠬ��