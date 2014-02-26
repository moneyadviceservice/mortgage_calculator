#!/bin/bash -l

set -e -x

export RAILS_ENV=test
export BUNDLE_WITHOUT=development:build
export DISPLAY=:99

CI_PIPELINE_COUNTER=${GO_PIPELINE_COUNTER-0}
CI_EXECUTOR_NUMBER=${GO_AGENT_NUMBER-0}

bundle install

if [ -n "$GO_PIPELINE_NAME" ]; then
  # set up a test DB if running on CI
  rake app:build:setup[$CI_EXECUTOR_NUMBER]
fi

rspec
cucumber
rake app:karma:run_once
