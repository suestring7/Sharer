express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
Promise = require 'bluebird'

Post = mongoose.model 'Post'

module.exports = (app) ->
  app.use '/', router

router.get '/', Promise.coroutine (req, res, next) ->
  try
    if !req.session.user? && !req.query.direct?
      return res.redirect 'welcome'
    res.render 'index',
      title: '首页 - Sharer'
      user: req.session.user
      posts: yield Post.find().execAsync()
  catch e
    res.send JSON.stringify e

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

router.get '/search_post', (req, res, next) ->
  res.render 'search_post',
    title: '搜索结果 - Sharer'

router.get '/search_person', (req, res, next) ->
  res.render 'search_person',
    title: '搜索结果 - Sharer'  

router.get '/security', (req, res, next) ->
  res.render 'security',
    title: '安全中心 - Sharer' 