require "spec_helper"

describe "Todo Spec", type: :feature do
  after(:each) do
    Todo.destroy_all
  end

  context  "visiting index page" do
    it "has index page" do
      visit "/todo"

      expect(page).to have_content("Total Task")
      expect(page).to have_content(" Add New Todo List")
      expect(page).to have_content("Total task counts of todos")
    end
  end

  context "creating a todo" do
    it "creates a new todo" do
      visit "/todo/new"
      expect(page).to have_content("Add a new Todo")

      fill_in("name", with: "Paris")
      fill_in("body", with: "I am making a trip to Paris")
      click_button("Submit")

      expect(page).to have_content("Paris")
    end
  end

  context "when updating a specific todo list" do
    it "updates the specific list" do
      create(1)
      todo = Todo.last
      visit "/todo/#{todo.id}"

      click_link("Edit")
      expect(page).to have_content("Edit a")
      fill_in("name", with: "get carton")
      fill_in("body", with: "Take a trip to Barbados")
      click_button("Submit")

      expect(Todo.last.name).to eq "get carton"
      expect(Todo.last.body).to eq "Take a trip to Barbados"
    end
  end
  context "when deleting a specific todo list" do
    it "deletes the specific todo list" do
      create 3

      visit "/todo"

      first(".delete").click
      expect(Todo.all.length).to eq 2
    end
  end

  context "when getting a specific todo list" do
    it "shows the specific todo" do
      todos = create 5
      todo = todos.last
      visit "/todo"

      first(".view").click
      expect(page).to have_content(todo.name)
    end
  end
  context "when getting a path that does not exist" do
    it "renders a 404 error page" do
      visit "/todoss"

      expect(page).to have_content("Route not found")
    end
  end
end