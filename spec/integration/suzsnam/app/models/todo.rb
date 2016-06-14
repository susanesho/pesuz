class Todo < Pesuz::BaseModel
  to_table :todos

  property :id, type: :integer, primary_key: true
  property :name, type: :text, nullable: false
  property :body, type: :text, nullable: false
  property :created_at, type: :text, nullable: false

  create_table
end