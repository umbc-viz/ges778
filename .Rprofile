source("renv/activate.R")
options(
    repos = c(
        RSPM = sprintf(
            "https://packagemanager.posit.co/cran/latest/bin/linux/manylinux_2_28-%s/%s",
            R.version["arch"],
            substr(getRversion(), 1, 3)
        ),
        CRAN = "https://cran.r-project.org/"
    ),
    renv.config.pak.enabled = TRUE,
    renv.config.ppm.enabled = TRUE
)
