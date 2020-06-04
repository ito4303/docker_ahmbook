FROM rocker/tidyverse:3.6.3

# From https://hub.docker.com/r/kazutan/stan-d/dockerfile

# Change environment to Japanese(Character and DateTime)
ENV LANG ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
RUN sed -i '$d' /etc/locale.gen \
  && echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen ja_JP.UTF-8 \
	&& /usr/sbin/update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
RUN /bin/bash -c "source /etc/default/locale"
RUN ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# Install Japanese fonts
RUN apt-get update && apt-get install -y \
  fonts-ipaexfont

# Install dependencies
# https://cpp-laboratory.hatenablog.com/entry/2018/12/08/080000
# https://philmikejones.me/tutorials/2014-07-14-installing-rgdal-in-r-on-linux/
RUN apt-get update && apt-get install -y \
    jags \
    libglpk-dev \
    libgdal-dev \
    libproj-dev \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Install OpenBUGS
# https://hub.docker.com/r/mavelli/rocker-bayesian
RUN wget -nd -P /tmp http://pj.freefaculty.org/Debian/squeeze/amd64/openbugs_3.2.2-1_amd64.deb
RUN dpkg -i /tmp/openbugs_3.2.2-1_amd64.deb && rm /tmp/openbugs_3.2.2-1_amd64.deb

# Install packages
RUN Rscript -e "install.packages(c('AHMbook', 'unmarked', 'AICcmodavg', 'rjags', 'jagsUI', 'R2OpenBUGS', 'lme4', 'denstrip', 'rgdal'))"

CMD ["/init"]
