class Feeder < Bookkeeper

  protected

  def quantity_param
    :pounds
  end

  def data_association
    flock.feedings
  end

end