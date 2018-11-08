
# Box office predictions
* Complete machine learning workflow. Exploratory analysis -> Data cleaning -> Feature engineering -> Model training
* Interpretation of results

Project is using predictive modelling on data gathered from IMDB up to 2014 to predict box office profits for movies released in 2015 and 2016.

## Objectives
* In general, is the profit of a movie correlated with its user score on IMDb?
* How about its number of votes?
* What do these correlations tell you?
* Using the data from 2014 and earlier, can you predict the profit of movies released in 2015 and 2016?
* Let's say that you were able to show movies pre-release to a representative focus group, which accurately anticipates the score of a movie (but not its overall popularity), can you improve your model?

### Data
* One table *box_office_predictions.csv* containing data on 6000 movies from IMDb, released in 2016 and earlier.

#### Data dictionary
* **budget** - Total cost of the film
* **country** - country of release
* **director** - Film director's name
* **genre** - Primary genre category
* **gross** - Total gross revenue
* **name** - Name and year of the film
* **rating** - MPAA rating of the film
* **runtime** - Length of the film in mins
* **score** - User score on IMDb
* **star** - Lead actor of the film
* **studio** - Studio that produced the film
* **votes** - Number of user ratings on IMDb

### Loading libraries


```python
# Python 3 compatibility
from __future__ import print_function

# NumPy for numerical computing
import numpy as np

# Pandas for DataFrames
import pandas as pd
pd.set_option('display.max_columns', 20)

# Matplotlib for visualization
from matplotlib import pyplot as plt
# display plots in the notebook instead of popup

# Seaborn for nicer plots
import seaborn as sns

# Cleaner output
import warnings
warnings.filterwarnings('ignore')
```

### Loading data


```python
df = pd.read_csv('../data/box_office_predictions.csv')
```

## Exploratory data analysis
### Basic checks on the dataset
* Shape
* Data types
* Categorical variables
* Numeric distributions
* Dataset statistics
* Statistics including categorical features
* First rows of the dataset



