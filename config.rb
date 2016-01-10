page "*", :layout => "/_layouts/main"
page "CNAME", layout: false

require_relative "./lib/build_cleaner"

helpers do
  def is_page_current(page)
    current_page.url.index(page) != nil
  end

  def is_page_current_exact(page)
    current_page.url == page
  end
end

config[:css_dir] = 'css'
config[:js_dir] = 'js'
config[:images_dir] = 'img'

activate :directory_indexes

configure :build do
  activate :minify_css
  activate :minify_javascript

  activate :build_cleaner

  # Append a hash to asset urls (make sure to use the url helpers)
  #activate :asset_hash
end


activate :deploy do |deploy|
  deploy.method = :git
  deploy.build_before = true
  # Optional Settings
  deploy.remote   = 'git@github.com:mindpeace/mindpeace.github.io.git'
  deploy.branch   = 'master'
  # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
  deploy.commit_message = 'timestamp'
end