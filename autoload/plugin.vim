let g:plugin#location = expand("~/.vim/plugins")

function! plugin#use(repository, ...) abort
  let options = s:ensure_options(a:0 > 0 ? a:1 : {})

  call s:ensure_directory(g:plugin#location)
  call s:ensure_plugin(a:repository, l:options)
endfunction

function! plugin#install(repository, options) abort
  let l:repopath = s:get_repository_path(a:repository)
  let l:clone_cmd = 'git clone https://github.com/' . a:repository . ' ' . l:repopath
  if a:options.branch !=# ""
    let l:clone_cmd = l:clone_cmd.' --branch '.a:options.branch
  endif

  echomsg l:clone_cmd
  echomsg system(l:clone_cmd)
  call s:load_plugin(a:repository)

  if a:options.build !=# ""
    try
      if type(a:options.build) == type(function("tr"))
        echomsg "build: calling lamdba"
        call a:options.build()
      elseif a:options.build[0] == ':'
        echomsg "build: executing " . a:options.build[1:]
        execute(a:options.build[1:])
      else
        let l:cmd = "cd ".l:repopath." && ".a:options.build
        echomsg "build: executing " . l:cmd
        call system(l:cmd)
      endif
    catch
      echomsg v:exception
    endtry
  endif
endfunction

function! plugin#uninstall(repository) abort
  let l:repopath = s:get_repository_path(a:repository)
  call system("rm -rf ".l:repopath)
endfunction

function s:ensure_options(custom) abort
  let l:options = {
    \ "branch": "",
    \ "build": "",
    \ }

  if has_key(a:custom, "branch")
    let l:options.branch = a:custom.branch
  endif

  if has_key(a:custom, "build")
    let l:options.build = a:custom.build
  endif

  return l:options
endfunction

function! s:ensure_directory(directory) abort
  if isdirectory(a:directory)
    return
  endif

  call system('mkdir -p ' . a:directory)
endfunction

function! s:get_repository_path(repository) abort
  return g:plugin#location . '/' . a:repository
endfunction

function! s:ensure_plugin(repository, options) abort
  let l:repopath = s:get_repository_path(a:repository)
  execute 'set runtimepath^=' . l:repopath

  if !isdirectory(l:repopath)
    call plugin#install(a:repository, a:options)
  else
    call s:load_plugin(a:repository)
  endif
endfunction

function! s:load_plugin(repository) abort
  let l:repopath = s:get_repository_path(a:repository)
  let l:plugin_path = globpath(l:repopath, "plugin/*.vim")
  if l:plugin_path != ""
    execute("source ".l:plugin_path)
  endif
endfunction
