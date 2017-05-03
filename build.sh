#!/bin/bash -l

set -e -x

export RAILS_ENV=build
export BUNDLE_WITHOUT="development:test"

CI_PIPELINE_COUNTER=${GO_PIPELINE_LABEL:-0}
CI_EXECUTOR_NUMBER=${EXECUTOR_NUMBER:-0}

bundle install
bundle exec bowndler install

rake app:gem:build
