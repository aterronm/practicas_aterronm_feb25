require 'bundler/inline'

# Verifica si Ruby está instalado
unless system('ruby -v')
  puts "❌ Ruby no está instalado. Por favor, instala Ruby para continuar."
  exit(1)
else
  puts "✅ Ruby está instalado."
end

# Verifica si Bundler está instalado
unless system('bundle -v')
  puts "❌ Bundler no está instalado. Instalando Bundler..."
  system('gem install bundler')
else
  puts "✅ Bundler está instalado."
end

# Inicializa el proyecto con Bundler si no existe el archivo Gemfile
unless File.exist?('Gemfile')
  puts "Initializing Bundler..."
  system('bundle init')
end

# Define las gemas necesarias en el Gemfile
gemfile(true) do
  source 'https://rubygems.org'
  gem 'sequel'
  gem 'pg'
  gem 'glimmer-dsl-libui'
  gem 'yaml'
end

# Instala las gemas necesarias solo si no están ya instaladas
puts "Verificando e instalando gemas necesarias..."
system('bundle check || bundle install')

# Requiere los archivos necesarios
require_relative 'config/database' # Asegúrate de que la conexión a la base de datos esté configurada
require_relative 'view/login'      # Requiere el archivo de la vista de inicio de sesión

# Ejecuta la aplicación llamando a la vista de inicio de sesión
LoginView.new