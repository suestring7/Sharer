mongoose = require 'mongoose'
Schema = mongoose.Schema

CommentSchema = new Schema
  content: String
  author:
    type: Schema.Types.ObjectId
    ref: 'User'
  createdAt: Date

CommentSchema.virtual('date').get -> this._id.getTimestamp()

mongoose.model 'Comment', CommentSchema
