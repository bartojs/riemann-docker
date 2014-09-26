FROM debian:wheezy
MAINTAINER bartojs

ENV RIEMANN_VERSION 0.2.6

RUN apt-get update && apt-get install -qy openjdk-7-jre-headless ruby wget bzip2
RUN wget -qO- http://aphyr.com/riemann/riemann-$RIEMANN_VERSION.tar.bz2 | tar xj -C /usr/local
RUN gem install riemann-dash

RUN sed -i 's|127.0.0.1|0.0.0.0|g' /usr/local/riemann-$RIEMANN_VERSION/etc/riemann.config
RUN echo 'set :port, 80; set :bind, "0.0.0.0"' > /usr/local/riemann-$RIEMANN_VERSION/etc/dash.rb
RUN echo "#!/bin/bash\n/usr/local/bin/riemann-dash /usr/local/riemann-$RIEMANN_VERSION/etc/dash.rb &\ncd /usr/local/riemann-$RIEMANN_VERSION && ./bin/riemann ./etc/riemann.config" > /usr/local/bin/dockerrun.sh && chmod 755 /usr/local/bin/dockerrun.sh

EXPOSE 5555 5555/udp 5556 80
ENTRYPOINT ["/usr/local/bin/dockerrun.sh"]
