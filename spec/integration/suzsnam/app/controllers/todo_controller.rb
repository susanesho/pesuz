class TodoController < Pesuz::Controller
  def index
    @todos = Todo.all
    @count = @todos.size
  end

  def new
  end

  def edit
    @todo = Todo.find(params["id"])
  end

  def show
    @todo = Todo.find(params["id"])
  end

  def update
    todo = Todo.find(params["id"])
    todo.update(name: params["name"], body: params["body"])
    redirect_to "/todo/#{todo.id}"
  end

  def destroy
    @todo = Todo.find(params["id"])
    @todo.destroy
    redirect_to "/todo"
  end

  def create
    todo = Todo.new
    todo.name = params["name"]
    todo.body = params["body"]
    todo.created_at = Time.now.to_s
    todo.save

    redirect_to "/todo/#{Todo.last.id}"
  end
end
