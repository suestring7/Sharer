express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'

module.exports = (app) ->
  app.use '/', router

router.get '/', (req, res, next) ->
  if !req.session.user? && !req.query.direct?
    res.redirect 'welcome'
  else
    res.render 'index',
      title: '首页 - Sharer'

router.get '/welcome', (req, res, next) ->
  res.render 'welcome',
    title: '欢迎 - Sharer'

router.get '/contact', (req, res, next) ->
  res.render 'contact',
    title: '联系方式 - Sharer'

router.get '/post', (req, res, next) ->
  res.render 'post',
    title: '我要发帖 - Sharer'

router.get '/posts', (req, res, next) ->
  res.render 'posts',
    title: '帖子首页 - Sharer'

router.get '/ranklist', (req, res, next) ->
  res.render 'ranklist',
    title: '排名 - Sharer'
