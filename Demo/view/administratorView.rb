require 'glimmer-dsl-libui'
require_relative '../controller/person_controller'
require_relative '../controller/workinghh_controller'

class AdminManagement
  include Glimmer

  attr_accessor :people, :working_hours, :full_name, :birth_date, :dni, :genre, :email, :entry_date, :exit_date, :active, :filter_value

  def initialize(user_credentials = {})
    @user_credentials = user_credentials #email y password

    @controller = PersonController.new
    @people = fetch_data_from_db
    @unfiltered_people = @people.dup
    @edited_rows = {} # Inicializa @edited_rows como un hash vacío

    @WorkinghhController = WorkinghhController.new
    @working_hours = fetch_working_hours_from_db

  end

  # Método para obtener los datos de las personas desde la base de datos
  def fetch_data_from_db
    people = @controller.fetch_all_people.sort_by { |person| person[:id] }.reverse
    highest_id_person = people.first
    oldest_person = people.last
    people.reject { |person| person[:email] == @user_credentials[:email] }.map do |person|
      name = "#{person[:first_name]} #{person[:last_name]}"
      name += " (LAST)" if person == highest_id_person
      name += " (FIRST)" if person == oldest_person
      [
        person[:id],
        name,
        person[:birth_date],
        person[:dni],
        person[:genre],
        person[:email],
        person[:entry_date],
        person[:exit_date],
        person[:active]
      ]
    end
  end

  # Método para obtener las horas de trabajo desde la base de datos
  def fetch_working_hours_from_db
    working_hours = @WorkinghhController.fetch_all_working_hours.sort_by { |wh| wh[:id] }.reverse
    working_hours.map do |wh|
      [
        wh[:id],
        wh[:employeeEmail],
        wh[:date],
        wh[:entry_time],
        wh[:exit_time]
      ]
    end
  end

  # Método para lanzar la interfaz de usuario
  def launch
    window("#{@user_credentials[:email]} (ADMINISTRATOR)", 800, 600, true) {
      margined false 
       # Se reduce el margen interno de la ventana

      tab { 
        
      # Tab para crear nuevo empleado
        tab_item("🆕 New Employee") {
          vertical_box {

            # Se eliminó el bloque 'area' y text label que mostraba el titulo de la seccion
            # ya que generaba un espacio adicional

            button('ℹ️ Complete the information for the new employee. Do not forget to fill in all the fields.') {
              stretchy false
              enabled false
            }

            form {
              stretchy true  # Permite que el formulario se ajuste y no empuje otros elementos

              entry {
                label 'Full Name'
                text <=> [self, :full_name]
              }

              entry {
                label 'Birth Date'
                text <=> [self, :birth_date]
              }

              entry {
                label 'DNI'
                text <=> [self, :dni]
              }

              entry {
                label 'Genre'
                text <=> [self, :genre]
              }

              entry {
                label 'Email'
                text <=> [self, :email]
              }

              entry {
                label 'Entry Date'
                text <=> [self, :entry_date]
              }

              entry {
                label 'Exit Date'
                text <=> [self, :exit_date]
              }

              checkbox {
                label 'Active'
                checked <=> [self, :active]
              }
            }
          

            button('💾 SAVE NEW EMPLOYEE DETAILS ') {
              stretchy false
              on_clicked do
                new_row = [full_name, birth_date, dni, genre, email, entry_date, exit_date, active]
                if [full_name, birth_date, dni, genre, email].map(&:to_s).include?('')
                msg_box_error('Validation Error!', 'All fields are required! Please make sure to enter a value for all fields.')
                else
                  begin
                    result = @controller.create_person(
                      first_name: full_name.split(' ').first,
                      last_name: full_name.split(' ').last,
                      birth_date: birth_date,
                      dni: dni,
                      genre: genre,
                      email: email,
                      entry_date: entry_date,
                      exit_date: exit_date,
                      active: active
                    )

                    if result == true
                      @people << new_row
                      @unfiltered_people = @people.dup

                      msg_box('Success!', 'Data has been successfully uploaded to the database!')

                      # Se limpian los campos luego de guardar exitosamente
                      self.full_name = ''
                      self.birth_date = ''
                      self.dni = ''
                      self.genre = ''
                      self.email = ''
                      self.entry_date = ''
                      self.exit_date = ''
                      self.active = false
                    else
                      msg_box_error('Database Error!', result.join("\n"))
                    end
                  rescue StandardError => e
                    msg_box_error('Unexpected Error!', "An error occurred: #{e.message}")
                  end
                end
              end
            }

            search_entry {
              stretchy false
              text <=> [self, :filter_value,
                after_write: ->(filter_value) {
                  @unfiltered_people ||= @people.dup
                  self.people = @unfiltered_people.dup
                  unless filter_value.empty?
                    self.people = @people.filter do |person|
                      person.any? { |attribute| attribute.to_s.downcase.include?(filter_value.downcase) }
                    end
                  end
                }
              ]
            }

            table {
              text_column('ID'){ editable false}
              text_column('Full Name')
              text_column('Birth Date')
              text_column('DNI')
              text_column('Genre')
              text_column('Email')
              text_column('Entry Date')
              text_column('Exit Date')
              checkbox_column('Active') {
                editable false
              }

              cell_rows <=> [self, :people]

              on_changed do |row, type, row_data|
                puts "Row #{row} #{type}: #{row_data}"
                $stdout.flush
              end

              on_edited do |row, row_data|
                puts "Row #{row} edited: #{row_data}"
                $stdout.flush
              end
            }
          }
        }

        #Tab para actualizar empleados
        tab_item("ℹ️ Update Employees") {
          vertical_box {

            # Se eliminó el bloque 'area' y text label que mostraba el titulo de la seccion
            # ya que generaba un espacio adicional

            button('ℹ️ Update any employee detail.') {
              stretchy false
              enabled false
            }

            search_entry {
              stretchy false
              text <=> [self, :filter_value,
                after_write: ->(filter_value) {
                  @unfiltered_people ||= @people.dup
                  self.people = @unfiltered_people.dup
                  unless filter_value.empty?
                    self.people = @people.filter do |person|
                      person.any? { |attribute| attribute.to_s.downcase.include?(filter_value.downcase) }
                    end
                  end
                }
              ]
            }

            table {

            editable true
            text_column('ID'){ editable false}
              text_column('Full Name')
              text_column('Birth Date')
              text_column('DNI'){ editable false}
              text_column('Genre')
              text_column('Email')
              text_column('Entry Date')
              text_column('Exit Date')
              checkbox_column('Active') {
                editable true
              }

              

              cell_rows <=> [self, :people]

              on_changed do |row, type, row_data|
                puts "Row #{row} #{type}: #{row_data}"
                $stdout.flush
              end

              on_edited do |row, row_data|
                puts "Row #{row} edited: #{row_data}"
                $stdout.flush
                # Store the edited row data temporarily
                @edited_rows[row] = row_data
              end
            }

            button('💾 SAVE ANY CHANGES') {
              stretchy false
              on_clicked do
                @edited_rows.each do |row, row_data|
                  if [row_data[1], row_data[2], row_data[3], row_data[4], row_data[5]].map(&:to_s).include?('')
                    msg_box_error('Validation Error!', 'Full Name, Birth Date, DNI, Genre, and Email are required! Please make sure to enter a value for all required fields.')
                    next
                  end

                  original_row = @people[row].dup # Store the original row data

                  begin
                    result = @controller.update_person(
                      row_data[0], # Pass the ID to the update_person method
                      first_name: row_data[1].split(' ').first,
                      last_name: row_data[1].split(' ').last,
                      birth_date: row_data[2],
                      dni: row_data[3],
                      genre: row_data[4],
                      email: row_data[5],
                      entry_date: row_data[6],
                      exit_date: row_data[7],
                      active: row_data[8]
                    )

                    if result != true
                      msg_box_error('Database Error!', result.join("\n"))
          self.people = @people.dup # Refresh the table data


                    else   msg_box('Success!', 'All changes have been successfully saved to the database!')

                    end
                  rescue StandardError => e
                    msg_box_error('Unexpected Error!', "An error occurred: #{e.message}")
                    self.people = @people.dup # Refresh the table data
                  end
                end
                @edited_rows.clear
              end
            }
          }

          
        }

# Tab para gestionar horas de trabajo
tab_item("🕰️ Working Hours") {
  vertical_box {
    button('🕰️ Employees Working Hours Management.') {
      stretchy false
      enabled false
    }

    table {
      editable false
      text_column('ID') { editable false }
      text_column('Person Email')
      text_column('Date')
      text_column('Entry Time')
      text_column('Exit Time')

      cell_rows <=> [self, :working_hours]

      
    }
  }
}

      }
    }.show
  end
end