if tup.getconfig("NO_CMM") ~= "" then return end
if tup.getconfig("LANG") == "ru_RU"
then C_LANG = "LANG_RUS"
else C_LANG = "LANG_ENG" -- this includes default case without config
end
tup.rule("imgedit.c", "c-- /OPATH=%o %f" .. tup.getconfig("KPACK_CMD"), "imgedit.com")
