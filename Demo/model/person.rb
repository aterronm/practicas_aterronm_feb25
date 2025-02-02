# Requiere el archivo de configuración de la base de datos
require_relative "../config/database.rb"

# Definición de la clase Person que hereda de Sequel::Model
class Person < Sequel::Model(:person)
  # Aquí puedes definir métodos adicionales si es necesario
end

=begin
Este archivo necesita poco código porque `Sequel::Model`
proporciona automáticamente métodos para interactuar con la base de datos, como `create`, `update`, `delete`, y `find`. Al heredar de `Sequel::Model`, la clase `Person` obtiene estos métodos sin necesidad de definirlos explícitamente.
=end


