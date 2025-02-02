require_relative "../model/person"

class PersonController
  # Método para obtener todas las personas
  def fetch_all_people
    Person.all
  end

  # Método para crear una nueva persona con los atributos dados
  def create_person(attributes)
    person = Person.new(attributes)
    if person.save
      true
    else
      person.errors.full_messages
    end
  end

  # Método para actualizar una persona existente por su ID con los atributos dados
  def update_person(id, attributes)
    person = Person[id]
    if person
      if person.update(attributes)
        true
      else
        person.errors.full_messages
      end
    else
      ['Person not found']
    end
  end
end