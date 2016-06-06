require "pry"
class Game
  attr_reader :tribes

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
    Tribe.new(name: merged_tribe_name, members: all_game_contestants)
  end

  private

  def all_game_contestants
    tribes.inject([]) do |members, tribe|
      members += tribe.members
    end
  end
end
