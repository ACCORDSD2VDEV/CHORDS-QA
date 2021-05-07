# Package Overview

The `chordsTables` package is designed to provide an interface for providers to generate QA reports from CHORDS data.  The package uses the `run_report()` function call one of the .Rmd files contained in the package.  Each .Rmd file generates a report for either the "Priority 1" or "Priority 2" tables.  The `run_report()`  function takes one argument, either `"P1"` or `"P2"` indicating which priority table the user wants.  Once the function is run, a window in the default internet browser opens and the user will be prompted to enter information specific to their organization.  The first is the server name to connect to, and the second is the database name where the relevant priority tables are housed.  Following input from the user, the report is generated.  Depending on the machine that is running the report and how much data is being pulled from the database, these reports could take any where from 20-50 minutes to generate. The word document that is generated is saved in `r paste0("C:/Users/", Sys.info()["login"], "/Documents")` (the My Documents folder for the current user), and the file name is the name of the argument passed to `run_report()` (e.g., `P1.docx`).

## Prerequisite Software

1) R version 4.0.4: https://cran.r-project.org/bin/windows/base/old/4.0.4/
2) Pandoc: https://pandoc.org/installing.html

Use of this package assumes you have have downloaded and installed R and RStudio.  Installing the `chordsTables` package downloads all other dependent packages and contains all files necessary for generating reports.

# Step by step use of package

## Step 1

In order to download and install the `chordsTables` package you will need to install the `devtools` and `renv` packages to install the package from github.  If you don't have those packages (which is likely true for most users), you can use the following code to install it:

```{r, eval=FALSE}
install.packages("devtools")
install.packages("renv")
```

Once you have download and installed R, RStudio, and the devtools and renv packages, download the `chordsTables` package. You can download the package by running the following code in RStudio or an R Command window:

```{r, eval=FALSE}
devtools::install_github("ACCORDSD2VDEV/CHORDS-QA")
```
If you need to install from a branch other than the main branch, use the ```ref``` argument in the ```install_github``` function to specify a different branch.

You may receive the following prompt: 
"These packages have more recent versions available. Which would you like to update?" 
You can skip this update by entering the number 3 in the console.

If you are running the package from an R console, you will need to set an R environment variable to suppress warnings from appearing as errors with ```Sys.setenv(R_REMOTES_NO_ERRORS_FROM_WARNINGS="true")```

## Step 2

Now that the `chordsTables` package is downloaded and installed you can use the `run_report()` function to generate the report.  This function takes one argument that you must provide.  The argument indicates which report you want to generate.  The options include `"P1"` or `"P2"` indicating which priority table the user wants.  The arguments must be entered exactly as shown above, including the quotation marks, uppercase P, and no spacing between the P and the number.  If you don't enter one of those option, a warning message will be printed in the Console indicating as such.  To execute this function run the following code in RStudio (NOTE: `"P1"` is used as an example here.  Change the argument to the value you want):

```{r, eval=FALSE}
chordsTables::run_report("P1")
```

If you wish to change the default output directory, specify the `outputdir` parameter.  The QA program can also be initiated completely from the R command line.  If you do this, specify the `batchmode = TRUE`.  This will take the parameters specified and it will immediately attempt to run QA with those parameters.  If `batchmode` is FALSE or unspecified, the user interface is displayed and the user is asked to input the remainder of the parameters.  If `dbserver`, `dbname`, `dbuser`, and `dbpassword` are specified in the `run_report` call, `batchmode` must be set to `FALSE` or they are ignored. `Outputdir` can be used in either mode.

```{r, eval=FALSE}
chordsTables::run_report("P1", dbserver = "cc-s-d05", dbname = "VDW_3_2_1_DH_0119_LIMITED", batchmode = TRUE, outputdir = "C:/ChordsQA/")
```

## Step 3

If `batchmode = FALSE` or is unspecified when `run_report` is called, a window will open in your default internet browser.  The page that is opened will prompt you to enter your connection information.  Enter your `Database Server Name` and the `Database Name`.  Enter the `Database User Name` and `Database Password` if you are using SQL Authentication.  If you are using Windows authentication, leave the `Database User Name` and `Database Password` blank. Once you have entered the appropriate values, click "Save".

If `batchmode = TRUE`, the report starts to run with the values already specified and no browser window will open.

## Step 4

After you have clicked "Save," RStudio will generate the requested report. You can see that the report is being generated, because messages will be printed to the Console in RStudio.  This could take 20-50 minutes depending on the computer you are using and the amount of data that is being returned by the report.  When the report is generated, the Console in RStudio will indicate that the report was created and its location.  By default, the report is stored in the following directory `C:/Users/<username>/Documents` (the My Documents folder for the current user), and the file name is the name of the argument passed to `run_report()` (e.g., `P1.docx`).

If `batchmode = TRUE`, the report will automatically output to `C:/Users/<username>/Documents` or to the directory specified in the `outputdir` parameter.

## Troubleshooting
If the reports will not run, check to make sure you have the appropriate version of R (and RStudio of you are using it). You can also try reinstalling the `devtools` package again and re-running all of the R code listed in the steps below. If you continue to have issues, please contact Rachel Zucker at Rachel.Zucker@CUANSCHUTZ.EDU.
