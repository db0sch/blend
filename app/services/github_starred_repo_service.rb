class GithubStarredRepoService
  def initialize(user)
    @user = user
    @client = Octokit::Client.new(access_token: user.token, auto_paginate: true)
    @user_github = @client.user
  end

  def fetch_and_store
    repos = fetch_starred_repos
    store_stars(repos)
  end

  def fetch_starred_repos
    @client.starred @user_github.login
  end

  def store_stars(repos)
    repos.each do |repo|
      if github_star = GithubStar.find_by_repo_id(repo.id)
        github_star.update({
            name: repo.name,
            full_name: repo.full_name,
            html_url: repo.html_url,
            description: repo.description,
            homepage: repo.homepage
          })
      else
        GithubStar.create({
          user: @user,
          repo_id: repo.id,
          name: repo.name,
          full_name: repo.full_name,
          html_url: repo.html_url,
          description: repo.description,
          homepage: repo.homepage
          })
      end
    end
  end
end