```python
df.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>budget</th>
      <th>country</th>
      <th>director</th>
      <th>genre</th>
      <th>gross</th>
      <th>name</th>
      <th>rating</th>
      <th>runtime</th>
      <th>score</th>
      <th>star</th>
      <th>studio</th>
      <th>votes</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>237000000.0</td>
      <td>UK</td>
      <td>James Cameron</td>
      <td>Action</td>
      <td>760507625.0</td>
      <td>Avatar (2009)</td>
      <td>PG-13</td>
      <td>162</td>
      <td>7.8</td>
      <td>Sam Worthington</td>
      <td>Twentieth Century Fox Film Corporation</td>
      <td>958400</td>
    </tr>
    <tr>
      <th>1</th>
      <td>200000000.0</td>
      <td>USA</td>
      <td>James Cameron</td>
      <td>Drama</td>
      <td>658672302.0</td>
      <td>Titanic (1997)</td>
      <td>PG-13</td>
      <td>194</td>
      <td>7.8</td>
      <td>Leonardo DiCaprio</td>
      <td>Twentieth Century Fox Film Corporation</td>
      <td>865551</td>
    </tr>
    <tr>
      <th>2</th>
      <td>150000000.0</td>
      <td>USA</td>
      <td>Colin Trevorrow</td>
      <td>Action</td>
      <td>652270625.0</td>
      <td>Jurassic World (2015)</td>
      <td>PG-13</td>
      <td>124</td>
      <td>7.0</td>
      <td>Chris Pratt</td>
      <td>Universal Pictures</td>
      <td>470625</td>
    </tr>
    <tr>
      <th>3</th>
      <td>220000000.0</td>
      <td>USA</td>
      <td>Joss Whedon</td>
      <td>Action</td>
      <td>623357910.0</td>
      <td>The Avengers (2012)</td>
      <td>PG-13</td>
      <td>143</td>
      <td>8.1</td>
      <td>Robert Downey Jr.</td>
      <td>Marvel Studios</td>
      <td>1069292</td>
    </tr>
    <tr>
      <th>4</th>
      <td>185000000.0</td>
      <td>USA</td>
      <td>Christopher Nolan</td>
      <td>Action</td>
      <td>534858444.0</td>
      <td>The Dark Knight (2008)</td>
      <td>PG-13</td>
      <td>152</td>
      <td>9.0</td>
      <td>Christian Bale</td>
      <td>Warner Bros.</td>
      <td>1845853</td>
    </tr>
  </tbody>
</table>
</div>



* The dataset has a mix of numeric and categorical features.
* There are variables for budget and gross revenue, but no variable for profit or roi. These will need creating later.
* The "name" feature also includes the year the film was released. We can extract this information to create an age of film feature.


```python
# 12 features for 6000 observations
df.shape
```




    (6000, 12)




```python
# All features
df.dtypes
```




    budget      float64
    country      object
    director     object
    genre        object
    gross       float64
    name         object
    rating       object
    runtime       int64
    score       float64
    star         object
    studio       object
    votes         int64
    dtype: object




```python
# Only categorical
df.dtypes[df.dtypes == 'object']
```




    country     object
    director    object
    genre       object
    name        object
    rating      object
    star        object
    studio      object
    dtype: object




```python
# Plot histogram grid
df.hist(figsize=[14,14], xrot=315)
# Clear the text "residue"
plt.show()
```


![png](img/output_10_0.png)


#### Assumptions
* Looking at the budget - possibly in millions
* Score looks normally distributes which is usual with things involving human population
* Looks like most movies have very few votes
* Most movies are about 110 minutes in length which is consistent with research on this here https://www.slashfilm.com/by-the-numbers-the-length-of-feature-films/2/ and here https://www.reddit.com/r/dataisbeautiful/comments/6vnwa9/average_movie_length_by_country_source_imdb_of/
* Gross is not clear, seems to be too small to be in millions. Will need further looking into


```python
df.describe()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>budget</th>
      <th>gross</th>
      <th>runtime</th>
      <th>score</th>
      <th>votes</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>6.000000e+03</td>
      <td>6.000000e+03</td>
      <td>6000.000000</td>
      <td>6000.000000</td>
      <td>6.000000e+03</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>2.469918e+07</td>
      <td>3.341635e+07</td>
      <td>106.587000</td>
      <td>6.386383</td>
      <td>7.188537e+04</td>
    </tr>
    <tr>
      <th>std</th>
      <td>3.721710e+07</td>
      <td>5.735205e+07</td>
      <td>18.026885</td>
      <td>0.994921</td>
      <td>1.308033e+05</td>
    </tr>
    <tr>
      <th>min</th>
      <td>0.000000e+00</td>
      <td>4.410000e+02</td>
      <td>50.000000</td>
      <td>1.500000</td>
      <td>2.700000e+01</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>0.000000e+00</td>
      <td>1.527796e+06</td>
      <td>95.000000</td>
      <td>5.800000</td>
      <td>7.791750e+03</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>1.100000e+07</td>
      <td>1.229897e+07</td>
      <td>102.000000</td>
      <td>6.500000</td>
      <td>2.660150e+04</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>3.262500e+07</td>
      <td>4.007256e+07</td>
      <td>115.000000</td>
      <td>7.100000</td>
      <td>7.677475e+04</td>
    </tr>
    <tr>
      <th>max</th>
      <td>3.000000e+08</td>
      <td>7.605076e+08</td>
      <td>366.000000</td>
      <td>9.300000</td>
      <td>1.868308e+06</td>
    </tr>
  </tbody>
</table>
</div>



Based on the summary statistics, we see that some films have a budget of 0 in the dataset. Here are a few examples:


