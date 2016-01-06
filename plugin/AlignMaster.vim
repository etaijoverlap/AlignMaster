" Vim plugin for easy alignment of source code.
" Maintainer: Franz Schanovsky <franz.schanovsky@gmail.com>
" Last Change: 01-06-2016
" This software is licensed under the EUPL V 1.1
"
" This software is provided "as is" without warranty of any kind, see the 
" respective section in the EUPL. USE AT YOUR OWN RISK.

if exists("g:AlignMasterLoaded")
    finish
endif

let g:AlignMasterLoaded = 1

function AlignMasterAdd()
    if !exists("b:AlignMasterPositions")
        let b:AlignMasterPositions = []
    endif
    let l:curpos = getpos(".")
    let l:row = l:curpos[1]
    let l:col = l:curpos[2]
    call add(b:AlignMasterPositions, [l:row, l:col])
    echo printf("Currently %d positions in alignment buffer.", len(b:AlignMasterPositions))
endfunction

function AlignMasterExec()
    if exists("b:AlignMasterPositions")
        let l:coltarget = 0
        for l:position in b:AlignMasterPositions
            if position[1] > l:coltarget
                let l:coltarget = l:position[1]
            endif
        endfor

        for l:position in b:AlignMasterPositions
            let l:row = l:position[0]
            let l:col = l:position[1]
            call setpos(".",[0, l:row, l:col, 0])
            for l:i in range(l:coltarget-l:col)
                execute("normal!i ")
            endfor
        endfor
        let b:AlignMasterPositions = []
    endif
endfunction

nnoremap <C-space> :call AlignMasterAdd()<cr>
nnoremap <C-S-space> :call AlignMasterExec()<cr>
