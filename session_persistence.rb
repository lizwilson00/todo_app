class SessionPersistence
  
  def initialize(session)
    @session = session
    @session[:lists] ||= []
  end
  
  def find_list(list_id)
    @session[:lists].find { |list| list[:list_id] == list_id }
  end

  def all_lists
    @session[:lists]
  end

  def create_new_list(list_name)
    id = next_list_id(@session[:lists])
    @session[:lists] << { list_id: id, name: list_name, todos: [] }
  end

  def delete_list(list_id)
    @session[:lists].reject! { |list| list[:list_id] == list_id }
  end

  def update_list_name(list_id, new_name)
    list = find_list(list_id)
    list[:name] = new_name
  end

  def create_new_todo(list_id, todo_name)
    list = find_list(list_id)
    id = next_todo_id(list[:todos])
    list[:todos] << { id: id, name: todo_name, completed: false }
  end

  def delete_todo_from_list(list_id, todo_id)
    list = find_list(list_id)
    list[:todos].reject! { |todo| todo[:id] == @todo_id }
  end

  def update_todo_status(list_id, todo_id, new_status)
    list = find_list(list_id)
    todo = list[:todos].find { |todo_item| todo_item[:id] == todo_id }
    todo[:completed] = new_status
  end

  def mark_all_todos_as_completed(list_id)
    list = find_list(list_id)
    list[:todos].each { |todo| todo[:completed] = true }
  end

  private

  def next_list_id(lists)
    max = lists.map { |list| list[:list_id] }.max || 0
    max + 1
  end

  def next_todo_id(todos)
    max = todos.map { |todo| todo[:id] }.max || 0
    max + 1
  end
end