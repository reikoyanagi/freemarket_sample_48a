# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  prepend_before_action :check_captcha, only: [:tel]
  prepend_before_action :customize_sign_up_params, only: [:tel]

  def registration
    @user = User.new(session[:user])
    nickname = @user.nickname
    email = @user.email

  end

  def tel

    session[:nickname] = params[:session][:nickname]
    session[:email] = params[:session][:email]
    session[:password] = params[:session][:password]
    session[:password_confirmation] = params[:session][:password_confirmation]
    session[:last_name] = params[:session][:last_name]
    session[:first_name] = params[:session][:first_name]
    session[:last_name_kana] = params[:session][:last_name_kana]
    session[:first_name_kana] = params[:session][:first_name_kana]

    # 誕生日
    birth_year = params[:session][:birth_year].to_i
    birth_month = params[:session][:birth_month].to_i
    birth_day = params[:session][:birth_day].to_i
    unless birth_year == 0 || birth_month == 0 || birth_day == 0
      session[:birth_date] = Date.new(birth_year, birth_month , birth_day)
    end
  end

  def address
    session[:phone_number] = params[:session][:phone_number]
  end

  def credit
    session[:post_code] = params[:session][:post_code]
    session[:prefecture_id] = params[:session][:prefecture_id]
    session[:city] = params[:session][:city]
    session[:block] = params[:session][:block]
    session[:building] = params[:session][:building]
  end


  def done
  end

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create

    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      last_name: session[:last_name],
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana],
      birth_date: session[:birth_date]
      )

    @user.address = @user.build_address(
      post_code: session[:post_code],
      prefecture_id: session[:prefecture_id],
      phone_number: session[:phone_number],
      post_code: session[:post_code],
      city: session[:city],
      block: session[:block],
      building: session[:building]
      )


    @user.save
    @user.address.save


    #Snsログインのデータを保存
    SnsCredential.create(
      uid: session[:uid],
      provider: session[:provider],
      user_id: @user.id
      )


    #Payjp保存
    Payjp.api_key = 'sk_test_0ed9e660871befcb2421e447'
    customer = Payjp::Customer.create(
      card: params['payjp-token'],
      )
    @credit = CreditCard.new(user_id: @user.id, customer_id: customer.id, card_id: customer.default_card)
    @credit.save


    #deviseで新規登録を行うと自動でアカウントが切り替わる問題解決
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(@user, current_user)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      render action: :registration
      clean_up_passwords resource
      set_minimum_password_length
    end

  end

  private

  def customize_sign_up_params
    devise_parameter_sanitizer.permit :sign_up, keys: [:username, :email, :password, :password_confirmation, :remember_me]
  end

  def check_captcha
    self.resource = resource_class.new sign_up_params
    resource.validate
    unless verify_recaptcha(model: resource)
      respond_with_navigational(resource) { render :registration }
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end


  # The path used after sign up.
  def after_sign_up_path_for(resource)
    sign_up_done_path
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    sign_up_done_path
  end
end
