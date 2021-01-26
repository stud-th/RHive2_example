FROM rocker/rstudio:3.6.1
ENV  PASSWORD=guest

RUN apt-get update \
   && apt-get install -y r-cran-rjava 
RUN install2.r --deps TRUE \
shiny \
shinydashboard \
rJava \
RJDBC \
nycflights13 \
ggthemes \
data.table \
assertthat 

RUN apt-get install -y --no-install-recommends \
    libxml2-dev
RUN R -e 'install.packages("devtools")'



# RUN sudo apt-get install -y software-properties-common

RUN sudo apt-get update
RUN sudo apt-get install -y openjdk-8-jdk
RUN  sudo R CMD javareconf 
RUN apt-get install -y r-cran-rjava 
RUN R -e 'install.packages("RJDBC")'
RUN R -e 'install.packages("lifecycle")'
RUN R -e 'install.packages("tidyselect")'
RUN  R -e 'devtools::install_version("dbplyr", version = "1.4.4", repos = "http://cran.us.r-project.org", upgrade_dependencies=FALSE)'

RUN R -e  'devtools::install_github("stud-th/RHiveS2", ref="5c3e5c506608cb3aed45b81bc042786d425eed85")'

COPY Docker /home/rstudio/
COPY Docker/jars /home/rstudio/jars

