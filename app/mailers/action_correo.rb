class ActionCorreo < ApplicationMailer

  def new_registered_user(user)
    @user = user
    mail(to: @user.email, subject: "Registro en Mandados Delivery")
  end

  def edit_registered_user(user)
    @user = user
    mail(to: @user.email, subject: "Corregido Registro en Mandados Delivery")
  end

  def active_new_user(user)
    @user = user
    mail(to: @user.email, subject: "Bienvenido a Mandados Delivery")
  end

end
