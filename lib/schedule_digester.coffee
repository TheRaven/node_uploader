fs = require 'fs'
Util = require 'util'
path = require 'path'
xml2js = require 'xml2js'
FtpConfig = require('config').ScheduleDigesterFtp
Ftp = require 'jsftp'

class exports.ScheduleDigester
  constructor: (@config) ->
    @xmlParser = new xml2js.Parser
    @xmlParser.addListener 'end', (result) =>
      this.digest result

  digest: (result) =>
    console.dir result
    outputBuffer = new Buffer result.name + "\n" + result.description
    ftp = new Ftp
      host: @config.ftp.host
      port: @config.ftp.port

    try
      ftp.auth @config.ftp.username, @config.ftp.password, (err, res) =>
        throw err if err 

        ftp.put "./schedule.xml", outputBuffer, (err, data) ->
          throw err if err 
          ftp.raw.quit (err, res) ->
            throw err if err 
            delete ftp
    catch exception
      console.log exception
      ftp.raw.quit
  
    
  fileCreated: (file) =>
    console.log file
    if path.extname(file) == ".xml"
      buffer = fs.readFileSync file
      @xmlParser.parseString buffer

    fs.unlinkSync file
