#TODO: configure watch folders and parsers

{FileCreationWatcher} = require "./lib/file_creation_watcher"
{ScheduleParser} = require "./lib/schedule_parser"

    
filecreationWatcher = new FileCreationWatcher("drops")
filecreationWatcher.watch("drop", new ScheduleParser)
filecreationWatcher.watch("drop2", new ScheduleParser)