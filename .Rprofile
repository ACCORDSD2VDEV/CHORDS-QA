rVersion <- version[['major']]
cat(paste0("R version ",rVersion," detected\n"))
Sys.setenv(RENV_PROFILE = paste0("R", rVersion, sep=''))
options(pkgType="win.binary")
options(install.packages.check.source = "no")
source("renv/activate.R")
renv::equip()
renv::restore()