class ApiController < ActionController::API
  include Pundit

  def_param_group :post do
    param :post, Hash, :action_aware => true do
      param :title, String, :required => true
      param :description, String, :required => true
      param :user_id, Integer, :required => true
    end
  end

  api :GET, '/', "List all posts"
  returns :array_of => :post, :desc => "List of posts"
  def index
    @posts = Post.all
    render json: { status: 'SUCCESS', messsage:'Loaded posts', data: @posts }
  end
end