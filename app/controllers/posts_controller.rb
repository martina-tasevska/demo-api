class PostsController < ApiController
  before_action :set_post, only: [ :update, :destroy]

  def_param_group :post do
    param :post, Hash, :action_aware => true do
    param :title, String, :required => true
    param :description, String, :required => true
    param :user_id, Integer, :required => true
    end
  end

  api :GET, '/users/:user_id/posts', "List all posts created by user with given id or all posts if id doesn't exist"
  returns :array_of => :post, :desc => "List of posts"
  def index
    if(params.has_key? "user_id")
    @user = User.find(params[:user_id])
    @posts = @user.posts.order('created_at DESC').page(params[:page])
    render json: { status: 'SUCCESS', messsage:'Loaded posts', data: @posts }
    else
      @posts = Post.all.order('created_at DESC').page(params[:page])
      render json: { status: 'SUCCESS', messsage:'Loaded posts', data: @posts }
    end
  end

  api :GET, ' /users/:user_id/posts/:id', "Display a specific post with given id"
  returns :post, :desc => "Specific post"
  def show
    @post = policy_scope(Post).find(params[:id])
    render json: { status: 'SUCCESS', messsage:'Loaded post', data: @post }
  end

  # POST /posts
  api :POST, '/users/:user_id/posts', "Create post"
  param_group :post, :as => :create
  def create
    @post = Post.new(post_params)
    authorize @post
    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  api :PATCH, '/users/:user_id/posts/:id', "Update a specific post with given id"
  param_group :post, :as => :update
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  api :DELETE, '/users/:user_id/posts/:id', "Delete a specific post with given id"
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
    authorize @post
  end

    # Only allow a trusted parameter "white list" through.
  def post_params
    params.require(:post).permit(:title, :description, :user_id)
  end
end
