FROM rocker/r-base:latest

# ✅ Set CRAN mirror in a valid R profile path
RUN mkdir -p /etc/R && \
echo 'options(repos = c(CRAN = "https://cloud.r-project.org"))' >> /etc/R/Rprofile.site

WORKDIR /home/rstudio/project

COPY . .

RUN R -e "install.packages('renv')"
RUN R -e "renv::restore(prompt = FALSE)"

#CMD ["Rscript", "script.R"]
