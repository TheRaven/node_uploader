WatchTree = require "watch-tree"
class exports.FileCreationWatcher
  constructor: (@baseDirectory) ->
    @watches = []
  
  addWatch: (folder, callback) ->
    @watches.push({folder:folder, callback:callback})
    
  watch: (sampleRate) ->
    watcher = WatchTree.watchTree @baseDirectory, 'sample-rate': sampleRate
    
    watcher.on 'fileCreated', (file, stats) =>
      @watches.forEach (watch) =>
        folder = @baseDirectory+"/"+watch.folder+"/"
        #check if we are watching for the folder containing the file if we are to execute the associated callback
        if file.indexOf(folder) == 0
          console.log file
          watch.callback file

  @filenameToCamelCase = (s) ->
    s = s.replace(/_/, " ")
    s = s.charAt(0).toUpperCase() + s.slice(1);
    if ( /\S[A-Z]/.test( s ) ) 
      s.replace( /(.)([A-Z])/g, (t,a,b) ->  a + ' ' + b.toLowerCase();  ) 
    else
      s.replace( /( )([a-z])/g, (t,a,b) ->  b.toUpperCase();  )
