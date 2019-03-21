# lines displayed by l / list
set listsize 20

# my prompt
set prompt gdb> 

# save entered comands
set history save on

# expansion
set history expansion on

# turn off the annoying confirm dialogs
set confirm off

# notify me if inferior start, exit or detach (usfull for debuging multiple programs)
set print inferior-events on
set print pretty on
#set follow-fork-mode child

set disassembly-flavor intel

# somewhat automatic store/restore of breakpoints
define save_breakpoints
    save breakpoints breakpoints.gdb
end

define load_breakpoints
    source breakpoints.gdb
end

source ~/.dotfiles/peda/peda.py
