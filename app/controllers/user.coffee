express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'

module.exports = (app) ->
  app.use '/user', router

router.get '/:id', (req, res, next) ->
  res.render 'user',
    title: '个人中心 - Sharer'

router.get '/:id/security', (req, res, next) ->
  res.render 'security',
    title: '安全中心 - Sharer'
