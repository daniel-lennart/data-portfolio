######################################################
# Programming languages for data engineering
# R programming course assignment
# Author: Daniel Lennart
# Dataset: Movie ratings, genres and budgets 2007-2011
######################################################
library(ggplot2)

# Load dataset into data frame
movies<- read.csv("Movie-Ratings.csv")
# rename columns to get rid of special characters
colnames(movies)<-c("Film", "Genre", "CriticRating", "AudienceRating",
                    "BudgetMillions", "Year")
factor(movies$Genre)

# check stucture of the data (6 variables:562 objects loaded)
str(movies)

# Basic statistical measures (means, medians, std deviation)
# str() will return min, max, mean, median for numeric data
# and aggregated categorical data.
summary(movies)

# standard deviations for numerical data
sd_cr <- sd(movies$CriticRating)
sd_ar <- sd(movies$AudienceRating)
sd_bud <- sd(movies$BudgetMillions)
# display all standard deviations
sd_cr
sd_ar
sd_bud

# Plot relationships in the data (one or more)

# add common theme for all graphs
plot_theme <- theme(axis.title.x = element_text(colour = "DarkGreen", size = 20),
                axis.title.y = element_text(colour = "Red", size = 20),
                axis.text.x = element_text(size=10),
                axis.text.y = element_text(size=10),

                plot.title = element_text(colour = "DarkBlue", size=25,
                                          family = "Courier"))

 # Critics rating v Audience rating
 crit_v_aud <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                                       colour=Genre))
 crit_v_aud + geom_point(aes(size=BudgetMillions)) +
     facet_grid(Genre~Year) +
     geom_smooth() +
     plot_theme +
     xlab("Critics rating") +
     ylab("Audience rating") +
     ggtitle("Audience v Critics rating per year and genre") +
     coord_cartesian(ylim = c(0,100))


 ## Audience v Budget
 aud_v_bud <- ggplot(data=movies, aes(x=BudgetMillions, y=AudienceRating,
                              colour=Genre, size=BudgetMillions))
 aud_v_bud + geom_point(aes(x=BudgetMillions)) +
     xlab("Budget in millions") +
     ylab("Audience rating") +
     ggtitle("Audience rating v Budget") +
     plot_theme


 ## Critics v Budget
 aud_v_bud <- ggplot(data=movies, aes(x=BudgetMillions, y=CriticRating,
                                      colour=Genre, size=BudgetMillions))
 aud_v_bud + geom_point(aes(x=BudgetMillions)) +
     xlab("Budget in millions") +
     ylab("Critic rating") +
     ggtitle("Critics rating v Budget") +
     plot_theme

 ## Boxplots
 # Audience
 aud_plot <- ggplot(data=movies, aes(x=Genre, y=AudienceRating,
                              colour=Genre))
 aud_plot + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5) +
     plot_theme +
     xlab("Genres") +
     ylab("Audience rating") +
     ggtitle("Audience rating per genre")

 # Critics
 crit_plot <- ggplot(data=movies, aes(x=Genre, y=CriticRating,
                              colour=Genre))
 crit_plot + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5) +
     plot_theme +
     xlab("Genres") +
     ylab("Critics rating") +
     ggtitle("Critics rating per genre")

 ## Histogram
 o <- ggplot(data=movies, aes(x=BudgetMillions))
 h <- o + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")
 h + xlab("Millions") +
     ylab("Number of movies") +
     ggtitle("Movie Budget distribution") +
     plot_theme


# Investigate if data has normal distribution
 ## Audience rating distribution
 rating <- ggplot(data=movies, aes(x=AudienceRating))
 rating + geom_histogram(binwidth = 10,
                         fill="White", colour="Blue") +  # Norm distribution
     plot_theme +
     xlab("Audience rating") +
     ylab("Count") +
     ggtitle("Audience rating distribution")

 # Density plots
  rating + geom_density(aes(fill=AudienceRating), position="stack")
  qqnorm(movies$AudienceRating);qqline(movies$AudienceRating, col=2)

 ## critics rating distribution
 rating + geom_histogram(binwidth = 10,
                         aes(x=CriticRating), # ovveride aesthetics
                         fill="White", colour="Blue") + # uniform critics rely on rules
     plot_theme +
     xlab("Critics rating") +
     ylab("Count") +
     ggtitle("Critics rating distribution")

# Compare with generated normal distribution
 norm_dist <- rnorm(n=562, sd=16.8, mean=58.83)
 uni_dist <- runif(n=562, min=0, max=97)
 # Plot norm dist for comparison
 # name columns while assigning
 generated_df <- data.frame(gen_audience=norm_dist, gen_critics=uni_dist)
 norm_plot <- ggplot(data=generated_df, aes(x=gen_audience))
 norm_plot + geom_histogram(binwidth = 10,
                         fill="White", colour="Blue") +  # Norm distribution
     plot_theme +
     geom_density(aes(fill=gen_audience), position="stack") +
     xlab("Generated Audience rating") +
     ylab("Count") +
     ggtitle("Generated Audience rating distribution")

 # Density plots
 norm_plot + geom_density(aes(fill=gen_audience), position="stack")
 qqnorm(norm_dist);qqline(norm_dist, col=2)


 uni_plot <- ggplot(data=generated_df, aes(x=gen_critics))
 uni_plot + geom_histogram(binwidth = 10,
                            fill="White", colour="Blue") +  # Norm distribution
     plot_theme +
     xlab("Generated Critics rating") +
     ylab("Count") +
     ggtitle("Generated Critics rating distribution")


# Explore with linear regression Present result of linear regression graphically
 pairs(movies)
 model <- lm(AudienceRating~CriticRating, data=movies)
 ac <- ggplot(data=movies, aes(x=AudienceRating, y=CriticRating))
 ac + geom_point()+
     geom_smooth(method='lm')
 summary(model)
 confint(model)
 anova(model)

 model2 <- lm(AudienceRating~BudgetMillions, data=movies)
 ab <- ggplot(data=movies, aes(x=AudienceRating, y=BudgetMillions))
 ab + geom_point()+
     geom_smooth(method='lm')
 summary(model2)
 anova(model2)
 model3 <- lm(CriticRating~BudgetMillions, data=movies)
 cb <- ggplot(data=movies, aes(x=CriticRating, y=BudgetMillions))
 cb + geom_point()+
     geom_smooth(method='lm')
 summary(model3)
 anova(model3)
