fs = require "fs"
path = require "path"
xml2js = require('xml2js');


exports.ScheduleDigester = class ScheduleDigester
      
  constructor: ->
    @xmlParser = new xml2js.Parser
    @xmlParser.addListener 'end', (result) =>
      this.digest result

  digest: (result) =>
    console.dir result
    
    
  fileCreated: (file) =>

    if path.extname(file) == ".xml"
      buffer = fs.readFileSync file
      @xmlParser.parseString buffer

    fs.unlinkSync file
