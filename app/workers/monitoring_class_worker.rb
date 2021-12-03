class MonitoringClassWorker
  include Sidekiq::Worker

  def perform
    grades = Grades::MonitoringService.new.grades
    ActionCable.server.broadcast('notification_channel', render_message(grades))
  end

  private

  def render_message(grades)
    grades.map do |grade|
      ApplicationController.renderer.render(partial: 'notifications/message',
                                            locals: { resource: grade })
    end.join('').html_safe
  end
end
