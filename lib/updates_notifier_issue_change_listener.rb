require 'rubygems'

class UpdatesNotifierIssueChangeListener < Redmine::Hook::Listener
  def controller_issues_edit_after_save(context={})
    if context[:issue]
      id= context[:issue].id
      UpdatesNotifier.send_issue_update(User.current.login, id)
    end
  end
end

