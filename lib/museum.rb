class Museum
  attr_reader :name, :exhibits, :patrons, :exhibit_by_interest

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
    @exhibit_by_interest = {}
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    interests = patron.interests

    interests.flat_map do |interest|
      @exhibits.find_all do |exhibit|
        exhibit.name == interest
      end
    end
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interests(patron)

    recommend_exhibits(patron).reduce({}) do |exhibit_by_interest, exhibit|
      @exhibit_by_interest[exhibit] = patron
      @exhibit_by_interest
    end

  end

end
