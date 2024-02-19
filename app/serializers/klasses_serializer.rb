class KlassesSerializer < ActiveModel::Serializer
  attributes :id, :school_id, :number, :letter, :students_count
end
