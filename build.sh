#!/bin/bash -l

set -e -x

export RAILS_ENV=build
export BUNDLE_WITHOUT="development:test"

#CI_PIPELINE_COUNTER=${GO_PIPELINE_LABEL-0}
#CI_EXECUTOR_NUMBER=${EXECUTOR_NUMBER-0}

version_number=${GO_PIPELINE_LABEL-0}
revision=`git rev-parse HEAD`
build_date=`date +'%Y-%m-%d %H:%M %z'`

cat > public/version <<EOT
{
  "version":"$version_number",
  "buildDate":"$build_date",
  "gitRevision":"$revision"
}
EOT

bundle install

rake app:gem:build
