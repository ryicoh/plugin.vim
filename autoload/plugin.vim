let g:plugin#location = expand("~/.vim/plugins")
let g:plugin#plugins = {}

function! plugin#use(repository, ...) abort
  let l:options = s:ensure_options(a:0 > 0 ? a:1 : {})
  let g:plugin#plugins[a:repository] = l:options

  if !isdirectory(g:plugin#location)
    call system('mkdir -p ' . a:directory)
  endif

  call s:ensure_plugin(a:repository, l:options)
endfunction

function! plugin#install(repository, options) abort
  let l:plgpath = s:get_plugin_path(a:repository)
  let l:clone_cmd = 'git clone https://github.com/' . a:repository . ' ' . l:plgpath
  if a:options.branch != ""
    let l:clone_cmd = l:clone_cmd.' --branch '.a:options.branch
  endif

  echomsg l:clone_cmd
  echomsg system(l:clone_cmd)
  call s:load_plugin(a:repository)

  if a:options.build != ""
    try
      if type(a:options.build) == type(function("tr"))
        echomsg "build: calling lamdba"
        call a:options.build()
      elseif a:options.build[0] == ':'
        echomsg "build: executing " . a:options.build[1:]
        execute(a:options.build[1:])
      else
        let l:cmd = "cd ".l:plgpath." && ".a:options.build
        echomsg "build: executing " . l:cmd
        call system(l:cmd)
      endif
    catch
      echomsg v:exception
    endtry
  endif
endfunction

function! plugin#uninstall(repository) abort
  let l:plgpath = s:get_plugin_path(a:repository)
  call system("rm -rf ".l:plgpath)
endfunction

function! plugin#update() abort
  for plg in keys(g:plugin#plugins)
    call plugin#uninstall(plg)
    call plugin#use(plg, g:plugin#plugins[plg])
  endfor
endfunction

function s:ensure_options(custom) abort
  return {
    \  "branch": get(a:custom, 'branch', ''),
    \  "build": get(a:custom, 'build', ''),
    \ }
endfunction

function! s:get_plugin_path(repository) abort
  return g:plugin#location . '/' . a:repository
endfunction

function! s:ensure_plugin(repository, options) abort
  let l:plgpath = s:get_plugin_path(a:repository)
  execute 'set runtimepath^=' . l:plgpath

  if !isdirectory(l:plgpath)
    call plugin#install(a:repository, a:options)
  else
    call s:load_plugin(a:repository)
  endif
endfunction

function! s:load_plugin(repository) abort
  let l:plgpath = s:get_plugin_path(a:repository)
  if isdirectory(l:plgpath."/doc")
    execute 'helptags' l:plgpath."/doc"
  endif

  let l:plugin_path = globpath(l:plgpath, "plugin/*.vim")
  if l:plugin_path != ""
    execute("source ".l:plugin_path)
  endif
endfunction
