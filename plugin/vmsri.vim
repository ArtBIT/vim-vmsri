" dA VMSRI quickopen file
" Original concept by agorf@deviantart.com
" extended and maintained by artbit@deviantart.com
"
" Note: You have to cwd to your dA trunk dir
"       since all paths will be relative to your 
"       working path.
"       This was done, so that you don't need to
"       configure your paths every time you svn up
"       this script.
"
if exists('g:loaded_vmsri') | finish | endif
let g:loaded_vmsri = 1

set isfname+=: " VMSRIs can contain colons

function s:vmsri2path(vmsri, ...)
  let s:vmsri = split(a:vmsri, '#')[0] " drop function part
  let s:parts = ['vms']
  let s:v = 'v.'
  if a:0 > 0
      let s:v = 'v.' . a:1
  endif

  if s:vmsri =~ '::'
    let s:subparts = split(s:vmsri, '::')
    let s:parts += split(s:subparts[0], '\.')
    let s:parts += [s:v, s:subparts[1]]
  else
    let s:parts += split(s:vmsri, '\.')
    let s:parts += [s:v, s:vmsri]
  endif

  let s:path = join(s:parts, '/') . '.php'

  return s:path
endfunction

function s:vmsri2func(vmsri)
  let s:subparts = split(a:vmsri, '#')
  let s:parts = split(s:subparts[0], '\.\|::\|/')

  if len(s:subparts) == 2
    let s:parts += ['', s:subparts[1]]
  endif

  let s:func = join(s:parts, '_')
  let s:func = tolower(s:func)

  return s:func
endfunction

function s:edit_vmsri(command, vmsri, ...)
  if a:0 > 0
      execute a:command s:vmsri2path(a:vmsri, a:1)
  else 
      execute a:command s:vmsri2path(a:vmsri)
  endif

  if a:0 == 2
    let s:func = s:vmsri2func(a:vmsri)

    if s:func != ''
      call search('function[ \t&]\+' . s:func . '\s*(')
      normal zt
    endif
  endif
endfunction

function s:toggle_feature(...) 
    let l:feature = ''
    if a:0 > 0
        let l:feature = a:1
    endif
    let l:path = substitute(expand('%:p'), "/v\\.[^/]*/", '/v.'.l:feature.'/', '')
    execute "edit" l:path
endfunction

" gf analog
if !hasmapto('<Plug>VMSRIEditOnly')
  nmap <unique> gv <Plug>VMSRIEditOnly
endif

" gF analog
if !hasmapto('<Plug>VMSRIEditJump')
  nmap <unique> gV <Plug>VMSRIEditJump
endif

" CTRL-W_f analog
if !hasmapto('<Plug>VMSRISplitOnly')
  nmap <unique> <C-W>v <Plug>VMSRISplitOnly
endif

" CTRL-W_F analog
if !hasmapto('<Plug>VMSRISplitJump')
  nmap <unique> <C-W>V <Plug>VMSRISplitJump
endif

" CTRL-W_gf analog
if !hasmapto('<Plug>VMSRITabOnly')
  nmap <unique> <C-W>gv <Plug>VMSRITabOnly
endif

" CTRL-W_gF analog
if !hasmapto('<Plug>VMSRITabJump')
  nmap <unique> <C-W>gV <Plug>VMSRITabJump
endif

nnoremap <unique> <script> <Plug>VMSRIEditOnly <SID>EditOnly
nnoremap <SID>EditOnly :call <SID>edit_vmsri('edit', expand('<cfile>'))<CR>

nnoremap <unique> <script> <Plug>VMSRIEditJump <SID>EditJump
nnoremap <SID>EditJump :call <SID>edit_vmsri('edit', expand('<cfile>'), '', 1)<CR>

nnoremap <unique> <script> <Plug>VMSRISplitOnly <SID>SplitOnly
nnoremap <SID>SplitOnly :call <SID>edit_vmsri('split', expand('<cfile>'))<CR>

nnoremap <unique> <script> <Plug>VMSRISplitJump <SID>SplitJump
nnoremap <SID>SplitJump :call <SID>edit_vmsri('split', expand('<cfile>'), '', 1)<CR>

nnoremap <unique> <script> <Plug>VMSRITabOnly <SID>TabOnly
nnoremap <SID>TabOnly :call <SID>edit_vmsri('tabedit', expand('<cfile>'))<CR>

nnoremap <unique> <script> <Plug>VMSRITabJump <SID>TabJump
nnoremap <SID>TabJump :call <SID>edit_vmsri('tabedit', expand('<cfile>'), '', 1)<CR>

if !exists(':VMSRIEdit')
  command -nargs=* VMSRIEdit call s:edit_vmsri('edit', <f-args>)
endif

if !exists(':VMSRISplit')
  command -nargs=* VMSRISplit call s:edit_vmsri('split', <f-args>)
endif

if !exists(':VMSRITab')
  command -nargs=* VMSRITab call s:edit_vmsri('tabedit', <f-args>)
endif

if !exists(':VMSRIToggleFeature')
  command -nargs=? VMSRIToggleFeature call s:toggle_feature(<f-args>)
endif