```python
# Examples of films with 0 budget
df[df.budget == 0].head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>budget</th>
      <th>country</th>
      <th>director</th>
      <th>genre</th>
      <th>gross</th>
      <th>name</th>
      <th>rating</th>
      <th>runtime</th>
      <th>score</th>
      <th>star</th>
      <th>studio</th>
      <th>votes</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>56</th>
      <td>0.0</td>
      <td>UK</td>
      <td>David Yates</td>
      <td>Adventure</td>
      <td>295983305.0</td>
      <td>Harry Potter and the Deathly Hallows: Part 1 (...</td>
      <td>PG-13</td>
      <td>146</td>
      <td>7.7</td>
      <td>Daniel Radcliffe</td>
      <td>Warner Bros.</td>
      <td>370003</td>
    </tr>
    <tr>
      <th>207</th>
      <td>0.0</td>
      <td>USA</td>
      <td>Walt Becker</td>
      <td>Action</td>
      <td>168273550.0</td>
      <td>Wild Hogs (2007)</td>
      <td>PG-13</td>
      <td>100</td>
      <td>5.9</td>
      <td>Tim Allen</td>
      <td>Touchstone Pictures</td>
      <td>104657</td>
    </tr>
    <tr>
      <th>431</th>
      <td>0.0</td>
      <td>USA</td>
      <td>John G. Avildsen</td>
      <td>Action</td>
      <td>115103979.0</td>
      <td>The Karate Kid Part II (1986)</td>
      <td>PG</td>
      <td>113</td>
      <td>5.9</td>
      <td>Pat Morita</td>
      <td>Columbia Pictures Corporation</td>
      <td>58596</td>
    </tr>
    <tr>
      <th>553</th>
      <td>0.0</td>
      <td>USA</td>
      <td>Nora Ephron</td>
      <td>Comedy</td>
      <td>95318203.0</td>
      <td>Michael (1996)</td>
      <td>PG</td>
      <td>105</td>
      <td>5.7</td>
      <td>John Travolta</td>
      <td>Turner Pictures (I)</td>
      <td>36553</td>
    </tr>
    <tr>
      <th>592</th>
      <td>0.0</td>
      <td>USA</td>
      <td>Tyler Perry</td>
      <td>Comedy</td>
      <td>90485233.0</td>
      <td>Madea Goes to Jail (2009)</td>
      <td>PG-13</td>
      <td>103</td>
      <td>4.3</td>
      <td>Tyler Perry</td>
      <td>Tyler Perry Company, The</td>
      <td>10095</td>
    </tr>
  </tbody>
</table>
</div>



These are most likely missing values or data collection errors. But since our goal is to investigate profitability of films, we cannot study films with missing budget values.

To improve the analysis in the future, we'd want to troubleshoot our data source to find out if we can get the budgets of those films. For now, we'll remove those films.


```python
# Remove films with "0" budget
df = df.loc[df.budget > 0,:]
```


```python
df.describe(include=['object'])
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>country</th>
      <th>director</th>
      <th>genre</th>
      <th>name</th>
      <th>rating</th>
      <th>star</th>
      <th>studio</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>4089</td>
      <td>4089</td>
      <td>4089</td>
      <td>4089</td>
      <td>4089</td>
      <td>4089</td>
      <td>4089</td>
    </tr>
    <tr>
      <th>unique</th>
      <td>42</td>
      <td>1757</td>
      <td>16</td>
      <td>4089</td>
      <td>8</td>
      <td>1501</td>
      <td>1232</td>
    </tr>
    <tr>
      <th>top</th>
      <td>USA</td>
      <td>Woody Allen</td>
      <td>Comedy</td>
      <td>Nadine (1987)</td>
      <td>R</td>
      <td>Nicolas Cage</td>
      <td>Universal Pictures</td>
    </tr>
    <tr>
      <th>freq</th>
      <td>3275</td>
      <td>26</td>
      <td>1136</td>
      <td>1</td>
      <td>2001</td>
      <td>36</td>
      <td>235</td>
    </tr>
  </tbody>
</table>
</div>



#### Insights
* There seems to be no missing values for categorical features
* Most movies are US comedies, however there are 52 counties present in the dataset and 17 genres
* some categorical features have a large number of unique classes relative to the number of total observations.

There are 1232 unique studios in the dataset of 4089 observations (after filtering for non-zero budget). This will most likely lead to sparse classes, so we'll want to address this during feature engineering.


```python
# Reverse sort studios by total number of films
df.studio.value_counts().tail()
```




    Applied Action           1
    Santa Monica Holdings    1
    Seraphim Films           1
    George Films             1
    SBS Productions          1
    Name: studio, dtype: int64



Compare that to the top studios in the dataset, and we can see that it will be useful to combine low-frequency studios into tiered classes


```python
# Top studios by total number of films
df.studio.value_counts().head()
```




    Universal Pictures                        235
    Warner Bros.                              231
    Paramount Pictures                        197
    Twentieth Century Fox Film Corporation    148
    New Line Cinema                           123
    Name: studio, dtype: int64



