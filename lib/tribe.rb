class Tribe
  attr_reader :name, :members, :immune_member

  def initialize(options = {})
    @name = options.fetch(:name)
    @members = options.fetch(:members)
    print_tribe_membership
  end

  def print_tribe_membership
    puts "A new tribe, #{name}, has been created:"
    puts members
  end

  def to_s
    name
  end

  def tribal_council(immune:)
    @immune_member = immune
    members_not_immune.sample
  end

  private

  def members_not_immune
    members.reject do |member|
      member == immune_member
    end
  end
end
