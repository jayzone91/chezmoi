vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.autoformat = true
vim.g.jayvim_picker = "auto"
vim.g.root_spec = { "lsp", {".git", "lua"}, "cwd"}
vim.g.jaygit_config = true
vim.g.jayvim_statuscolumn= {
	folds_open = false,
	 folds_githl = false, 
 }
 vim.g.deprecation_warnings = false
 vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB
 vim.g.trouble_lualine = true

vim.o.autoindent = true -- take indent for new line from previous line
vim.o.autoread = true -- autom. read file when changed outside of Vim
vim.o.background = "dark" -- "dark" or "light", used for highlight colors
vim.o.backspace = "indent,eol,start" -- how backspace works at start of line
vim.opt.clipboard:append("unnamedplus") -- use the clipboard as the unnamed register
vim.o.completeopt = "menu,menuone,noselect" -- options for Insert mode completion
vim.o.confirm = true -- Confirm to save changes before exiting modiefied buffer
vim.o.copyindent = true -- make "autoindent" use existing indent structure
vim.o.cursorline = true -- enable highlightinhg of the current line
vim.o.expandtab = true -- use spaces when <Tab> is inserted
vim.o.grepformat = "%f:%l:%c:%m" -- format of 'grepprg' output
vim.o.grepprg = "rg --vimgrep" -- program to use for ":grep"
vim.o.ignorecase = true -- ignore case in search patterns
vim.o.laststatus = 3 -- tells when last window has status lines: 0: never, 1: only if there are ar least two windows, 2: always, 3: always and ONLY the last window
vim.o.mouse = "a" -- enable the use of mouse clicks: n: normal mode, v: visual mode, i: insert mode, c: command-line mode, h: all previous when editing a help file, a: all previous modes, r: for hit_enter and more-prompt prompt
vim.o.number = true -- print the line number in front of each line
vim.o.pumblend = 10
vim.o.pumheight = 10 -- maximum number of items to show in the popup menu
vim.o.relativenumber = true -- show relative line number in front of each line
vim.o.scrolloff = 10 -- minimum nr. of lines above and below cursor
vim.o.shiftround = true -- round indent to multiple of shiftwidth
vim.o.shiftwidth = 2 -- number of spaces to use for (auto)indent step
vim.o.shortmess = "ltToOcCFW"
-- [[
-- list of flags, reduce length of messages
-- default "ltToOCF"
-- flag   meaning when present
-- l      use "999L, 888B" instead of "999 lines, 888 bytes"
-- m      use "[+]" instead of "[Modified]"
-- r      use "[RO]" instead of "[readonly]"
-- w      use "[w]" instead of "written" for file write message
--        and "[a]" instead of "appended" for ':w >> file' command
-- a      all of the above abbreviations
-- o      overwrite message for writing a file with subsequent
--        message for reading a file (useful for ":wn" or when
--        'autowrite' on)
-- O      message for reading a file overwrites any previous
--        message;  also for quickfix message (e.g., ":cn")
-- s      don't give "search hit BOTTOM, continuing at TOP" or
--        "search hit TOP, continuing at BOTTOM" messages; when using
--        the search count do not show "W" after the count message
--        (see S below)
-- t      truncate file message at the start if it is too long
--        to fit on the command-line, "<" will appear in the left most
--        column; ignored in Ex mode
-- T      truncate other messages in the middle if they are too
--        long to fit on the command line; "..." will appear in the
--        middle; ignored in Ex mode
-- W      don't give "written" or "[w]" when writing a file
-- A      don't give the "ATTENTION" message when an existing
--        swap file is found
-- I      don't give the intro message when starting Vim, see :intro
-- c      don't give ins-completion-menu messages; for
--        example, "-- XXX completion (YYY)", "match 1 of 2", "The only
--        match", "Pattern not found", "Back at original", etc.
-- C      don't give messages while scanning for ins-completion
--        items, for instance "scanning tags"
-- q      do not show "recording @a" when recording a macro
-- F      don't give the file info when editing a file, like
--        :silent was used for the command; note that this also
--        affects messages from 'autoread' reloading
-- S      do not show search count message when searching, e.g. "[1/5]"
-- ]]
vim.o.showmode = false -- message on status line to show current mode
vim.o.signcolumn = "yes"
-- [[
-- When and how to draw the signcolumn.
-- default: "auto"
-- Valid values are:
-- "auto"             only when there is a sign to display
-- "auto:[1-9]"       resize to accommodate multiple signs up to the
--                    given number (maximum 9), e.g. "auto:4"
-- "auto:[1-8]-[2-9]" resize to accommodate multiple signs up to the
--                    given maximum number (maximum 9) while keeping
--                    at least the given minimum (maximum 8) fixed
--                    space. The minimum number should always be less
--                    than the maximum number, e.g. "auto:2-5"
-- "no"               never
-- "yes"              always
-- "yes:[1-9]"        always, with fixed space for signs up to the given
--                    number (maximum 9), e.g. "yes:3"
-- "number"           display signs in the 'number' column. If the number
--                    column is not present, then behaves like "auto".
-- ]]
vim.o.smartcase = true -- no ignore case when pattern has uppercase
vim.o.splitbelow = true -- new window from split is below the current one
vim.o.splitkeep = "screen" -- determines scroll behavior for split windows. (default: "cursor") Values: cursor: Keep the same relative cursor position; screen: lepp the text on the same line; topliine: keep the topline the same
vim.o.splitright = true -- new window is put right of the current one
vim.o.tabstop = 2 -- number of spaces that <Tab> in file uses
vim.o.termguicolors = true
vim.o.timeoutlen = 300 -- time out time in milliseconds
-- [[
-- mode for 'wildchar' command-line expansion
-- default "full"
-- Completion mode that is used for the character specified with
-- 'wildchar'. It is a comma-separated list of up to four parts. Each
-- part specifies what to do for each consecutive use of 'wildchar'. The
-- first part specifies the behavior for the first use of 'wildchar',
-- The second part for the second use, etc.
--
-- Each part consists of a colon separated list consisting of the
-- following possible values:
-- ""         Complete only the first match.
-- "full"     Complete the next full match. After the last match,
--            the original string is used and then the first match
--            again. Will also start 'wildmenu' if it is enabled.
-- "longest"  Complete till longest common string. If this doesn't
--            result in a longer string, use the next part.
-- "list"     When more than one match, list all matches.
-- "lastused" When completing buffer names and more than one buffer
--            matches, sort buffers by time last used (other than
--            the current buffer).
-- When there is only a single match, it is fully completed in all cases.
-- ]]
vim.o.wildmode = "longest:full,full"
vim.o.wrap = false -- long lines wrap and continue on the next line
vim.o.hlsearch = true -- highlight matches with last search
vim.o.swapfile = false -- whether to use a swapfile for a buffer

if vim.fn.has("nvim-0.10") == 1 then
  vim.o.smoothscroll = true -- scroll by screen lines when 'wrap' is set
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