### Data cleaning considerations
* Check for duplicates
* Check for missing values

#### Check for duplicates


```python
# check for duplicates by movie name
df['name'].value_counts().head()
```




    Nadine (1987)                      1
    La casa de los espíritus (1993)    1
    La Bamba (1987)                    1
    Intersection (1994)                1
    Car 54, Where Are You? (1994)      1
    Name: name, dtype: int64



it seems there are no duplicates in the dataset

#### Find missing values


```python
# Find missing data in categorical features
df.select_dtypes(include=['object']).isnull().sum()
```




    country     0
    director    0
    genre       0
    name        0
    rating      0
    star        0
    studio      0
    dtype: int64



Seems no data is missing here


```python
# Display number of missing values by feature (numeric)
df.select_dtypes(exclude=['object']).isnull().sum()
```




    budget     0
    gross      0
    runtime    0
    score      0
    votes      0
    dtype: int64



No missing values here as well

## Feature engineering

Creating target variable


```python
df['profit'] = df.gross - df.budget
```

### Combine sparse classes into tiers

There are other valid ways of combining classes. For example, you could try combining studios based on their average production budget (as a proxy for studio size). We will combine them based on their total number of films in the dataset.


```python
# Number of films from each studio
studio_counts = df.studio.value_counts()

# Tiers for sparser studios
one = studio_counts[studio_counts <= 1].index
three_five = studio_counts[(studio_counts > 1) & (studio_counts <= 3)].index
five_ten = studio_counts[(studio_counts > 3) & (studio_counts <= 5)].index
ten_plus = studio_counts[(studio_counts > 5) & (studio_counts <= 10)].index

# Combine sparse studios
df['studio'].replace(one, '1', inplace=True)
df['studio'].replace(three_five, '3-5', inplace=True)
df['studio'].replace(five_ten, '5-10', inplace=True)
df['studio'].replace(ten_plus, '10+', inplace=True)
```


```python
# Same with stars
# Number of films from each star
star_counts = df.star.value_counts()

# Tiers for sparser stars
one = star_counts[star_counts <= 1].index
three_five = star_counts[(star_counts > 1) & (star_counts <= 3)].index
five_ten = star_counts[(star_counts > 3) & (star_counts <= 5)].index
ten_plus = star_counts[(star_counts > 5) & (star_counts <= 10)].index

# Combine sparse stars
df['star'].replace(one, '1', inplace=True)
df['star'].replace(three_five, '3-5', inplace=True)
df['star'].replace(five_ten, '5-10', inplace=True)
df['star'].replace(ten_plus, '10+', inplace=True)
```


```python
# Number of films from each director
director_counts = df.director.value_counts()

# Tiers for sparser directors
one = director_counts[director_counts <= 1].index
three_five = director_counts[(director_counts > 1) & (director_counts <= 3)].index
five_ten = director_counts[(director_counts > 3) & (director_counts <= 5)].index
ten_plus = director_counts[(director_counts > 5) & (director_counts <= 10)].index

# Combine sparse directors
df['director'].replace(one, '1', inplace=True)
df['director'].replace(three_five, '3-5', inplace=True)
df['director'].replace(five_ten, '5-10', inplace=True)
df['director'].replace(ten_plus, '10+', inplace=True)
```

### Combining countries


```python
# it looks like movies mainly come from top 5 countries in this dataset
#Number of films from each country
country_counts = df.country.value_counts()

# New class frequencies
df.country.value_counts()
top_5_list = df.country.value_counts().index[:5]
df.loc[~df.country.isin(top_5_list), 'country'] = 'Other'
sns.countplot(y='country', data=df)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x1a217d20f0>




![png](img/output_38_1.png)



```python
sns.countplot(y='genre', data=df)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x1a21280ba8>




![png](img/output_39_1.png)


It looks like we have 8 top genres, let's combine sparse genres into Other


```python
# top 8 genres
top_8_list = df.genre.value_counts().index[:8]
df.loc[~df.genre.isin(top_8_list), 'genre'] = 'Other'
sns.countplot(y='genre', data=df)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x1a20e41c88>




![png](img/output_41_1.png)


*rating* feature has an issue where Unrated films have different labels:


```python
sns.countplot(y='rating', data=df)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x1a212fe240>




