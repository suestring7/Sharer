mongoose = require 'mongoose'
Schema = mongoose.Schema

PostSchema = new Schema
  title: String
  address: String
  content: String
  author:
    type: Schema.Types.ObjectId
    ref: 'User'
  leaders: [
    type: Schema.Types.ObjectId
    ref: 'User'
  ]
  friends: [
    type: Schema.Types.ObjectId
    ref: 'User'
  ]

PostSchema.virtual('date').get -> this._id.getTimestamp()

mongoose.model 'Post', PostSchema
