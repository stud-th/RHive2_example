#!/bin/bash
docker build shinyapp/ -t shiny-app
docker build sparkthriftserver/ -t spark-thift-server
docker-compose up -d
