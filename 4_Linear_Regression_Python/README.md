# E-commerce Customer Spending Prediction (Python, Linear Regression)

This project takes a customer dataset from an online retailer and tries to answer a practical question: should the business put more effort into its mobile app or its website. Rather than going on a hunch, a linear regression model is used to see which platform actually correlates more with revenue.

## Dataset

Source: https://www.kaggle.com/datasets/kolawale/focusing-on-mobile-app-or-website

Each row is a customer, with a handful of behavioral columns and the value we're trying to predict:

* Avg. Session Length: average length of the customer's styling sessions
* Time on App: average minutes spent using the mobile app
* Time on Website: average minutes spent on the site
* Length of Membership: number of years the customer has been signed up
* Yearly Amount Spent: the target, total dollars spent per year

## Why this project

It's a common beginner regression exercise, but a useful one, since the business question is narrow and concrete: app or website, which one actually matters. That makes it possible to interpret the model's output directly instead of just fitting something and calling it done.

## Tools

Python throughout, pandas and seaborn for exploring the data, scikit learn for fitting the regression, and statsmodels for a closer statistical look afterward.

## Process

**1. Explored the data**

Before fitting anything, each feature was checked against yearly spend individually. Website time showed almost no pattern against spend. App time had a mild upward trend. Once the pairplot and a regression plot of membership length against spend came up, membership length was clearly the strongest relationship in the dataset.

**2. Split into train and test sets**

Used scikit learn's `train_test_split` to hold back 30 percent of the rows as a test set, so the model's performance could be checked against customers it never trained on.

**3. Fit the model**

Trained a multiple linear regression using `Avg. Session Length`, `Time on App`, `Time on Website`, and `Length of Membership` as inputs, with `Yearly Amount Spent` as the target. The learned coefficients came out as:

| Feature | Coefficient |
|---|---|
| Avg. Session Length | 25.72 |
| Time on App | 38.60 |
| Time on Website | 0.46 |
| Length of Membership | 61.67 |

**4. Measured how well it performs**

Scoring the model against the test set gave an R squared of about 0.981, meaning it accounts for roughly 98 percent of the variation in yearly spend for customers it never saw while training.

**5. Added a statsmodels summary**

Scikit learn only hands back coefficients, so the same regression was run through statsmodels to get p values and confidence intervals on top. That confirmed Avg. Session Length, Time on App, and Length of Membership all carry a p value of 0.000, so their effect on spending is essentially certain to be real. Time on Website came back with a p value of 0.377, well above the standard 0.05 threshold, meaning there's no solid evidence it affects spending at all based on this data.

**6. Looked at the residuals**

Plotted the residuals (actual spend minus predicted spend) to confirm the model wasn't consistently biased in one direction. They landed roughly centered at zero and close to a normal distribution, which is what you'd expect from a reasonably well fit linear model.

## Takeaways

* Membership length is the strongest driver of yearly spend by a clear margin, with app usage as the second biggest factor
* Website time has essentially no measurable effect and fails to reach statistical significance (p = 0.377)
* The model accounts for about 98 percent of the variation in spend on data it wasn't trained on (R squared of 0.981)
* Comparing the two platforms, the numbers favor investing more in the app, since the website's connection to spending doesn't hold up once it's actually tested

## Lessons learned

* Coefficient size on its own doesn't tell the whole story, checking p values from an OLS summary is what actually shows whether an effect is real or just noise
* Scoring should always happen on a held out test set, scoring against training data would have inflated the R squared
* A pairplot early in the process is a fast way to spot which relationships are worth exploring before any modeling starts

## Files

* `Python_Linear_Regression.ipynb`, the full notebook covering data exploration, model training, and evaluation
