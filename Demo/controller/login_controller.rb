require_relative "../model/user"

class LoginController
  # Método para autenticar un usuario con su email y contraseña
  def authenticate(email, password)
    User.authenticate(email, password)
  end

  # Método para obtener un usuario por su email
  def getUserByEmail(email)
    User.where(email: email).first
  end
end