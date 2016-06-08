class Jury
  attr_accessor :members

  def initialize
    @members = []
  end

  def add_member(jury_member)
    members << jury_member
  end

  def cast_votes(finalists)
    members.inject(Hash.new(0)) do |finalist_votes, jury_member|
      vote = cast_vote(finalists)
      finalist_votes[vote] += 1

      finalist_votes
    end
  end

  def report_votes(finalist_votes)
    finalist_votes.each do |finalist, votes|
      puts "Jury votes for #{finalist}: #{votes}"
    end
  end

  def announce_winner(finalist_votes)
    member_with_most_votes(finalist_votes)
  end

  private

  def cast_vote(finalists)
    vote = finalists.sample
    puts vote
    vote
  end

  def member_with_most_votes(finalist_votes)
    finalist_votes.max_by do |finalist, votes|
      votes
    end.first
  end
end
