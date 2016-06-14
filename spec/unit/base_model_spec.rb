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

  describe ".destroy" do
    it "destroys a row in the table" do
      create(7)
      todos = Todo.last
      todos.destroy

      expect(Todo.all.length).to eq 6
    end
  end

  describe "#update" do
    it "updates a row with the new fields specified" do
      create(2)
      first_todo = Todo.first
      first_todo.update(name: "banji", body: "bankol williams ni oruko eh joor")

      expect(Todo.first.name).to eq "banji"
      expect(Todo.first.body).to eq "bankol williams ni oruko eh joor"
    end

    describe ".first" do
      it "get the first row in a table" do
        create(3)
        first_todo = Todo.first

        expect(Todo.first.name).to eq first_todo.name
        expect(Todo.first.body).to eq first_todo.body
        expect(Todo.first.created_at).to eq first_todo.created_at
      end
    end

    describe ".last" do
      it "get the last row in a table" do
        create(3)
        last_todo = Todo.first

        expect(Todo.last.name).to eq last_todo.name
        expect(Todo.last.body).to eq last_todo.body
        expect(Todo.last.created_at).to eq last_todo.created_at
      end
    end

    describe ".find" do
      it "get the first row in a table" do
        create(1)
        find_todo_id = Todo.first.id
        found_record = Todo.find(find_todo_id)

        expect(found_record.id).to eq find_todo_id
        expect(found_record.name).to eq found_record.name
        expect(found_record.body).to eq found_record.body
      end
    end

    describe ".destroy_all" do
      it "destroys all the rows in the table" do
        create(10)
        destroy_todos = Todo.destroy_all

        expect(Todo.all.length).to eq 0
      end
    end
  end
end
