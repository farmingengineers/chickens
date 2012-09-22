class EggCollector < Bookkeeper

  protected

  def quantity_param
    :eggs
  end

  def data_association
    flock.egg_collections
  end

end
