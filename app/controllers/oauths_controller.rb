class OauthsController < ApplicationController
  skip_before_action :require_login, only: %i[oauth callback]

  # 指定されたプロバイダの外部認証ページへリダイレクト
  def oauth
    login_at(auth_params[:provider])
  end

  # 認証コールバック処理
  def callback
    provider = auth_params[:provider]

    case provider
    when "line"
      line_auth
    when "google"
      google_auth
    else
      unauthorized_provider
    end
  end

  def delete_line
    current_user.authentications.where(provider: "line").destroy_all
    flash[:success] = "LINE連携を解除したウホ"
    redirect_to users_profiles_path, status: :see_other
  end

  private

  # 認証パラメータ
  def auth_params
    params.permit(:code, :provider, :error, :state)
  end

  # ログイン確認
  def line_auth
    if logged_in?
      line_cooperation
    else
      flash[:alert] = "まずログインをするウホ！"
      redirect_to login_path
    end
  end

  # LINE連携処理
  def line_cooperation
    if current_user.authentications.where(provider: "line").present?
      flash[:warning] = "既にLINE連携済みウホ"
    else
      add_provider_to_user(auth_params[:provider])
      flash[:success] = "LINE連携が完了したウホ！"
    end
    redirect_to users_profiles_path
  end

  # Google認証処理
  def google_auth
    if login_from(auth_params[:provider])
      successful_google_login
    else
      begin
        create_user_and_login(auth_params[:provider])
      rescue StandardError => e
        flash[:alert] = "Googleログインに失敗: #{e.message}"
      end
    end
  end

  # ユーザー作成+ログイン処理
  def create_user_and_login(provider)
    @user = create_from(provider)
    reset_session
    auto_login(@user)
    successful_google_login
  end

  # Googleログイン時の画面遷移処理
  def successful_google_login
    flash[:success] = "Googleログインが完了したウホ！"
    redirect_to training_records_path
  end

  # 許可されていないプロバイダーの処理
  def unauthorized_provider
    flash[:alert] = "許可されていない外部プロバイダーです。"
    redirect_to root_path
  end
end
