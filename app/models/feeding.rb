class Feeding < DataPoint
  def pounds
    quantity
  end

  def feed_type
    data_type
  end

  def to_s
    feed_type_s = feed_type && " of #{feed_type}"
    "#{occurred_on.to_date.to_s} fed #{pounds} pounds#{feed_type_s}"
  end
end
