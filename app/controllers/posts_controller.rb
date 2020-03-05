class PostsController < ApiController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  api :GET, '/posts', "List all posts"
  def index
    @posts = Post.all

    render json: @posts
  end

  # GET /posts/1
  api :GET, '/posts/:id', "Display a specific post with given id"
  def show
    render json: @post
  end

  # POST /posts
  api :POST, '/posts', "Create a new post"
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  api :PATCH, '/posts/:id', "Update a specific post with given id"
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  api :DELETE, '/posts/:id', "Delete a specific post with given id"
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :description)
    end
end
