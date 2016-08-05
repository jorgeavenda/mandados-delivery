class ActionCorreo < ApplicationMailer

  def new_registered_user(user)
    @user = user
    mail(to: "mandados.com.ve@gmail.com", subject: 'Registro de usuario')
  end
end
