namespace :karma  do
  task :start => :environment do
    with_tmp_config :start
  end

  task :run => :environment do
    with_tmp_config :start
  end

  private

  def with_tmp_config(command, args = nil)

    Tempfile.open('karma_unit.js', MortgageCalculator::Engine.root.join('tmp') ) do |f|
      f.write unit_js(application_spec_files)
      f.flush

      system "./node_modules/.bin/karma #{command} #{f.path} #{args}"

    end
  end

  def application_spec_files
    sprockets = Rails.application.assets
    sprockets.append_path MortgageCalculator::Engine.root.join("spec/javascripts/karma")
    files = Rails.application.assets.find_asset("application_spec.js").to_a.map {|e| e.pathname.to_s }
  end

  def unit_js(files)
    unit_js = File.open('spec/javascripts/karma/config/karma.conf.js', 'r').read

    unit_js.gsub "APPLICATION_SPEC", "\"#{files.join("\",\n\"")}\""
  end
end
