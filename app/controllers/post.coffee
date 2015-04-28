express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'

Promise = require 'bluebird'

Post = mongoose.model 'Post'

module.exports = (app) ->
  app.use '/post', router

router.get '/:id', Promise.coroutine (req, res, next) ->
  try
    postId = req.params.id
    post = yield Post.findById(postId).execAsync()
    res.render 'post',
      title: post.title
      user: req.session.user
      post: post
  catch e
    res.status 404
