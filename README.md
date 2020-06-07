# Dockerfile for "Applied Hierarchical Modeling in Ecology"

Software environment for the AHM examples

- RStudio
- Japanese fonts (fonts-ipaexfont)
- JAGS
- OpenBUGS
- R packages
  - AHMbook
  - unmarked
  - AICcmodavg
  - rjags
  - jagsUI
  - R2OpenBUGS
  - lme4
  - denstrip
  - rgdal

## How to run

```
docker run --rm -p 8787:8787 -e PASSWORD=yourpasswordhere ito4303/ahmbook:3.6.3
```

For details, see https://hub.docker.com/r/rocker/rstudio
