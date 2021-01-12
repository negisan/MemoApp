module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    #@current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  #永続セッションを破棄する
  def forget(user)
    user.forget #モデルで定義したメソッド、DBのハッシュしたトークンを削除
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    reset_session
    @current_user = nil
  end

  def logged_in?
    !current_user.nil?
  end

  #ユーザーのセッションの永続化
  def remember(user)
    user.remember #モデルで定義したメソッド、トークンをハッシュしてDBに保存
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
end
