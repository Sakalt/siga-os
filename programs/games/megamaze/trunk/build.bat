@echo lang fix en_US >lang.inc
@fasm -m 16384 megamaze.asm megamaze
@erase lang.inc
@kpack megamaze
@pause
