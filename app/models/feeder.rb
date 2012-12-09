class Feeder < Bookkeeper

  protected

  def base_attrs params
    super.merge :data_type_id => params[:data_type_id]
  end

  def quantity_param
    :pounds
  end

  def data_association
    flock.feedings
  end

end
