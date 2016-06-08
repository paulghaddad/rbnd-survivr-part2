require_relative "game"
require_relative "tribe"
require_relative "contestant"
require_relative "jury"

#After your tests pass, uncomment this code below
#=========================================================
# # Create an array of twenty hopefuls to compete on the island of Borneo
@contestants = %w(carlos walter aparna trinh diego juliana poornima juha sofia julia fernando dena orit colt zhalisa farrin muhammed ari rasha gauri)
@contestants.map!{ |contestant| Contestant.new(contestant) }.shuffle!

# Create two new tribes with names
@coyopa = Tribe.new(name: "Pagong", members: @contestants.shift(10))
@hunapu = Tribe.new(name: "Tagi", members: @contestants.shift(10))
#
# Create a new game of Survivor
@borneo = Game.new(@coyopa, @hunapu)
#=========================================================


#This is where you will write your code for the three phases
def phase_one(game)
  8.times do
    losing_tribe = tribe_for_tribal_council(game)
    immune_contestant = immune_contestant_from_losing_tribe(losing_tribe)
    eliminated_contestant = tribal_council(losing_tribe, immune_contestant)
    eliminate_contestant(losing_tribe, eliminated_contestant)
  end
end

def phase_two(game)
  merged_tribe = game.tribes.first

  3.times do
    contestents_eligible_for_elimination = merged_tribe.members.reject do |contestant|
      contestant == immune_contestant_from_merged_tribe(game)
    end

    eliminated_contestant = contestents_eligible_for_elimination.sample
    eliminate_contestant(merged_tribe, eliminated_contestant)
  end
end

def phase_three(game, jury)
  merged_tribe = game.tribes.first

  7.times do
    contestents_eligible_for_elimination = merged_tribe.members.reject do |contestant|
      contestant == immune_contestant_from_merged_tribe(game)
    end

    eliminated_contestant = contestents_eligible_for_elimination.sample
    jury.add_member(eliminated_contestant)
    merged_tribe.members.delete(eliminated_contestant)
  end
end

def tribal_council(losing_tribe, immune_contestant)
  losing_tribe.tribal_council(immune: immune_contestant)
end

def immune_contestant_from_losing_tribe(tribe)
  tribe.members.sample
end

def immune_contestant_from_merged_tribe(game)
  game.individual_immunity_challenge
end

def tribe_with_immunity(game)
  game.immunity_challenge
end

def tribe_for_tribal_council(game)
  tribe_with_immunity = tribe_with_immunity(game)

  game.tribes.reject do |tribe|
    tribe == tribe_with_immunity
  end.first
end

def eliminate_contestant(tribe, contestant)
  tribe.members.delete(contestant)
end

# If all the tests pass, the code below should run the entire simulation!!
#=========================================================
phase_one(@borneo) #8 eliminations
@merge_tribe = @borneo.merge("Cello") # After 8 eliminations, merge the two tribes together
phase_two(@borneo) #3 more eliminations
@jury = Jury.new
phase_three(@borneo, @jury) #7 eliminations become jury members
finalists = @merge_tribe.members #set finalists
vote_results = @jury.cast_votes(finalists) #Jury members report votes
@jury.report_votes(vote_results) #Jury announces their votes
puts "#{@jury.announce_winner(vote_results)} is the winner!" #Jury announces final winner