![png](img/output_43_1.png)



```python
# Fix "unrated" labels
df['rating'].replace(['NOT RATED', 'UNRATED', 'Not specified'], 'NR', inplace=True)
```


```python
sns.countplot(y='rating', data=df)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x1a211a2d30>




![png](img/output_45_1.png)


Finally, we'll create an age feature for the film.

Note: We will set "today" to 2014 to imitate an analysis performed in 2014 to predict films in 2015 and 2016.


```python
def extract_age(s, today=2014):
    return today - int( s[-5:-1] )
```


```python
# Create "age" feature
df['age'] = df.name.apply(extract_age)
```


```python
df.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>budget</th>
      <th>country</th>
      <th>director</th>
      <th>genre</th>
      <th>gross</th>
      <th>name</th>
      <th>rating</th>
      <th>runtime</th>
      <th>score</th>
      <th>star</th>
      <th>studio</th>
      <th>votes</th>
      <th>profit</th>
      <th>age</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>237000000.0</td>
      <td>UK</td>
      <td>5-10</td>
      <td>Action</td>
      <td>760507625.0</td>
      <td>Avatar (2009)</td>
      <td>PG-13</td>
      <td>162</td>
      <td>7.8</td>
      <td>3-5</td>
      <td>Twentieth Century Fox Film Corporation</td>
      <td>958400</td>
      <td>523507625.0</td>
      <td>5</td>
    </tr>
    <tr>
      <th>1</th>
      <td>200000000.0</td>
      <td>USA</td>
      <td>5-10</td>
      <td>Drama</td>
      <td>658672302.0</td>
      <td>Titanic (1997)</td>
      <td>PG-13</td>
      <td>194</td>
      <td>7.8</td>
      <td>Leonardo DiCaprio</td>
      <td>Twentieth Century Fox Film Corporation</td>
      <td>865551</td>
      <td>458672302.0</td>
      <td>17</td>
    </tr>
    <tr>
      <th>2</th>
      <td>150000000.0</td>
      <td>USA</td>
      <td>3-5</td>
      <td>Action</td>
      <td>652270625.0</td>
      <td>Jurassic World (2015)</td>
      <td>PG-13</td>
      <td>124</td>
      <td>7.0</td>
      <td>3-5</td>
      <td>Universal Pictures</td>
      <td>470625</td>
      <td>502270625.0</td>
      <td>-1</td>
    </tr>
    <tr>
      <th>3</th>
      <td>220000000.0</td>
      <td>USA</td>
      <td>3-5</td>
      <td>Action</td>
      <td>623357910.0</td>
      <td>The Avengers (2012)</td>
      <td>PG-13</td>
      <td>143</td>
      <td>8.1</td>
      <td>Robert Downey Jr.</td>
      <td>10+</td>
      <td>1069292</td>
      <td>403357910.0</td>
      <td>2</td>
    </tr>
    <tr>
      <th>4</th>
      <td>185000000.0</td>
      <td>USA</td>
      <td>10+</td>
      <td>Action</td>
      <td>534858444.0</td>
      <td>The Dark Knight (2008)</td>
      <td>PG-13</td>
      <td>152</td>
      <td>9.0</td>
      <td>Christian Bale</td>
      <td>Warner Bros.</td>
      <td>1845853</td>
      <td>349858444.0</td>
      <td>6</td>
    </tr>
  </tbody>
</table>
</div>



## Correlations

* Is the profit of a movie correlated with it's user score?
 * There is very low positive correlation, we can assume that these two features are not correlated
* How about its number of votes?
 * Votes have strong positive correlation with gross profit
* What do these correlations tell us?
 * Gross profit is directly dependent on how many people watched the movie. It looks as movie recieves more ratings as more people watch it but the score people give does not depend on the profit and vice versa.


