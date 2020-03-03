# frozen_string_literal: true

require 'time'
require 'pry'
require 'roko/source/github/report_events'
require 'roko/source/google_calendar/report_events'
require 'roko/source/slack/report_events'
require_relative 'configurable'

module Roko
  module Source
    # daily report events from several sources
    module Events
      extend Configurable

      class << self
        def github
          Github::ReportEvents.new(self).fetch
        end

        def google_calendar
          GoogleCalendar::ReportEvents.new(self).fetch
        end

        def slack
          Slack::ReportEvents.new(self).fetch
        end

        def all
          github_events = github
          google_calendar_events = google_calendar
          slack_events = slack
          (github_events + google_calendar_events + slack).sort_by(&:created_at)
        end
      end
    end
  end
end