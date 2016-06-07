require "pry"
class Game
  attr_reader :merged_tribe
  attr_accessor :tribes

  def initialize(*tribes)
    @tribes = tribes
  end

  def add_tribe(tribe)
    tribes << tribe
  end

  def immunity_challenge
    tribes.sample
  end

  def clear_tribes
    @tribes = []
  end

  def merge(merged_tribe_name)
    merged_tribe = Tribe.new(name: merged_tribe_name, members: all_game_contestants)
    clear_tribes
    add_tribe(merged_tribe)
    merged_tribe
  end

  def individual_immunity_challenge
    tribes.first.members.sample
  end

  private

  def all_game_contestants
    tribes.inject([]) do |members, tribe|
      members += tribe.members
    end
  end
end
