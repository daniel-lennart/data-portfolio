# Exploring movie ratings data with R
This is an assignment done for R part of Programming Languages for Data Engineering module at University of Dundee
## Dataset
Dataset chosen for the assignment is a movie rating dataset containing movie budgets, genres, audience ratings from RottenTomatoes and critics ratings for years 2007-2011. Dataset contains 562 observations of 6 variables.
### Statistical measures
Some statistical measures were obtained using summary() function:

![summary](https://github.com/daniel-lennart/data-portfolio/blob/master/images/plots/summary.png)

Standard deviation for all numerical measures was calculated using std() function and is listed in a table below.

| Measure | Standard deviation |
| ------ | ----- |
| CriticRating | 26.39239  |
| AudienceRating | 16.8277 |
| BudgetMillions | 48.63848 |

## Data relationships
Several plots were chosen to represent data relationships. Boxplots in Fig. 1 and Fig. 2 represent the relationship between rating and movie genre, showing data scatter, distribution and median. By comparing Audience and Critics ratings it can be seen that critic ratings are more spread out than the Audience ones. Also some of the genres had more data points than others. The effect of this is seen in the graph on Fig. 3 which shows relationship between Audience and Critics ratings per year and genre with overlayed trend. It can be clearly seen that some years and genres do not have enough data to produce meaningful results. Also there are some interesting observations that can be made, for example, looking at romance movies released in 2011 it can be seen that quite low critics rating of approximately 25 corresponds to a high audience rating of 75 which is quite unusual for other genres.

#### Fig. 1 Audience rating boxplot
![Fig. 1](https://github.com/daniel-lennart/data-portfolio/blob/master/images/plots/aud_boxplot.png)

#### Fig. 2 Critics rating boxplot
![Fig. 2](https://github.com/daniel-lennart/data-portfolio/blob/master/images/plots/critics_boxplot.png)

#### Fig. 3 Audience vs Critics
![Fig. 3](https://github.com/daniel-lennart/data-portfolio/blob/master/images/plots/aud_v_crit.png)

Fig. 4 and Fig. 5 show the relationship between budgets, ratings and genres.

#### Fig. 4 Audience rating vs Budget
![Fig. 4](https://github.com/daniel-lennart/data-portfolio/blob/master/images/plots/aud_v_budget.png)

#### Fig. 5 Critics rating vs Budget
![Fig. 5](https://github.com/daniel-lennart/data-portfolio/blob/master/images/plots/critics_v_budget.png)

Again, graphs show that critics ratings are more distributed, but we cannot conclude any obvious relationships between budget and the rating. It can be noted from this graphs that action movies tend to have bigger budgets along with adventure movies.  

Lastly, Fig. 6 presents budget distributions per genre.
#### Fig. 6 Budget distribution
![Fig. 6](https://github.com/daniel-lennart/data-portfolio/blob/master/images/plots/budgets.png)

## Normal distributions
From looking at the data histograms, interesting observation was made. Audience rating resembles normal distribution while critics ratings are more uniformly distributed. Fig. 6 and Fig. 7 illustrate this observation. This can be explained with a theory that audience is representing population and population opinion tends to be generally distributed, while critics rank movies according to the set of rules. This can also explain more widely distributed critics ratings.

![Fig. 7](https://github.com/daniel-lennart/data-portfolio/blob/master/images/plots/critics_hist.png) ![Fig. 7](https://github.com/daniel-lennart/data-portfolio/blob/master/images/plots/audience_hist.png)

In order to check if audience ratings are indeed normally distributed, random normal distribution was generated with same mean and standard deviation calculated earlier. Results were plotted with qqnorm() and are presented in the following plots

#### Randomly generated normal distribution
![Generated normal distribution](https://github.com/daniel-lennart/data-portfolio/blob/master/images/plots/gen_qqnorm.png)
#### Audience ratings
![Audience rating](https://github.com/daniel-lennart/data-portfolio/blob/master/images/plots/aud_nqqnorm.png)

From looking at the plots, it can be concluded that Audience ratings are indeed normally distributed.

## Linear regression
In order to investigate data relationships, linear regression was performed on some variables. Results are presented in following plots.

#### Audience and Critics ratings
![Audience rating vs Critics](https://github.com/daniel-lennart/data-portfolio/blob/master/images/plots/lm_crit_v_aud.png)

#### Audience rating and Budget
![Audience rating vs Budget](https://github.com/daniel-lennart/data-portfolio/blob/master/images/plots/lm_aud_v_budget.png)

#### Critics rating and Budget
![Critics rating vs Budget](https://github.com/daniel-lennart/data-portfolio/blob/master/images/plots/lm_crit_v_budget.png)

In both Audience vs Critics and Audience vs Budget there is a significant relationship between variables as p value is less than 0.05. However in case of critics rating and budget, p value is 0.781, hence it can be concluded that there is no relationship between budget and critics rating. Linear regression was performed with lm() function. Code snippet is presented below:
```
model2 <- lm(AudienceRating~BudgetMillions, data=movies)
ab <- ggplot(data=movies, aes(x=AudienceRating, y=BudgetMillions))
ab + geom_point()+
    geom_smooth(method='lm')
```
## Shiny application
Finally, an interface to explore the dataset has been developed in Shiny. It allows to subset and plot 2 variables, year, genre and switch between audience and critics rating for those years and genres. Screenshots are presented below
#### Shiny Audience ratings
![Critics rating vs Budget](https://github.com/daniel-lennart/data-portfolio/blob/master/images/plots/shiny-aud.png)
#### Shiny Critics ratings
![Critics rating vs Budget](https://github.com/daniel-lennart/data-portfolio/blob/master/images/plots/shiny-critics.png)
