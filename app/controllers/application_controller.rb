class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
  around_filter :set_tz
  around_filter :atomic_posts
  # before_filter :allow_me

  private
  def atomic_posts
    if request.method == 'GET' || !current_user
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
      current_user.update(:locale => params[:locale]) if current_user
    elsif current_user && current_user.locale
      I18n.locale = current_user.locale
    elsif cookies[:locale]
      I18n.locale = cookies[:locale]
    else
      lookup = GEOIP.lookup(request.ip)
      I18n.locale = cookies.permanent[:locale] = guess_locale_from_country_code(lookup.country.iso_code)
    end
  end

  def guess_locale_from_country_code code
    if code == 'JP'
      'ja'
    else
      'en'
    end
  end

  def set_tz
    if params[:tz]
      tz = cookies.permanent[:tz] = params[:tz]
      current_user.update(:tz => params[:tz]) if current_user
    elsif current_user && current_user.tz
      tz = current_user.tz
    elsif cookies[:tz]
      tz = cookies[:tz]
    else
      lookup = GEOIP.lookup(request.ip)
      tz = guess_tz_from_country_code(lookup.country.iso_code)
    end
    Time.use_zone tz do
      yield
    end
  end

  def guess_tz_from_country_code code
    if code == 'JP'
      'Tokyo'
    else
      'UTC'
    end
  end

end
