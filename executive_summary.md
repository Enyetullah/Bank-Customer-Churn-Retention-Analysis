# Executive Summary

This project analyzes customer churn for a bank using Python, PostgreSQL, SQL, and Power BI. The objective was to identify customer characteristics associated with higher churn and provide retention-focused business recommendations.

The dataset contains 10,000 customers. A total of 2,037 customers churned, resulting in an overall churn rate of 20.37%.

Customer activity was strongly associated with churn. Inactive customers had a churn rate of approximately 26.85%, compared with 14.27% among active customers. Customer age also showed substantial differences. Customers between ages 50 and 59 had the highest churn rate at approximately 56.04%, while customers under age 40 had much lower churn.

Geography was another important factor. Germany had a churn rate of approximately 32.44%, almost twice the rates observed in France and Spain.

Product usage revealed an important retention pattern. Customers with two products had the lowest churn rate at approximately 7.58%, while customers with one product had a churn rate of approximately 27.71%. Customers with three or four products experienced very high churn, although these groups contained far fewer customers and should be investigated carefully.

Churned customers were older and maintained higher average account balances than the overall customer population. This suggests that some customer losses may involve financially valuable accounts.

The analysis recommends prioritizing inactive customers, customers between ages 40 and 59, high-risk customers with meaningful account balances, and selected customer groups in Germany. The bank should also investigate opportunities to move suitable one-product customers toward a second relevant product.

The exploratory customer risk score used in the dashboard is a descriptive segmentation method rather than a predictive machine-learning model.