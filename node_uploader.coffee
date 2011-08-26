WatcherConfig = require('config').Watcher
path = require 'path'

{FileCreationWatcher} = require "./lib/file_creation_watcher"
filecreationWatcher = new FileCreationWatcher(WatcherConfig.baseFolder)

WatcherConfig.folders.forEach (folder) ->
  #figure out the class name from the filename in the config
  className = FileCreationWatcher.filenameToCamelCase path.basename(folder.listener)
  klass = eval(""+className+" = require('"+folder.listener+"')."+className)
  config = folder.configuration
  console.log("loading class: "+ className)
  filecreationWatcher.addWatch(folder.name, (new klass(config)).fileCreated)


filecreationWatcher.watch WatcherConfig.interval
