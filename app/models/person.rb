class Person < ApplicationRecord

  belongs_to :department, optional: true
  belongs_to :location, optional: true
  belongs_to :person, optional: true

  has_many :items, :foreign_key => "used_by", :class_name => "Item"


  has_many :activity_logs, as: :element
  has_many :attachments, as: :element


  STATUS_ACTIVE = 1
  STATUS_INACTIVE = 2

  PERSON_EMPLOYEE      = 'EMPLEADO'
  PERSON_STUDENT       = 'ESTUDIANTE'
  PERSON_CATEDRA       = 'CATEDRA'
  PERSON_POSTDOCTORATE = 'POSTDOCTORADO'
  PERSON_INTERNSHIP    = 'PRACTICANTE'
  PERSON_OUTSOURCED    = 'HONORARIOS'
  PERSON_PROJECT       = 'PROYECTO'

  PERSON_TYPES = {
    PERSON_EMPLOYEE => 'Empleado',
    PERSON_STUDENT => 'Estudiante',
    PERSON_CATEDRA => 'Catedras',
    PERSON_POSTDOCTORATE => 'Post Doctorado',
    PERSON_INTERNSHIP => 'Practicante',
    PERSON_OUTSOURCED => 'Honorarios',
    PERSON_PROJECT => 'Por Proyecto'
  }

  FIELDS = {
    'first_name' => 'Nombre',
    'last_name' => 'Apellido Paterno',
    'last_name2' => 'Apellido Materno',
    'title' => 'Título',
    'phone' => 'Identificador',
    'location_id' => 'Ubicación',
    'department_id' => 'Departamento',
    'person_id' => 'Reporta a',
    'person_type' => 'Tipo',
    'identificator' => 'Identificador'
  }

  def field_text(f)
    if FIELDS[f]
      v = FIELDS[f]
    else 
      v = f
    end
    return v 
  end

  def full_name
    fn  = '' + first_name rescue '--'
    ln1 = '' + last_name rescue ' '
    ln2 = '' + last_name2 rescue ' '
  	fn + ' ' + ln1 + ' ' + ln2
  end

  def full_name_with_title
    t = '' + title rescue ''
    t + ' ' + full_name
  end

  def picture_url
    "https://cimav.edu.mx/foto/#{email.split('@')[0]}/1024" rescue 'https://cimav.edu.mx/foto/desconocido/1024'
  end
end
