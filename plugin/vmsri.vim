" dA VMSRI quickopen file
" @author artbit@deviantart.com
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
set includeexpr=VMSRI2PATH(v:fname)

function VMSRI2PATH(filename)
    return s:vmsri2path(a:filename)
endfunction

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

function s:toggle_feature(...) 
    let l:feature = ''
    if a:0 > 0
        let l:feature = a:1
    endif
    let l:path = substitute(expand('%:p'), "/v\\.[^/]*/", '/v.'.l:feature.'/', '')
    execute "edit" l:path
endfunction

if !exists(':VMSRIToggleFeature')
  command -nargs=? VMSRIToggleFeature call s:toggle_feature(<f-args>)
endif
