fs = require "fs"

folder = "drop"


class Schedule
  constructor: (@folder) ->
    watcher = require('watch-tree').watchTree @folder, {'sample-rate': 5}
    watcher.on 'fileCreated', (path, stats) ->
      this.parseFile file

  parseFile: (file) ->
    console.log "parsing file: "+ file
    fs.unlinkSync file
    
    

schedule = new Schedule "drop"