class Commit

  attr_reader :commit_id,
              :commit_author

  def initialize(data)
    @commit_id = data[:sha]
    @commit_author = data[:author][:login]
  end
end
