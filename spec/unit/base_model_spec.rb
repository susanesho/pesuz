require "spec_helper"

describe "Base Model" do

  after(:each) do
    Todo.destroy_all
  end

  describe ".all" do
    it "returns all the rows in the table" do
      create(5)
      expect(Todo.all.length).to eq 5
    end
  end

  describe "#save" do
    it "saves a new row" do
      todo = Todo.new
      todo.name = Faker::StarWars.planet
      todo.body = Faker::StarWars.quote
      todo.created_at = Time.now.to_s
      todo.save

      expect(Todo.first.name).to eq todo.name
      expect(Todo.first.body).to eq todo.body
    end
  end
end



