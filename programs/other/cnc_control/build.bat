@echo lang fix ru_RU >lang.inc
@fasm.exe -m 16384 cnc_control.asm cnc_control
@erase lang.inc
@kpack cnc_control
@pause
