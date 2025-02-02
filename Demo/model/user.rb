# Requiere el archivo de configuración de la base de datos
require_relative "../config/database.rb"

# Definición de la clase User que hereda de Sequel::Model
class User < Sequel::Model(:login)
  # Método de clase para autenticar un usuario con su email y contraseña
  def self.authenticate(email, password)
    user = where(email: email, password: password).first
    !user.nil?
  end
end