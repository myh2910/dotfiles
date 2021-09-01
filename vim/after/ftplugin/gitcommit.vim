setlocal ts=4
" this goes in ~/.vim/after/ftplugin/gitcommit.vim

" https://www.reddit.com/r/vim/comments/dj37wt/plugin_for_conventional_commits/
inoreabbrev <buffer> BB BREAKING CHANGE:

function! HandleFZF(arg)
	normal gg
	normal 0
	call feedkeys("O" . a:arg . ": ", 't')
endfunction

command! -nargs=1 HandleFZF call HandleFZF(<f-args>)

let g:categorized = 0
function! s:SetConventionalCommit()
	let s:choices = ['wtf', 'fix', 'feat', 'docs', 'style', 'refactor', 'chore', 'test', 'polish', 'improvement']
	if g:categorized == 0
		let g:categorized = 1
		call fzf#run({'source' : s:choices, 'sink': 'HandleFZF', 'up' : '15'})
	endif
endfunction

autocmd VimEnter COMMIT_EDITMSG call s:SetConventionalCommit()
