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
    let s:lineNum = line('.')
    let s:line = getline(s:lineNum)
    " API vmsri gets a special treatment
    if matchstr(s:line, 'API::vms_import') != ""
        let s:argumentsString = substitute("API::vms_import('api.handler.papi.dashared.nc.messages.correspondence::abstract', 1);", "API::vms_import(\\([^)]*\\));*", "\\1", "")
        let s:arguments = map(split(s:argumentsString, ","), 'trim(v:val)')
        let s:versionString = remove(s:arguments, -1) || "1"
        let s:version = str2nr(s:versionString)
        while s:version > 0
            let s:vmsri = substitute(a:filename, "api.handler", "api.v" . s:version . ".handler", "")
            let s:filepath = s:vmsri2path(s:vmsri)
            " check if filepath exists
            if filereadable(s:filepath)
                return s:filepath
            endif
            " decrease the version and try again
            let s:version -= 1
        endwhile
    endif


    " Handle API vmsri's
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
