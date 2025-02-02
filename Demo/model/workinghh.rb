require_relative "../config/database.rb"

#Solamente se traer la estructura del modelo (tabla) de la base de datos
class WorkingHour < Sequel::Model(:work_hours)
end