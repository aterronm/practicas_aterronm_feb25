require 'sequel'
require 'yaml'

# Cargar la configuración de la base de datos desde un archivo YAML
file_path = File.expand_path('database.yml', __dir__)
if File.exist?(file_path)
  puts "El archivo #{file_path} existe."
else
  puts "El archivo #{file_path} no existe."
end

# Leer la configuración del entorno de desarrollo
config = YAML.load_file(file_path)['development']
puts "📂 Configuration loaded..."
puts "📋 Database: #{config['database']}"
puts "👤 User: #{config['user']}"
puts "🔑 Password: #{config['password']}"
puts "🌐 Host: #{config['host']}"

# Conexión a la base de datos con manejo de errores
begin
  DB = Sequel.connect(
    adapter: 'postgres',
    host: config['host'],
    database: config['database'],
    user: config['user'],
    password: config['password']
  )
  puts "✅ Successfully connected to the database."

rescue Sequel::DatabaseConnectionError => e
  # Manejo de error si la base de datos no existe
  if e.message.include?("database \"#{config['database']}\" does not exist")
    puts "❌ Database does not exist. Creating database..."
    system("psql -U #{config['user']} -h #{config['host']} -f dbSQL.sql")
    retry
  else
    puts "❌ Failed to connect to the database: #{e.message}"
    exit(1) # Salir del script con un código de error
  end
end

# Método para cerrar la conexión a la base de datos
def close_connection
  DB.disconnect if DB
  puts "❌ Database connection closed."
end

# Asegurarse de que la conexión se cierre al salir
at_exit do
  close_connection
end

# Método para obtener la conexión a la base de datos
def get_connection
  DB
end