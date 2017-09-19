module TourGuideHelper
  def tour_guide_tag(steps: nil, theme: 'shepherd-theme-dark', start: true, last_step: false)
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
    skip_to_last_step = last_step ? 'tour.lastStep();' : ''
    close_after_window_load = '});'
    javascript = open_after_window_load + shepherd_init_js + shepherd_steps + start_tour + skip_to_last_step + close_after_window_load
    # whenever shepherd expects some value without quotes, To determine this from Yaml file, we are prepending and appending method name with $
    javascript = javascript.gsub("$\"",'').gsub("\"$",'').gsub('=>',': ')
    all_steps ? javascript_tag(javascript,type: 'text/javascript') : ''
  rescue
    ''
  end
end


# //<![CDATA[
# $(window).load(function() {
      # var tour;
      # tour = new Shepherd.Tour({
      #   defaults: {
      #     classes: 'shepherd-theme-dark',
      #     showCancelLink: true,
      #     scrollTo: true
      #   }
      # });
    
#     tour.addStep('Environment Details', {title: 'Environment Details',text: 'Please click here to check the environment details',attachTo: '#code_execution_environment_details right',advanceOn: '#code_execution_environment_details click',buttons: [{"text": "Exit", "classes": "shepherd-button-secondary", "action": tour.cancel}, {"text": "Next", "classes": "shepherd-button-example-primary", "action": tour.next}] });
#     tour.addStep('event_title', {title: 'Event Title',text: 'Check your Event Title here',attachTo: '#event_title left',buttons: [{"text": "Back", "classes": "shepherd-button-secondary", "action": tour.back}, {"text": "Next", "classes": "shepherd-button-example-primary", "action": tour.next}] });
#     tour.addStep('user_event_status', {title: 'User Event Status',text: 'You can check the current event status here',attachTo: '#user_event_status left',buttons: [{"text": "Back", "classes": "shepherd-button-secondary", "action": tour.back}, {"text": "Next", "classes": "shepherd-button-example-primary", "action": tour.next}] });
#     tour.addStep('load_challenge', {title: 'Load Challenge',text: 'Please click here to load challenge',attachTo: '#load_challenge left',buttons: [{"text": "Back", "classes": "shepherd-button-secondary", "action": tour.back}, {"text": "Next", "classes": "shepherd-button-example-primary", "events": {"click": function() { window.location = document.getElementsByClassName('load_challenge')[0].href; }}}] });tour.start();});
# //]]>