## Based on the image RStudio with R {{r_version}} ----

FROM rocker/rstudio:{{r_version}}

MAINTAINER {{given}} {{family}} <{{email}}>


## Install system dependencies ----

RUN sudo apt update -yq \
 && sudo apt install --no-install-recommends libxml2-dev -yq \
 && sudo apt clean all \
 && sudo apt purge \
 && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


## Copy local project ----

ENV folder="/home/rstudio/"

COPY . $folder
RUN chown -R rstudio:rstudio $folder


## Set working directory ----

WORKDIR $folder


## Install R packages ----

{{install_packages}}
