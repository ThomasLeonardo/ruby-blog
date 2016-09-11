require 'logger'
class ArticlesController < ApplicationController
  include ArticlesHelper
  def index
    @articles = Article.all
  end
  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comment.article_id = @article.id
  end
  def new
    @article = Article.new
  end
  def create
    @article = Article.new(article_params)
    @article.save
    flash.notice = "Article '#{@article.title}' Created!"
    redirect_to article_path(@article)
  end
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash.notice = "Article '#{@article.title}' Deleted!"
    redirect_to articles_path
  end
  def edit
    @article = Article.find(params[:id])
  end
  def update
    log = Logger.new("application.log", 'monthly')
    @article = Article.find(params[:id])
    log.debug ("Before: #{@article.attributes.inspect}")
    @article.update(article_params)
    log.debug("Returns: #{@article.attributes.inspect}")
    log.debug ("After: #{Article.find(3).attributes.inspect}")
    flash.notice = "Article '#{@article.title}' Updated!"
    redirect_to article_path(@article)
  end
end
