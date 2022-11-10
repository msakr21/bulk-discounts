require 'httparty'
require 'json'


class GitRepo

  def call(url)
    HTTParty.get(url)
  end

  def repo_name
    response = call("https://api.github.com/repos/kenzjoy/little-esty-shop")
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[:name]
  end

  def usernames
    response = call("https://api.github.com/repos/kenzjoy/little-esty-shop/assignees")
    if response["message"].nil?
      parsed = JSON.parse(response.body, symbolize_names: true)
      parsed.map do |user|
        user[:login]
      end
    end
  end

  def commits_by_contributors
    response = call("https://api.github.com/repos/kenzjoy/little-esty-shop/stats/contributors")
    if response["message"].nil?
      parsed = JSON.parse(response.body, symbolize_names: true)
      contributor_commit_totals = {}
      parsed.each do |record|
        contributor_commit_totals[record[:author][:login]] = record[:total]
      end
      contributor_commit_totals
    end
  end

  def number_of_pull_requests
    response = call("https://api.github.com/repos/kenzjoy/little-esty-shop/pulls?state=all")
    if response["message"].nil?
      parsed = JSON.parse(response.body, symbolize_names: true)
      parsed.first[:number]
    end
  end
end
