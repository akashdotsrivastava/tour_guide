module TourGuideHelper
  def tour_guide_tag(steps: nil, theme: 'shepherd-theme-dark', start: true)
    steps = steps || YAML.load_file("#{Rails.root}/config/shepherd.yml")[controller_name].try(:[], action_name).try(:[], "steps")
    javascript = "
      $(window).load(function(){
        var tour;
        tour = new Shepherd.Tour({
          defaults: {
            classes: '#{theme}'
          }
        });
      "
      steps.to_a.each do |step|
        name = step.delete('name')
        javascript << "tour.addStep('#{name}', {"
        options = []
        step.each do |key, value|
          options << "#{key}: '#{value}'"
        end
        javascript << "#{options.join(',')}});"
      end

      javascript << 'tour.start();' if start

      javascript << '});'

      # p session[:_tour]
      # p steps
      steps ? javascript_tag(javascript,type: 'text/javascript') : ''
  end
end