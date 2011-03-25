require 'rubygems'

class UpdatesNotifierIssueChangeListener < Redmine::Hook::Listener
  def controller_issues_edit_after_save(context={})
    if context[:issue] and context[:journal]
      UpdatesNotifier.send_issue_update(User.current.login, context[:issue].id, context[:journal])
    end
  end
end

