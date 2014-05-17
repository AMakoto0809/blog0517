class CommentsController < ApplicationController

	def create
		@post = Post.find(params[:post_id])
		#create: newとsaveを同時に行う。
		#@comment = Post.find(params[:post_id]).comments.create(params[:comment])
		@comment = Post.find(params[:post_id]).comments.new(params[:comment])	#new:新規作成する
		if @comment.save						#うまくいった場合、save
			redirect_to post_path(@post)		#リダイレクトする
		else									#うまくいかなかった場合、
			render :template => "posts/show"	#元のフォームを表示させるので、renderを使い、テンプレートを呼び出す。
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		render json: { comment: @comment }
	end
end
