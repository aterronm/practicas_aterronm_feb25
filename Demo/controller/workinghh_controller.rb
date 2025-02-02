require_relative "../model/workinghh"

class WorkinghhController
  # Método para obtener todas las horas de trabajo
  def fetch_all_working_hours
    WorkingHour.all
  end

  # Método para crear una nueva hora de trabajo con los atributos dados
  def create_working_hour(attributes)
    working_hour = WorkingHour.new(attributes)
    if working_hour.save
      true
    else
      working_hour.errors.full_messages
    end
  end

  # Método para actualizar una hora de trabajo existente por su ID con los atributos dados
  def update_working_hour(id, attributes)
    working_hour = WorkingHour[id]
    if working_hour
      if working_hour.update(attributes)
        true
      else
        working_hour.errors.full_messages
      end
    else
      ['Working hour not found']
    end
  end

  # Método para encontrar una hora de trabajo por email y fecha
  def find_working_hour_by_email_and_date(email, date)
    WorkingHour.where(employeeEmail: email, date: date).first
  end

  # Método para eliminar una hora de trabajo por su ID
  def delete_working_hour(id)
    working_hour = WorkingHour[id]
    working_hour.destroy if working_hour
  end
end