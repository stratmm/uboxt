module GitHub
  class Client
    attr_accessor :user_name, :github

    def initialize(user_name)
      @user_name = user_name
      @github = ::Octokit::Client.new(:login => ENV['GITHUB_USER'], :password => ENV['GITHUB_PASSWORD'])
    end

    def user
      github.user(user_name).to_h
    end

    def repositories
      repos = github.repositories([user_name], per_page: 100)
      repos.concat github.last_response.rels[:next].get.data if github.last_response.rels[:next]
      repos.to_a
    end

    def language_count
      repos = repositories
      languages = repos.map {|repo| repo[:language] }
      language_count = Hash[languages.each_with_object(Hash.new(0)) { |language, counts| counts[language] += 1 }.sort_by{ |k, v| v * -1 }]
    end
  end
end
