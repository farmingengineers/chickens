class EggCollection < DataPoint
  def eggs
    quantity.try :to_i
  end

  def to_s
    "#{occurred_on.to_date.to_s} collected #{eggs} eggs"
  end
end
