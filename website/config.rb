set :base_url, "https://www.terraform.io/"

activate :hashicorp do |h|
  h.name        = "terraform"
  h.version     = "0.6.7"
  h.github_slug = "hashicorp/terraform"
end

activate :relative_assets
set :relative_links, true
set :strip_index_file, false