```python
# Calculate correlations:
correlations = df.corr()

### SNS plot theme
# Change color scheme
sns.set_style('white')
# Generate a mask for the upper triangle
mask = np.zeros_like(correlations, dtype=np.bool)
mask[np.triu_indices_from(mask)] = True
# Make the figsize
plt.figure(figsize=(15,15))

# Plot heatmap of correlations
sns.heatmap(correlations*100, annot=True, mask=mask, cbar=False)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x1a21a57d30>




![png](img/output_51_1.png)


## Machine learning

Next, we will prepare the data for machine learning by creating an analytical base table. We will drop name columns because it's basically an index column and the gross, votes, and score features because we do not know them at the time.


```python
import warnings
warnings.filterwarnings('ignore')
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import r2_score
from sklearn.metrics import mean_absolute_error
```


```python
# Create analytical base table (ABT)
abt = pd.get_dummies ( df.drop(['name', 'gross', 'votes', 'score'], axis=1) )
```

We'll split the data based on date of training data (2014 and earlier) and test data (2015, 2016)


```python
# Train / Test split based on date of training data (2014 and earlier) and test data (2015, 2016)
train = abt[abt.age >= 0]
test = abt[abt.age <= 0]

y_train = train.profit
X_train = train.drop(['profit'], axis=1)

y_test = test.profit
X_test = test.drop(['profit'], axis=1)
```

We will try a basic random forest


```python
# Train a basic random forest model
rf = RandomForestRegressor(random_state=1234)
rf.fit(X_train, y_train)

# Make prediction on test set
pred = rf.predict(X_test)
```


```python
sns.jointplot(y_test, pred, kind='reg')
plt.xlabel('Actual Profit')
plt.ylabel('Predicted Profit')
plt.show()
```


![png](img/output_59_0.png)



```python
# scores
print('R^2 score: ', r2_score(y_test, pred))
print('MAE: ', mean_absolute_error(y_test, pred))
```

    R^2 score:  0.22029037231625237
    MAE:  29684720.822394677


As you can see in the plot, the very model actually does a pretty good job predicting the profitability of films based on the limited data we have and out of the box model.

Whether this model performance is "good enough" will depend on the use-case. For example, in a betting market, this model would already give a formidable edge.

Finally, we'll plot the feature importances.


```python
# Helper function for plotting feature importances
def plot_feature_importances(columns, feature_importances, show_top_n=10):
    feats = dict( zip(columns, feature_importances) )
    imp = pd.DataFrame.from_dict(feats, orient='index').rename(columns={0: 'Gini-importance'})
    imp.sort_values(by='Gini-importance').tail(show_top_n).plot(kind='barh', figsize=(8,8))
    plt.show()
```


```python
plot_feature_importances(X_train.columns, rf.feature_importances_)
```


![png](img/output_63_0.png)


As a whole, the budget feature was the most important in our model. But earlier, we found that budget and profit were not correlated?

This seems contradictory, but the answer has to do with the difference between first-order correlations and a full model. Earlier, we were looking at the correlation between budget and profit at an aggregate level.

But now that we've built a model, we can look at the affect of budget while controlling for all the other input features as well.

## Machine Learning with Pre-Screen
Next, we'll create a new analytical base table for the scenario where we're able to collect an accurate score input based on film pre-screenings.


```python
# Create new analytical base table (ABT)
abt_ps = pd.get_dummies ( df.drop(['name', 'gross', 'votes'], axis=1) )
```


```python
train = abt_ps[abt_ps.age >= 0]
test = abt_ps[abt_ps.age <= 0]

y_train = train.profit
X_train = train.drop(['profit'], axis=1)

y_test = test.profit
X_test = test.drop(['profit'], axis=1)
```


```python
# Train a basic random forest model
rf = RandomForestRegressor(random_state=1234)
rf.fit(X_train, y_train)

# Make prediction on test set
pred = rf.predict(X_test)
```


```python
sns.jointplot(y_test, pred, kind='reg')
plt.xlabel('Actual Profit')
plt.ylabel('Predicted Profit')
plt.show()
```


![png](img/output_69_0.png)



```python
# scores
print('R^2 score: ', r2_score(y_test, pred))
print('MAE: ', mean_absolute_error(y_test, pred))
```

    R^2 score:  0.3371924664808582
    MAE:  25972965.048558757


Including the score feature improves our model's performance substantially. We should make effort to collect this data for any film we'd like to predict.


```python
plot_feature_importances(X_train.columns, rf.feature_importances_)
```


![png](img/output_72_0.png)


The score turns out to be the second important feature after the budget
