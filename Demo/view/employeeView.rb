require 'glimmer-dsl-libui'
require_relative '../controller/workinghh_controller'

class EmployeeView
  include Glimmer

  attr_accessor :working_hours, :date, :entry_time, :exit_time, :employeeEmail

  def initialize(user_credentials = {})
    @user_credentials = user_credentials # email y password
    @controller = WorkinghhController.new
    @working_hours = fetch_working_hours_from_db
  end

  def fetch_working_hours_from_db
    @controller.fetch_all_working_hours.select { |wh| wh.employeeEmail == @user_credentials[:email] }
  end

  def launch
    window("#{@user_credentials[:email]} (Employee)", 400, 300, true) {
      margined false

      vertical_box {
        table {
          text_column('Date')
          text_column('Entry Time')
          text_column('Exit Time')

          cell_rows <= [self, :working_hours, column_attributes: {
            'Date' => :date,
            'Entry Time' => :entry_time,
            'Exit Time' => :exit_time
          }]
        }

        horizontal_box {
          button('Add Entry') {
            stretchy true
            on_clicked do
              attributes = {
                employeeEmail: @user_credentials[:email],
                date: date,
                entry_time: entry_time,
                exit_time: nil
              }
              result = @controller.create_working_hour(attributes)
              if result == true
                @working_hours = fetch_working_hours_from_db
                self.working_hours = @working_hours # Actualiza la tabla
                msg_box('Add', 'Entry added successfully')
              else
                msg_box_error('Error', result.join(', '))
              end
            end
          }

          button('Add Exit') {
            stretchy true
            on_clicked do
              working_hour = @controller.find_working_hour_by_email_and_date(@user_credentials[:email], date)
              if working_hour
                attributes = {
                  exit_time: exit_time
                }
                result = @controller.update_working_hour(working_hour.id, attributes)
                if result == true
                  @working_hours = fetch_working_hours_from_db
                  self.working_hours = @working_hours # Actualiza la tabla
                  msg_box('Add', 'Exit added successfully')
                else
                  msg_box_error('Error', result.join(', '))
                end
              else
                msg_box_error('Error', 'No entry found for the given date')
              end
            end
          }
        }
      }
    }.show
  end
end

