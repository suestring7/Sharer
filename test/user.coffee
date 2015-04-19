Promise = require 'bluebird'
Promise.promisifyAll require('mongoose')
mongoose = require 'mongoose'
mongoose.connect 'mongodb://localhost/testmongoose'
require '../app/models/user'
User = mongoose.model 'User'
user = new User
  username: 'AAAzz'
  password: '1233'

try
  async = (cb) ->
    Promise.coroutine ->
      data = yield user.saveAsync
      cb(data)
  async (data) ->
    console.log data
catch e
  console.log e


###
console.log user.saveAsync

try
  async = Promise.coroutine ->
    yield user.saveAsync
  async()
catch e
  console.log e
###
