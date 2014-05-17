# coding: utf-8

class PostsController < ApplicationController
    def index
        @posts = Post.all(:order => "created_at DESC")   
        #postのオブジェクトの全てをposts変数に入れる
        #created_at:作成日時/更新日時を自動記録。DESC:降順に並べる
    end

    def show
    	@post = Post.find(params[:id])	
        #Postオブジェクトから、paramsがidのものを引っ張ってくる。
        @comment = Post.find(params[:id]).comments.build
    end

    def new
    	@post = Post.new
    end

    def create
    	@post = Post.new(params[:post])
    	if @post.save
    		redirect_to posts_path,notice: '作成されました！'		
            #saveできたときの処理　posts一覧にリダイレクトする
    	else
    		render action: 'new'		
            #saveできなかったときの処理　newを実施する
    	end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        if @post.update_attributes(params[:post])
            redirect_to posts_path,notice: '更新されました！'
        else
            render action: 'edit'
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        #redirect_to posts_path,notice: '削除しました！'
        render json: { post: @post } 
        #json形式でpostの情報を送る
    end
end
