# Machine learning workflow to predict property prices
This is my final project for MSc Data Engineering degree. Project fills the gap I feel exists in the academic course where few algorithms were covered in great depth down to mathematical formulas, but choosing best algorithms for the job was barely touched and machine learning workflow as a whole was not covered at all.

This project description is still work in progress as I need to convert a huge MSc dissertation into web readable format.

## Description
Project presents a full machine learning workflow, divided into following parts:
* Exploratory analysis
* Data cleaning
* Feature engineering
* Model training and performance checks
* Final model deployment

## Data
Data for the project was scrapped from [Zoopla](https://www.zoopla.co.uk/) via API they provide. Dataset only covers properties from biggest Scotland cities listed for sale on Zoopla in August 2016.

## Implementation

Project was written using Python and following libraries:
* [Pandas](https://pandas.pydata.org/)
* [Numpy](http://www.numpy.org/)
* [scikit-learn](http://scikit-learn.org/stable/index.html)
* [Seaborn](https://seaborn.pydata.org/)

Also I used [Jupyter notebooks](https://jupyter.org/) for the ML code and [Flask framework](http://flask.pocoo.org/) for final model deployment.

## Project structure
* [Data](../property-project/notebooks/data/)
* [Notebooks](../property-project/notebooks/)
