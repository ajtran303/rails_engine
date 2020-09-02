class RevenueSerializer
  def initialize(revenue)
    @revenue = revenue
  end

  def to_h
    {
      data: {
        id: nil,
        attributes: {
          revenue: @revenue
        }
      }
    }
  end
end
