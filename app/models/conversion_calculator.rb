module ConversionCalculator
  def conversion data
    e = data[:eggs]
    f = data[:feed]
    if e > 0
      if f > 0
        (e / 12.0) / (f / 50.0)
      else
        'inf'
      end
    else
      if f > 0
        0
      else
        nil
      end
    end
  end
end
