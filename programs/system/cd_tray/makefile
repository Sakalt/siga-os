#!gmake

# Macro
FASM=/opt/bin/fasm
KPACK=/opt/bin/kpack
LANG=lang.inc
FILE=CD_tray
SOURCE=${FILE}.ASM
OUT=${FILE}.bin

en:
	echo "lang fix en_US" > ${LANG}
	${FASM} ${SOURCE} ${OUT}
it:
	echo "lang fix it_IT" > ${LANG}
	${FASM} ${SOURCE} ${OUT}

clean:
	rm -f ${LANG} ${OUT}
