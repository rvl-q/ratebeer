class Place < OpenStruct
  def self.rendered_fields
    [:name, :id, :status, :street, :city, :zip, :country, :overall]
  end
end
