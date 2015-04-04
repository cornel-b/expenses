class Eentry

  include Mongoid::Document
  field :user_id, type: Integer
  field :amount, type: Float
  field :tags, type: Array
  field :details, type: String
  field :created, type: DateTime
  field :updated, type: DateTime

end
