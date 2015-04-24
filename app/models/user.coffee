mongoose = require 'mongoose'
Is = require 'is_js'
Schema = mongoose.Schema

UserSchema = new Schema
  username:
    type: String
    index:
      unique: true
  password: String
  email: String
  skills: [String]
  intro: String
  telephone: String


UserSchema.path('username').validate (value) ->
  return value.length >= 4 && value.length <= 8
, 'Invalid username length'

UserSchema.path('email').validate (value) ->
  return Is.empty(value) || Is.email(value)
, 'Invalid email'

mongoose.model 'User', UserSchema
