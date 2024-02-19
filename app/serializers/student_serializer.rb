class StudentSerializer < ActiveModel::Serializer
  attributes :id, :klass_id, :first_name, :last_name, :sur_name
end
