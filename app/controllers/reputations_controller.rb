class ReputationsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_reputation, only: [:show, :edit, :update]

  def index
    @my_properties = current_user.properties
  end

  def new
    session[:property_id] = params[:pid]

    @user = current_user
    @property = Property.find(session[:property_id])
    @reputation = Reputation.new
  end

  def create
    @user = current_user
    @property = Property.find(session[:property_id])

    @reputation = Reputation.new(reputation_params)
    @reputation.user_id = current_user.id
    @reputation.property_id = session[:property_id]
    if @reputation.save
      session.delete(:property_id)

      flash[:notice] = "口コミを投稿しました。"
      redirect_to reputation_path(@reputation)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @reputation.update(reputation_params)
      redirect_to reputation_path(@reputation), flash: { notice: "口コミを投稿しました。" }
    else
      render 'edit'
    end
  end

  def update_hidden
    reputation = Reputation.find(params[:format])
    if reputation.visible == true
      if reputation.update_attribute(:visible, false)
        flash[:notice] = "口コミを非表示にしました。"
      end
    else
      if reputation.update_attribute(:visible, true)
        flash[:notice] = "口コミの非表示設定を解除しました。"
      end
    end
    redirect_to reputations_path
  end

  private

  def set_reputation
    @reputation = Reputation.find(params[:id])
    @user = @reputation.user
    @property = @reputation.property
  end
  
  def reputation_params
    params.require(:reputation).permit(:rating, :testimonial)
  end

end
