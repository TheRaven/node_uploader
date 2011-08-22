fs = require 'fs'
path = require 'path'
xml2js = require 'xml2js'
FtpConfig = require('config').ScheduleDigesterFtp
Ftp = require 'jsftp'

exports.ScheduleDigester = class ScheduleDigester
  constructor: ->
    @xmlParser = new xml2js.Parser
    @xmlParser.addListener 'end', (result) =>
      this.digest result

  digest: (result) =>
    console.dir result
    buffer = new Buffer "Thecontent of the file"
    ftp = new Ftp
      host: FtpConfig.host
      port: FtpConfig.port

    ftp.auth FtpConfig.username, FtpConfig.password, (err, res) =>
      throw err if err 

      ftp.put "./schedule.xml", buffer, (err, data) ->
        throw err if err 
        ftp.raw.quit (err, res) ->
          throw err if err 

    
    
  fileCreated: (file) =>

    if path.extname(file) == ".xml"
      buffer = fs.readFileSync file
      @xmlParser.parseString buffer

    fs.unlinkSync file
