fs = require "fs"
exports.ScheduleParser = class ScheduleParser
      parse: (file) ->
        console.log "drop "+file
        fs.unlinkSync file
