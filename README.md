# Analysis of Crime Rates and Household Income in Toronto Neighbourhoods

## Overview of Paper

This paper analyzes household income distribution across different neighborhoods in Toronto. It further dives into the different types of crimes(theft, auto-theft assault etc.), to look at the possible relationships between crime rates, crime types and household income level for each of Toronto's 158 neighborhoods. Data used was obtained from Toronto Open Data. 

The analysis is conducted through Posit Cloud using "R version 4.3.2 (2023-10-31)

LLM Usage Statement: No LLM's were used in the making of this paper.

## File Structure

The repo is structured as:

-   `input/data` contains the data sources used in analysis including the raw data.

-   `outputs/data` contains the cleaned dataset that was constructed.

-   `outputs/paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 

-   `scripts` contains the R scripts used to simulate, download and clean data.

## How to Run

1.  To download the raw datasets, run: `scripts/01-download_data.R` 
2.  To get the cleaned datasets, run: `scripts/02-data_cleaning.R`
3.  To generate complete PDF paper, run `outputs/paper/Toronto_Neighbourhood_Crime.qmd`