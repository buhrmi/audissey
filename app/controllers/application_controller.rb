class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
  # before_filter :allow_me

  private
  def atomic_posts
    if request.method == 'GET'
      yield
    else
      ActiveRecord::Base.transaction do
        User.where(:id => current_user).lock(true).first
        yield
      end
    end
  end

  def atomic
    ActiveRecord::Base.transaction do
      User.where(:id => current_user).lock(true).first
      yield
    end
  end

  def allow_me
    cookies.permanent[:allowed] = true if params[:i_am_awesome]
    if params[:action] != 'landing' && !cookies[:allowed]
      redirect_to :root, :notice => "Not ready yet. Please check back soon."
    end
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def set_locale
    if params[:locale]
      I18n.locale = cookies.permanent[:locale] = params[:locale]
    elsif current_user
      # TODO: save/get locale in user
    elsif cookies[:locale]
      I18n.locale = cookies[:locale]
    else
      I18n.locale = I18n.default_locale # TODO: take locale from geoip
    end
  end

end
