class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.includes(:tags).order('updated_at DESC').all
    # @tags = @posts.flat_map { |post| post.tags}
    @tags = Tag.joins(:posts).group('tags.id').order('count(posts.id) desc')
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    if @post.save
      redirect_to posts_url, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    ids = Tag.includes(:posts).where(:posts => { :id => nil }).pluck(:id)
    Tag.where(id: ids).delete_all
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  def filter
    @posts = Post.joins(:tags).where(tags: { name:  params[:tag_name] })
    # this is just rubocop optimalization, meaning is the same
    # @tags = Tag.joins(:posts).where(posts: { id: @posts.map { |post| post.id } })
    @tags = Tag.joins(:posts).where(posts: { id: @posts.map(&:id) })
    render :index
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:author, :title, :body, :tag_list, :tag_name)
  end
end
