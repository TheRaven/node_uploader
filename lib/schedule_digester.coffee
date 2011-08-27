fs = require 'fs'
path = require 'path'
xml2js = require 'xml2js'

{BaseDigester} = require './base_digester'

class exports.ScheduleDigester extends BaseDigester
  
  constructor: (@config) ->
    super
    @xmlParser = new xml2js.Parser
    @xmlParser.addListener 'end', (result) =>
      this.digest result

  digest: (result) =>
    console.dir result
    this.sendFile "./schedule.xml", result.name + "\n" + result.description
    
  fileCreated: (file) =>
    console.log "found file: #{file}"
    if path.extname(file) == ".xml"
      buffer = fs.readFileSync file
      @xmlParser.parseString buffer

    fs.unlinkSync file
