class GithubService

  def repo
    get_url("")
  end

  def contributors
    get_url("/contributors")
  end

  def commits
    get_url("/commits?per_page=100")
  end

  def pull_requests
    get_url("/pulls?state=closed&per_page=100")
  end

  def get_url(url)
    response = HTTParty.get("https://api.github.com/repos/Sierra-T-9598/little-esty-shop#{url}")

    JSON.parse(response.body, symbolize_names: true)
  end

end
