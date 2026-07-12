# Ecommerce Customer Spending Prediction (Python, Linear Regression)

This project uses a customer dataset from an ecommerce company to figure out whether the business should focus more on their mobile app or their website. Instead of guessing, the idea is to let a linear regression model tell us which one actually drives more revenue.

## Dataset

Dataset here: https://www.kaggle.com/datasets/kolawale/focusing-on-mobile-app-or-website

For every customer we have a few behavioral columns plus the target we care about:
- Avg. Session Length: average length of in-store style advice sessions
- Time on App: average minutes spent on the app
- Time on Website: average minutes spent on the website
- Length of Membership: how many years the customer has been a member
- Yearly Amount Spent: the target, how much the customer spends per year

## Why I did this

This is a classic beginner regression project, but it's a good one because the business question is simple and concrete: app or website, which one matters more. That makes it easy to actually interpret the model output instead of just fitting something and moving on.

## Tools

Python, using pandas and seaborn for exploration, scikit learn for the regression model, and statsmodels for a deeper statistical check on top of that.

## What I did, step by step

**1. Explored the data first**

Before building anything, I looked at how each feature relates to yearly spend. Time on the website barely showed any pattern against spend. Time on the app looked mildly positive. Once I got to the pairplot and a regression plot of length of membership against spend, that one stood out clearly as the strongest relationship in the whole dataset.

**2. Split the data**

Used scikit learn's `train_test_split` to hold back 30% of the data as a test set, so the model could be checked against customers it never saw during training.

**3. Trained the model**

Fit a multiple linear regression using `Avg. Session Length`, `Time on App`, `Time on Website`, and `Length of Membership` as inputs, and `Yearly Amount Spent` as the target. Looking at the coefficients afterward:

| Feature | Coefficient |
|---|---|
| Avg. Session Length | 25.72 |
| Time on App | 38.60 |
| Time on Website | 0.46 |
| Length of Membership | 61.67 |

**4. Checked how good the model actually is**

Scored the model on the test set and got an R squared of about 0.981, meaning it explains roughly 98% of the variation in yearly spend on customers it wasn't trained on.

**5. Went a step further with statsmodels**

Scikit learn gives you coefficients but not much else, so I ran the same regression through statsmodels to get p values and confidence intervals. This confirmed that Avg. Session Length, Time on App, and Length of Membership all have a p value of 0.000, meaning their effect on spend is essentially certain to be real. Time on Website came back with a p value of 0.377, way above the usual 0.05 cutoff, meaning there's no real evidence it has any effect on spending at all, based on this data.

**6. Checked the residuals**

Plotted the residuals (actual minus predicted spend) to make sure the model wasn't systematically off in one direction. They came out roughly centered around zero and close to normally distributed, which is what you want to see from a well fit linear model.

## Key Findings
- Length of membership is by far the strongest driver of yearly spend, followed by time on the app
- Time on the website has almost no measurable effect and isn't statistically significant (p = 0.377)
- The model explains about 98% of the variation in spend on unseen data (R squared of 0.981)
- Between the two platforms, the data points toward investing more in the app experience, since the website's relationship with spending doesn't hold up once actually tested

## Things I learned
- Coefficient size alone isn't enough, checking the p value from an OLS summary is what actually tells you whether a feature's effect is real or just noise
- Always score a model on a test set it hasn't seen, scoring on the training data would have made the R squared look artificially better
- A pairplot early on is a quick way to spot which relationships are worth digging into before building any model

## Files
- `Python_Linear_Regression.ipynb` — full notebook covering data exploration, model training, and evaluation
