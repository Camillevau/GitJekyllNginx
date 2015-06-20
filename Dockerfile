FROM      debian:jessie
#FROM ubuntu
MAINTAINER Camille Vaucelle <camille@vaucelle.org>


RUN \
   apt-get update \ 
   && apt-get install -y \
     curl \
     gcc \
     git \
     make \
     nginx \
     openssh-server \
     ruby \
     ruby-dev \
     rubygems \
     sudo 

RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf \
    && chown -R www-data:www-data /var/www/


RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y nodejs
RUN gem install jekyll


COPY deploy.sh /root/deploy.sh
RUN chmod u+x /root/deploy.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


VOLUME /var/repository
VOLUME /var/log/nginx

# Expose ports.
EXPOSE 80

CMD ["nginx"]




#WORKDIR /etc/nginx/sites-enabled


#RUN git init --bare repository
#RUN rm default
#COPY nginx_site ./default
#VOLUME ["/root/.ssh"]
#WORKDIR /var/repository

