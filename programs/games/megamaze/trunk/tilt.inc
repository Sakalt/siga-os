; Language support for locales: ru_RU (CP866), en_US.

TILT_levelp:
    call SMZ_levelp
    mov  esi,[stepptr]
    movzx ecx,byte[esi]
    mov  [finish],ecx
    inc  ecx
    mov  edi,area
    rep  movsb
    mov  [pause_time],10
    ret

TILT_key:
    cmp  eax,176
    jb   .ex
    cmp  eax,179
    ja   .ex
    mov  esi,area
    inc  esi
    lea  ebx,[eax-176]
    mov  eax,[player]
  .lp:
    call check_move
    jc   .ex1
    add  eax,[dirs+ebx*4]
    movzx ecx,byte[esi-1]
    mov  edi,esi
    repne scasb
    jne  .notfound
    mov  byte[edi-1],0xff
    dec  dword[finish]
  .notfound:
    mov  [player],eax
    call delay
    call drwfld
    jmp  .lp
  .ex1:
    cmp  dword[finish],0
    jnz  .ex
    mov  [win_flag],1
  .ex:
    ret

TILT_drawm:
    mov  eax,[player]
    call get_xy
    mcall 13,[lx],[ly],0xff00
    cmp  [win_flag],1
    je   .ex
    mov  edi,area
    movzx ecx,byte[edi]
    jecxz .ex
    inc  edi
  .lp:
    push ecx
    movzx eax,byte[edi]
    cmp  eax,0xff
    je   .no
    call get_xy
    mcall 13,[lx],[ly],0xff0000
  .no:
    pop  ecx
    inc  edi
    loop .lp
  .ex:
    ret

TILT_level:
file 'tilt.bin'

if lang eq ru_RU
        TILT_help mstr \
        '���誠 (������ ������) ����� �� ��᪥, ������',\
        '����� ��������� �� ��ਧ��⠫� � ���⨪���',\
        ' ��᫥ ������� ���誠 ᪮�짨�, ���� �� ��⪭����',\
        '�� �⥭��. ����� ��⠭����� ����� �� �।���',\
        '���.',\
        ' ��� ����� - ���⠢��� ����� ������ ���⪨',\
        '� ���묨 �����⠬�.','',\
        'http://www.clickmazes.com'
else ; Default to en_US
        TILT_help mstr \
        'You are to imagine that a marble (shown here as a',\
        'green square) is on a board that you can tilt',\
        'only to the north, south, east, or west. (You',\
        "can't do anything tricky like tilt it southeast.)",\
        '  Once you tilt the board, the marble will roll',\
        '(horizontally or vertically) until it hits a',\
        "barrier. There's no way you can stop the marble",\
        'in the middle of its roll.',\
        '  The object is to roll the marble onto or over',\
        'every red square in the maze.','',\
        'http://www.clickmazes.com'
end if
