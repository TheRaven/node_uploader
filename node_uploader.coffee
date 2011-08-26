require 'coffee-script'
WatcherConfig = require('config').Watcher
path = require 'path'

{FileCreationWatcher} = require "./lib/file_creation_watcher"
filecreationWatcher = new FileCreationWatcher(WatcherConfig.baseFolder)

WatcherConfig.folders.forEach (folder) ->
  #figure out the class name from the filename in the config
  className = FileCreationWatcher.filenameToCamelCase path.basename(folder.listener, ".js")
  console.log(className)
  klass = eval(""+className+" = require('"+folder.listener+"')."+className)
  config = folder.configuration
  filecreationWatcher.addWatch(folder.name, (new klass(config)).fileCreated)


filecreationWatcher.watch WatcherConfig.interval
