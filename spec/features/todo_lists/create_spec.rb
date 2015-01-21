require 'spec_helper'

describe "Creating todo lists" do

	def create_todo_list(options={})
		options[:title] ||= "My todo list"
		options[:description] ||= "This is my todo list. yay!"

		visit '/todo_lists'
		click_link 'New Todo list'
		expect(page).to have_content('New todo_list')

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:descriptions]
		click_button "Create Todo list"
	
		def test_error
			expect(page).to have_content("error")
			expect(TodoList.count).to eq(0)

			visit "/todo_lists"
			expect(page).to_not have_content("My todo list" || "This is my todo list. yay!")

		end	
	end


	it "redirects to the todo list index page on success" do
		
		create_todo_list
		expect(page).to have_content("New todo_list")
	end

	it "displays and error when the todo list has no title" do
		expect(TodoList.count).to eq(0)
		
		create_todo_list(title: "")
		
		test_error

	end

	it "displays and error when the todo list has less than 3 characters" do
		expect(TodoList.count).to eq(0)
		
		create_todo_list(title:"Hi")

		test_error
	end

	it "displays and error when the todo list has no description" do
			expect(TodoList.count).to eq(0)
			
			create_todo_list(description:"")

			test_error
	end

	it "displays and error when the todo list has no description" do
			expect(TodoList.count).to eq(0)
			
			create_todo_list(description:"food")

			test_error
	end
end
