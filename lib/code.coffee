exec = require('child_process').exec
process = require('process')
path = require('path')
fs = require('fs')

module.exports =
  activate: ->
    atom.commands.add 'atom-workspace', 'open-in-terminal:open_path', => @open_in_terminal()
    atom.commands.add '.tree-view .selected', 'open-in-terminal:open_path' : (event) => @open_in_terminal(event.currentTarget)

  open_in_cmd: (target) ->
    if target?
      select_file = target.getPath?() ? target.item?.getPath() ? target
    else
      select_file = atom.workspace.getActivePaneItem()?.buffer?.file?.getPath()
      select_file ?= atom.project.getPaths()?[0]

    if select_file? and fs.lstatSync(select_file).isFile()
      dir_path = path.dirname(select_file)
    else
      dir_path = select_file

    exec "mate-terminal \"#{dir_path}\"\"
