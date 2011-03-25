require 'rubygems'
require 'httpclient'
require 'json'

class UpdatesNotifier < ActiveRecord::Base
  def self.send_issue_update(userLogin, issueId, journal)
    changes = []
    journal.details.each do |j|
      changes.push({
        "property" => j.prop_key,
        "value" => j.value
      })
    end
    post_to_server({
        "type" => "issue",
        "user" => userLogin,
        "issue" => issueId,
        "changes" => changes.to_json,
    })
  end
private
  def self.callback_url()
    return Setting.plugin_redmine_updates_notifier[:callback_url]
  end
  def self.post_to_server(data)
    client = HTTPClient.new
    client.debug_dev = STDOUT if $DEBUG
    resp = client.post(self.callback_url, data)
    return resp
  end
end
