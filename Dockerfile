FROM openanalytics/r-base

LABEL maintainer "Chris Brownlie <chris.brownlie@hotmail.co.uk>"

# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libssl1.0.0

# basic shiny functionality
RUN R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cloud.r-project.org/')"

# install dependencies of the euler app
RUN R -e "install.packages(c('shinydashboard', 'shinydashboardPlus', 'shinyjs', 'htmltools', 'htmlwidgets', 'r2d3', 'pkgload', 'rjson'), repos='https://cloud.r-project.org/')"

# copy the app to the image
RUN mkdir /root/advancedShiny
COPY advancedShiny /root/advancedShiny

COPY Rprofile.site /usr/lib/R/etc/

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/root/advancedShiny')"]