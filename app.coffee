WatcherConfig = require('config').Watcher;
path = require('path');

{FileCreationWatcher} = require "./lib/file_creation_watcher"
filecreationWatcher = new FileCreationWatcher(WatcherConfig.baseFolder)

WatcherConfig.folders.forEach (folder) ->
  #figure out the class name from the filename in the config
  className = FilecreationWatcher.filenameToCamelCase path.basename(folder.listener, ".js")
  klass = eval(""+className+" = require('"+folder.listener+"')."+className)

  filecreationWatcher.addWatch(folder.name, (new klass).fileCreated)


filecreationWatcher.watch WatcherConfig.interval
