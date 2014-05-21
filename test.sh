#!/bin/bash -l

set -e -x

export RAILS_ENV=test
export BUNDLE_WITHOUT=development:build
export DISPLAY=:99

CI_PIPELINE_COUNTER=${GO_PIPELINE_COUNTER-0}
CI_EXECUTOR_NUMBER=${GO_AGENT_NUMBER-0}

mkdir -p spec/dummy/tmp/capybara

bundle install
bower install
npm install

bundle exec rspec
bundle exec cucumber
bundle exec rake app:karma:run_once
