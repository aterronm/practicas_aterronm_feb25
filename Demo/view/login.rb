require 'glimmer-dsl-libui'
require_relative '../controller/login_controller'
require_relative '../view/administratorView'
require_relative '../view/employeeView'

class LoginView
  include Glimmer

  attr_reader :user_credentials

  def initialize
    @controller = LoginController.new
    @user_credentials = {}
    create_ui
  end

  def create_ui
    @main_window = window('Login', 450, 200) do
      margined true
      resizable false

      vertical_box do

        form do
          stretchy false

          @email_entry = entry {
            label 'Email:'
          }

          @password_entry = password_entry {
            label 'Password:'
          }
        end

        vertical_box do
          button('Login') do
            stretchy false
            on_clicked do
              email = @email_entry.text
              password = @password_entry.text
              
              if @controller.authenticate(email, password)
                user = @controller.getUserByEmail(email)  
                msg_box('Éxito', 'Inicio de sesión correcto')
                @user_credentials = { email: email, password: password, type: user[:type] }
                load_people_management_view
              else
                msg_box_error('Error', 'Usuario o contraseña incorrectos')
              end
            end
          end

        end
      end

      on_closing do
        puts 'Window is closing'
        exit
        true # Return true to allow the window to close
      end
    end.show
  end

  def load_people_management_view
    if @user_credentials[:type] == 'Admin' 
    AdminManagement.new(@user_credentials).launch.show
    else
     EmployeeView.new(@user_credentials).launch.show
    end
  end
end

LoginView.new