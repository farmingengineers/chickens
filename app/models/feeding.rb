class Feeding < DataPoint
  def to_s
    "#{occurred_on.to_date.to_s} fed #{quantity} pounds"
  end
end
