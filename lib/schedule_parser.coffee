fs = require "fs"
exports.ScheduleParser = class ScheduleParser
      fileCreated: (file) ->
        console.log "drop "+file
        fs.unlinkSync file
