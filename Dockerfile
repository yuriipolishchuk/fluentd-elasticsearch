FROM gcr.io/google-containers/fluentd-elasticsearch:v2.3.1

# install custom plugins
RUN fluent-gem install fluent-plugin-rewrite-tag-filter
