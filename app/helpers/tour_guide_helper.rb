module TourGuideHelper
  def tour_guide_tag(steps: nil, theme: 'shepherd-theme-dark', start: true)
    all_steps = all_steps || YAML.load_file("#{Rails.root}/config/shepherd.yml")[controller_name].try(:[], action_name).try(:[], "steps")
    # All the js goes into javascript variable and is used in javascript tag
    javascript = ''
    open_after_window_load = "$(window).load(function() {"
    shepherd_init_js = "
      var tour;
      tour = new Shepherd.Tour({
        defaults: {
          classes: '#{theme}',
          showCancelLink: true,
          scrollTo: true
        }
      });
    "
    # Shepherd all will contain all the steps
    shepherd_steps = ''
    all_steps.each do |each_step|
      name = each_step.delete('name')
      shepherd_steps << "tour.addStep('#{name}', {"
      options = []
      # Shepherd expects hash in symbol value format
      # For every step pushing into shepherd_steps_array in the required format
      each_step.each { |key, value| options << "#{key}: #{(value.is_a? Array) ? value : "'#{value}'"}" }
      shepherd_steps << "#{options.join(',')} });"
    end
    start_tour = 'tour.start();' if start
    close_after_window_load = '});'
    javascript = open_after_window_load + shepherd_init_js + shepherd_steps + start_tour + close_after_window_load
    # whenever shepherd expects some value without quotes, To determine this from Yaml file, we are prepending and appending method name with $
    javascript = javascript.gsub("$\"",'').gsub("\"$",'').gsub('=>',': ')
    all_steps ? javascript_tag(javascript,type: 'text/javascript') : ''
  rescue
    ''
  end
end
