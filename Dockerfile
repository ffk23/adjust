FROM ruby:3.0.1-slim-buster
ENV HOME_DIR=/srv/adjust/http_server
# FIXME: Install curl required to perform readness probe.
# Application returns only body not a http code 
# Create a user and folder structure for the app
RUN apt-get update; \
    apt-get install -y --no-install-recommends curl ; \
    rm -rf /var/lib/apt/lists/*; \
    mkdir -p $HOME_DIR \
    && groupadd -r -g 54338 httprb \
    && useradd -u 54338 -c "httprb" -d $HOME_DIR -M -s /bin/sh -r -g httprb httprb \
    && chown -R httprb:httprb $HOME_DIR
# Switch to non-root user. The container may not run in Openshift
USER httprb
EXPOSE 80
WORKDIR $HOME_DIR
COPY src/http_server.rb $HOME_DIR

CMD [ "ruby", "http_server.rb" ]

