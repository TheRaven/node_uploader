WatchTree = require "watch-tree"
exports.FileCreationWatcher = class FileCreationWatcher
  constructor: (@baseDirectory) ->
    @watches = []
    watcher = WatchTree.watchTree @baseDirectory, {'sample-rate': 5}
    
    watcher.on 'fileCreated', (file, stats) =>
      @watches.forEach (watch) =>
        folder = @baseDirectory+"/"+watch.folder+"/"
        #check if we are watching for the folder containing the file if we are execute the associated callback
        if file.indexOf(folder) == 0
          watch.callback.parse file
  
  watch: (folder, callback) ->
    @watches.push({folder:folder, callback:callback})
