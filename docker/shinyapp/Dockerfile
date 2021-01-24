FROM rocker/rstudio:4.0.0
ENV  PASSWORD=guest

RUN apt-get update \
   && apt-get install -y r-cran-rjava
RUN install2.r --deps TRUE \
shiny \
shinydashboard \
devtools \
rJava \
RJDBC \
nycflights13 \
ggthemes


RUN  R -e 'devtools::install_version("DBI", version = "1.1.1", repos = "http://cran.us.r-project.org", upgrade_dependencies=FALSE)'
RUN  R -e 'devtools::install_version("dbplyr", version = "1.4.4", repos = "http://cran.us.r-project.org", upgrade_dependencies=FALSE)'
RUN R -e  'devtools::install_github("stud-th/RHiveS2", ref="c9847bfdc5a5913bd6bbd75dd5dd0d13d61b3efa")'

COPY Docker /home/rstudio/
COPY Docker/jars /home/rstudio/jars
