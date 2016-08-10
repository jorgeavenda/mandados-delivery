class ActionCorreo < ApplicationMailer

  def new_registered_user(user)
    @user = user
    mail(to: "mandados.com.ve@gmail.com", subject: "Registro Nro.  #{@user.id}  #{@user.buyer_info.fullname}")
  end

  def active_new_user(user)
    @user = user
    mail(to: @user.email, subject: "Bienvenido a Mandados")
  end

end
