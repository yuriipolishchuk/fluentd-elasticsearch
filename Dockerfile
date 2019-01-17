FROM gcr.io/google-containers/fluentd-elasticsearch:v2.4.0 as builder

ENV BUILD_PACKAGES "build-essential ruby2.3-dev"
ENV DEPENDENCIES_PACKAGES "default-libmysqlclient-dev"
RUN apt-get update && apt-get install -y $BUILD_PACKAGES $DEPENDENCIES_PACKAGES \
    && rm -rf /var/lib/apt/lists/*

# install custom plugins
ENV FLUENT_PLUGINS "fluent-plugin-rewrite-tag-filter fluent-plugin-rds-log"
RUN fluent-gem install $FLUENT_PLUGINS -V


# multi-stage build to get smaller image
FROM gcr.io/google-containers/fluentd-elasticsearch:v2.4.0
ENV DEPENDENCIES_PACKAGES "default-libmysqlclient-dev"

RUN apt-get update && apt-get install -y $DEPENDENCIES_PACKAGES \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /var/lib/gems /var/lib/gems
