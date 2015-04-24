express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'

module.exports = (app) ->
  app.use '/user', router

router.get '/', (req, res, next) ->
  res.render 'user',
    title: '个人中心 - Sharer'
    user: req.session.user
