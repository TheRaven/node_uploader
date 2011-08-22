fs = require 'fs'
Util = require 'util'
path = require 'path'
xml2js = require 'xml2js'
FtpConfig = require('config').ScheduleDigesterFtp
Ftp = require 'jsftp'

exports.ScheduleDigester = class ScheduleDigester
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

    ftp.auth @config.ftp.username, @config.ftp.password, (err, res) =>
      throw err if err 

      ftp.put "./schedule.xml", outputBuffer, (err, data) ->
        throw err if err 
        ftp.raw.quit (err, res) ->
          throw err if err 

    
    
  fileCreated: (file) =>
    console.log file
    if path.extname(file) == ".xml"
      buffer = fs.readFileSync file
      @xmlParser.parseString buffer

    fs.unlinkSync file
