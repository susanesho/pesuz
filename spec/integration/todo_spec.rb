require "spec_helper"

describe "Todo Spec", type: :feature do
  after(:each) do
    Todo.destroy_all
  end

  feature "Suzsnam todo app hompepage" do
    scenario "Displays all todos in the database" do
      todos = create(3)
      visit "/"

      expect(page).to have_content("Total Task")
      expect(page).to have_content(" Add New Todo List")
      expect(page).to have_content("Total task counts of todos")

      expect(page).to have_content(todos[0].name)
      expect(page).to have_content(todos[1].name)
      expect(page).to have_content(todos[2].name)
    end
  end

  feature "Create" do
    scenario "Creating a new todo list" do
      visit "/todo/new"

      expect(page).to have_content("Add a new Todo")

      fill_in("name", with: "Paris")
      fill_in("body", with: "I am making a trip to Paris")
      click_button("Submit")

      expect(page).to have_content("Paris")
    end
  end

  feature "Update" do
    scenario "Updating a specific todo list" do
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

  feature "Delete" do
    scenario "Deleting a specific todo list" do
      create(3)
      visit "/todo"

      expect(Todo.all.length).to eq 3

      first(".delete").click
      expect(Todo.all.length).to eq 2
    end
  end

  feature "Show" do
    scenario "Showing a specific todo list"  do
      create(5)
      todo = Todo.last
      visit "/todo/#{todo.id}"

      expect(page).to have_content("Edit")
      expect(page).to have_content("delete")
      expect(page).to have_content(todo.name)
    end
  end

  feature "Error page" do
    scenario "Visiting a route that does not exist" do
      visit "/todoss"

      expect(page).to have_content("Route not found")
    end
  end
end