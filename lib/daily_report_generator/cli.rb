# frozen_string_literal: true

require 'thor'
require 'daily_report_generator/source/events'

module DailyReportGenerator
  class Cli < Thor
    package_name 'daily report generator'

    desc 'github', 'generate github daily report'
    def github
      DailyReportGenerator::Source::Events.setup
      github_events = DailyReportGenerator::Source::Events.github
      github_events.each { |event| puts event.oneline }
    end

    desc 'google_calendar', 'generate google calendar report'
    def google_calendar
      DailyReportGenerator::Source::Events.setup
      google_calendar_events = DailyReportGenerator::Source::Events.google_calendar
      google_calendar_events.each { |event| puts event.oneline }
    end

    desc 'slack', 'generate slack report'
    def slack
      DailyReportGenerator::Source::Events.setup
      events = DailyReportGenerator::Source::Events.slack
      events.map { |event| puts event.oneline }
    end

    desc 'today', 'generate today report'
    def today
      DailyReportGenerator::Source::Events.today
      today_events = DailyReportGenerator::Source::Events.all
      today_events.map { |event| puts event.oneline }
    end
  end
end
