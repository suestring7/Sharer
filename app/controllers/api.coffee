express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
Promise = require 'bluebird'
Is = require 'is_js'

User = mongoose.model 'User'
Post = mongoose.model 'Post'
Comment = mongoose.model 'Comment'

module.exports = (app) ->
  app.use '/api', router

router.post '/user/signup', Promise.coroutine (req, res, next) ->
  try
    user = new User
      username: req.body.username
      password: req.body.password
    yield user.saveAsync()
    req.session.user = user
    res.json
      code: 0
      message: 'OK'
  catch e
    res.json
      code: 1
      error: e

router.post '/user/signin', Promise.coroutine (req, res, next) ->
  try
    user = yield User.findOne
      username: req.body.username
      password: req.body.password
    .execAsync()
    if !user?
      return res.json
        code: 1
        error: 'Incorrect username or password'
    req.session.user = user
    res.json
      code: 0
      message: 'OK'
      _id: user._id
  catch e
    res.json
      code: 1
      error: e

router.get '/user/signout', (req, res, next) ->
  req.session.user = undefined
  res.json
    code: 0
    message: 'OK'

router.post '/user/info/update', Promise.coroutine (req, res, next) ->
  try
    if !req.session.user?
      return res.status(403).json
        code: 1
        error: 'Not loggin in'
    user = yield User.findById(req.session.user._id).execAsync()
    user.skills = req.body.skill.split ' '
      .filter (s) ->
        return s isnt ''
    user.intro = req.body.resume
    user.telephone = req.body.telephone
    yield user.saveAsync()
    res.json
      code: 0
      message: 'OK'
  catch e
    res.json
      code: 1
      error: e

router.post '/user/password/update', Promise.coroutine (req, res, next) ->
  try
    if !req.session.user?
      return res.status(403).json
        code: 1
        error: 'Not logged in'
    user = yield User.findById(req.session.user._id).execAsync()
    if user.password isnt req.body.old
      throw new Error('Wrong current password')
    user.password = req.body.password
    yield user.saveAsync()
    res.json
      code: 0
      message: 'OK'
  catch e
    res.json
      code: 1
      message: e

router.post '/post/new', Promise.coroutine (req, res, next) ->
  try
    if !req.session.user?
      return res.status(403).json
        code: 1
        error: 'Not logged in'
    post = new Post
      title: req.body.title
      content: req.body.content
      address: req.body.address
      author: req.session.user
      updatedAt: Date.now()
      createdAt: Date.now()
    yield post.saveAsync()
    res.json
      code: 0
      message: 'OK'
  catch e
    res.json
      code: 1
      error: e

router.post '/post/:id/modify', Promise.coroutine (req, res, next) ->
  try
    if !req.session.user?
      return res.status(403).json
        code: 1
        error: 'Not logged in'
    postId = req.params.id
    post = yield Post.findById(postId).populate('author').execAsync()
    author = post.author
    if author._id isnt req.session.user._id
      return res.status(403).json
        code: 1
        error: 'No permission'
    yield post.update(req.body).execAsync()
    res.json
      code: 0
      message: 'OK'
  catch e
    res.json
      code: 1
      error: e

router.post '/post/:id/comment', Promise.coroutine (req, res, next) ->
  try
    if !req.session.user?
      return res.status(403).json
        code: 1
        error: 'Not logged in'
    postId = req.params.id
    post = yield Post.findById(postId).execAsync()
    comment = new Comment
      content: req.body.content
      author: req.session.user
      createdAt: Date
    yield comment.saveAsync()
    post.comments.push comment
    yield post.saveAsync()
    res.json
      code: 0
      message: 'OK'
  catch e
    res.json
      code: 1
      error: e

router.get '/post/:id/likes/new', Promise.coroutine (req, res, next) ->
  try
    if !req.session.user?
      return res.status(403).json
        code: 1
        error: 'Not logged in'
    postId = req.params.id
    post = yield Post.findById(postId).execAsync()
    post.likes.push req.session.user
    yield post.saveAsync()
    res.json
      code: 0
      message: 'OK'
  catch e
    res.json
      code: 1
      error: e

router.get '/post/:id/leaders/new', Promise.coroutine (req, res, next) ->
  try
    if !req.session.user?
      return res.status(403).json
        code: 1
        error: 'Not logged in'
    postId = req.params.id
    post = yield Post.findById(postId).execAsync()
    post.leaders.push req.session.user
    yield post.saveAsync()
    res.json
      code: 0
      message: 'OK'
  catch e
    res.json
      code: 1
      error: e

router.get '/post/:id/friends/new', Promise.coroutine (req, res, next) ->
  try
    if !req.session.user?
      return res.status(403).json
        code: 1
        error: 'Not logged in'
    postId = req.params.id
    post = yield Post.findById(postId).execAsync()
    post.friends.push req.session.user
    yield post.saveAsync()
    res.json
      code: 0
      message: 'OK'
  catch e
    res.json
      code: 1
      error: e

router.get '/post/:id/members', Promise.coroutine (req, res, next) ->
  try
    postId = req.params.id
    post = yield Post.findById(postId).populate('author').populate('leaders').populate('friends').execAsync()
    res.json
      code: 0
      author: post.author
      leaders: post.leaders
      friends: post.friends
  catch e
    res.json
      code: 1
      error: e
