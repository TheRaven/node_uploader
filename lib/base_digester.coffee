fs = require 'fs'
path = require 'path'
xml2js = require 'xml2js'
Ftp = require 'jsftp'

class exports.BaseDigester
  constructor: (@config) ->

  sendFile: (remoteName, content) ->
    outputBuffer = new Buffer content
    ftp = new Ftp
      host: @config.ftp.host
      port: @config.ftp.port

    try
      ftp.auth @config.ftp.username, @config.ftp.password, (err, res) =>
        throw err if err 

        ftp.put remoteName, outputBuffer, (err, data) ->
          throw err if err 
          ftp.raw.quit (err, res) ->
            throw err if err 
            delete ftp
    catch exception
      console.log exception
      ftp.raw.quit