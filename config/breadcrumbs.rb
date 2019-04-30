crumb :root do
  link "メルカリ", root_path
end

# crumb :items do
#   link "メルカリ", root_path
# end

crumb :item do |item|
  link "#{item.name}", item_path(item)
end

# crumb :users do
#   link "メルカリ", root_path
# end

crumb :users do |user|
  link "マイページ", user_path(current_user.id)
end

crumb :profile_user do |user|
  link "プロフィール", user_profile_path(current_user.id)
  parent :users
end

crumb :credit_card do |credit|
  link "支払い方法", user_show_credit_card_path(current_user.id)
  parent :users
end

crumb :new_credit do |credit|
  link "クレジットカード情報入力", user_new_credit_card_path(current_user.id)
  parent :credit_card
end


# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
