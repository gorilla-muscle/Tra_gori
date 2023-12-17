class OauthsController < ApplicationController
  skip_before_action :require_login
  before_action :authenticated
  
  def oauth
    #指定されたプロバイダの認証ページにユーザーをリダイレクトさせる
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    # 既存のユーザーをプロバイダ情報を元に検索し、存在すればログイン
    if (@user = login_from(provider))
      flash[:success] = t('.login_success', provider: provider.titleize)
      redirect_to root_path
    else
      begin
        # ユーザーが存在しない場合はプロバイダ情報を元に新規ユーザーを作成し、ログイン
        signup_and_login(provider)
        flash[:success] = t('.login_success', provider: provider.titleize)
        redirect_to root_path
      rescue
        flash[:alert] = t('.login_failure', provider: provider.titleize)
        redirect_to root_path
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end

  def signup_and_login(provider)
    @user = create_from(provider)
    reset_session
    auto_login(@user)
  end
end
