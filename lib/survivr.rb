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
  eliminated_contestants = 0
  8.times do
    tribe_with_immunity = game.immunity_challenge
    tribe_for_tribal_council = game.tribes.reject do |tribe|
      tribe == tribe_with_immunity
    end

    eliminated_contestant = tribe_for_tribal_council[0].members.sample
    tribe_for_tribal_council[0].members.delete(eliminated_contestant)
    eliminated_contestants += 1
  end
  eliminated_contestants
end

def phase_two(game)
  merged_tribe = game.tribes.first
  eliminated_contestants = 0
  3.times do
    immune_contestant = game.individual_immunity_challenge
    contestents_eligible_for_elimination = merged_tribe.members.reject do |contestant|
      contestant == immune_contestant
    end

    eliminated_contestant = contestents_eligible_for_elimination.sample
    merged_tribe.members.delete(eliminated_contestant)
    eliminated_contestants += 1
  end
  eliminated_contestants
end

def phase_three(game, jury)
  merged_tribe = game.tribes.first
  eliminated_contestants = 0
  7.times do
    immune_contestant = game.individual_immunity_challenge
    contestents_eligible_for_elimination = merged_tribe.members.reject do |contestant|
      contestant == immune_contestant
    end

    eliminated_contestant = contestents_eligible_for_elimination.sample
    jury.add_member(eliminated_contestant)
    merged_tribe.members.delete(eliminated_contestant)
    eliminated_contestants += 1
  end
  eliminated_contestants
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
