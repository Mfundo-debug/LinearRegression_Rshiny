# Simple Linear Regression Shiny App

This is a Shiny web application for performing simple linear regression. The application is implemented in R and uses the Shiny, highcharter, plotly, PerformanceAnalytics, and ggplot2 libraries.

## Features

- File Input: The application accepts CSV files. you can improve it by: Multiple files can be uploaded at once. 
- File Configuration: The application allows the user to specify whether the file has a header, the separator used in the file (comma, semicolon, or tab), and the type of quotes used in the file (none, double quote, or single quote).
- Data Display: The application allows the user to select the number of rows to display.
- Data Summary: The application provides a summary of the data.
- Correlation Plot: The application provides a correlation plot of the data.
- Histograms: The application provides histograms for 'Years of Experience' and 'Salary'.
- Linear Model Summary: The application provides a summary of the linear model built on 'Salary' and 'YearsExperience'.
- Test Results Visualization: The application provides a scatter plot of 'YearsExperience' and 'Salary' with a fitted line.
- Model Checks: The application provides diagnostic plots for the linear model.
- Residuals Plot: The application provides a plot of the residuals of the linear model.

## How to Run

To run this application, you need to have R and the necessary libraries installed. You can then run the application by executing the `app.R` script in R.

## Libraries Used

- [Shiny](https://shiny.rstudio.com/): For creating the web application.
- [highcharter](http://jkunst.com/highcharter/): For creating high-quality interactive charts.
- [plotly](https://plotly.com/r/): For creating interactive plots.
- [PerformanceAnalytics](https://cran.r-project.org/web/packages/PerformanceAnalytics/index.html): For creating the correlation plot.
- [ggplot2](https://ggplot2.tidyverse.org/): For creating histograms.
