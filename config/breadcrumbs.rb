crumb :items do
  link "メルカリ", items_path
end

crumb :item do |item|
  link "#{item.name}", item_path(item)
  parent :items
end

crumb :users do
  link "メルカリ", users_path
end

crumb :user do |user|
  link "マイページ", users_path(user)
  parent :users
end

crumb :profile_user do |user|
  link "プロフィール", users_path(user)
  parent :users
end

crumb :credit_card do |credit|
  link "支払い方法", users_path(credit)
  parent :user
end

crumb :new_credit do |credit|
  link "クレジットカード情報入力", users_path(credit)
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
