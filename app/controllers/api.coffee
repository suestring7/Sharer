express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
Promise = require 'bluebird'
Is = require 'is_js'

User = mongoose.model 'User'

module.exports = (app) ->
  app.use '/api', router

router.post '/user/signup', (req, res, next) ->
  Promise.coroutine ->
    try
      user = yield User.create
        username: req.body.username
        password: req.body.password
      req.session.user = user
      res.json
        code: 0
        message: 'OK'
    catch e
      res.json
        code: 1
        message: e.message

router.post '/user/signin', (req, res, next) ->
  Promise.coroutine ->
    try
      user = yield User.findOne(
        username: req.body.username
        password: req.body.password
      )
      if user?
        req.session.user = user
        res.json
          code: 0
          message: 'OK'
          _id: user._id
      else
        throw new Error('Invalid username or password')
    catch e
      res.json
        code: 1
        message: e.message

router.get '/user/signout', (req, res, next) ->
  req.session.user = undefined
  res.json
    code: 0
    message: 'OK'
