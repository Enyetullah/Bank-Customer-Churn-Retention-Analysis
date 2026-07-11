# Business Insights

## Executive Overview

The dataset contains 10,000 bank customers. Of these customers, 2,037 churned and 7,963 remained with the bank, resulting in an overall churn rate of 20.37%.

The average customer was approximately 38.92 years old, had an average credit score of 650.53, and maintained an average account balance of approximately 76,485.89.

The analysis identified customer age, membership activity, geography, product usage, and account balance as important characteristics associated with differences in churn.

## 1. Geography

Germany had the highest churn rate at approximately 32.44%, compared with 16.67% in Spain and 16.15% in France.

This indicates that customers in Germany experienced substantially higher churn than customers in the other two markets. Regional differences in customer experience, product availability, service quality, competition, or customer expectations may require further investigation.

### Recommendation

Review customer feedback, service performance, product usage, and customer support activity in Germany. Regional retention campaigns may be appropriate if additional analysis confirms the pattern.

---

## 2. Membership Activity

Inactive customers had a churn rate of approximately 26.85%, while active customers had a churn rate of approximately 14.27%.

Inactive customers were therefore considerably more likely to leave than active customers.

### Recommendation

Develop engagement campaigns for customers showing reduced activity. Possible actions include personalized account reminders, product education, loyalty offers, and targeted communication before customers become fully disengaged.

---

## 3. Customer Age

Churn varied substantially across age groups.

- Under 30: approximately 7.56%
- Age 30-39: approximately 10.88%
- Age 40-49: approximately 30.79%
- Age 50-59: approximately 56.04%
- Age 60+: approximately 27.95%

Customers between ages 50 and 59 had the highest churn rate. Customers between ages 40 and 49 also experienced much higher churn than younger customers.

Churned customers had an average age of approximately 44.84 years, which was higher than the overall customer average.

### Recommendation

Investigate the needs and service experiences of customers between ages 40 and 59. Retention programs should consider age-related product preferences, communication methods, financial goals, and customer support needs.

---

## 4. Product Usage

Customers with two products had the lowest churn rate at approximately 7.58%.

Customers with one product had a considerably higher churn rate of approximately 27.71%.

Customers with three products had a churn rate of approximately 82.71%, while customers with four products had a churn rate of 100%. However, the three-product and four-product groups were much smaller, with only 266 and 60 customers respectively.

### Recommendation

Encourage suitable one-product customers to adopt a second relevant product because two-product customers showed substantially stronger retention.

The very high churn rates among customers with three or four products should be investigated carefully. Possible explanations may include product complexity, fees, poor product fit, customer service issues, or characteristics unique to these smaller groups.

The 100% churn rate among four-product customers should not be generalized without considering the small segment size.

---

## 5. Account Balance

Churned customers maintained an average balance of approximately 91,108.54, which was higher than the overall average balance.

Customers with positive balances generally showed higher churn than customers with zero balances.

This suggests that some customers leaving the bank may represent financially valuable relationships.

### Recommendation

Prioritize retention outreach using both churn risk and customer value. Customers with high balances and elevated churn risk may require proactive service reviews, personalized support, and targeted retention offers.

---

## 6. Gender

Female customers had a churn rate of approximately 25.07%, while male customers had a churn rate of approximately 16.46%.

This difference identifies a pattern that may require further investigation. The analysis does not establish why the difference exists.

### Recommendation

Review customer satisfaction, product usage, service interactions, and account experiences by gender. Avoid assuming that gender itself causes churn; use additional behavioral and customer-experience data to investigate the pattern.

---

## 7. Credit Score

Churn rates were relatively similar across most credit-score groups.

Credit score showed a weaker relationship with churn than age, geography, membership activity, or product usage.

### Recommendation

Credit score should not be treated as a primary churn indicator by itself. It may still be useful when combined with behavioral and account characteristics.

---

## 8. Customer Tenure

Churn rates were relatively similar across tenure groups.

This suggests that the number of years a customer had been with the bank was not one of the strongest churn indicators in this dataset.

### Recommendation

Use engagement, product usage, customer age, geography, and account behavior together with tenure rather than relying on tenure alone.

---

## 9. Credit Card Ownership

Customers with and without credit cards had very similar churn rates.

- No credit card: approximately 20.81%
- Has credit card: approximately 20.18%

Credit-card ownership alone did not appear to have a strong relationship with churn.

### Recommendation

Do not prioritize credit-card ownership as a major standalone churn indicator. Product engagement and customer activity appear more informative.

---

## 10. Exploratory Customer Risk Segments

The rule-based exploratory risk segmentation produced three groups:

- Low Risk: approximately 4.27% churn
- Medium Risk: approximately 15.37% churn
- High Risk: approximately 41.84% churn

The high-risk group contained approximately 2,842 customers.

The exploratory score used customer activity, age, product usage, and account balance. It was created for descriptive analysis and should not be interpreted as a machine-learning prediction.

### Recommendation

Use the exploratory groups to organize further investigation and retention testing. Before using the score operationally, validate it on new customer data and compare its performance with a formal predictive model.

---

# Overall Recommendations

1. Prioritize inactive customers because they experienced substantially higher churn than active customers.

2. Investigate the high churn rate in Germany and identify regional customer-experience or product-related issues.

3. Develop targeted retention strategies for customers between ages 40 and 59.

4. Encourage suitable one-product customers to adopt a second relevant product.

5. Investigate the unusually high churn among customers with three or four products while considering the small size of these customer groups.

6. Prioritize high-balance customers with elevated churn risk because their departure may represent greater customer-value loss.

7. Use customer behavior, activity, age, geography, and product usage together instead of relying on a single characteristic.

8. Test retention strategies through controlled campaigns and measure changes in engagement and churn over time.