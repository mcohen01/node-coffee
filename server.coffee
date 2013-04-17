Express         = require("express")
File            = require("fs")
HTTP            = require("http")
Path            = require("path")
QS              = require("querystring")
URL             = require("url")
{ EventEmitter } = require("events")

class Channel extends EventEmitter
  log: (event, text)->
    @emit event, text

c = new Channel

c.on "debug", (msg)=>
  console.log msg

server = Express.createServer()

server.configure -> 
  server.set    "root", Path.resolve(__dirname, "..")
  server.use    Express.staticCache()
  server.use    Express.static("public")
  server.set    "views", "views"
  server.set    "view engine", "eco"
  server.enable "view cache"
  server.enable "json callback"
  server.use    Express.cookieParser()
  server.use    Express.query()
  server.use    Express.bodyParser()

server.get "/*", (req, res, next)->
  c.log "debug", req
  res.send("hello world" + new Date)

module.exports = server  
