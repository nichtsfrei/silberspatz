# Ensure GNU nvim is set as EDITOR if it isn't already set

if ( ! ($?EDITOR) ) then
	setenv EDITOR "/usr/sbin/nvim"
endif
