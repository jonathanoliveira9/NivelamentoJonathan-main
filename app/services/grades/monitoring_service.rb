module Grades
  class MonitoringService
    attr_reader :grades

    def initialize
      @grades = search_grade
    end

    private

    def search_grade
      Grade.where("hour_end >= :target_date AND hour_start <= :target_date \
                   AND #{query_by_week_day} \
                   AND #{query_by_year}", target_date: Time.now.strftime('%H:%M'))
    end

    def query_by_week_day
      "#{Time.now.strftime('%A').downcase} == 't'"  # output like thursday == 'true'
    end

    def query_by_year
      "year == #{Time.now.year}"
    end
  end
end
