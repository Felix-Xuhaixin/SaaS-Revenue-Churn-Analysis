# **SaaS Revenue Churn Analysis**

---

## 📌 Project Overview

 In this project I analyzed churn rates by different dimensions, monthly recurring revenue (MRR), customer behavior to identify what is causing churn and the relationship between feature usage and churn. This type of analysis contributes to making strategic decisions in finance, product analytics, and growth.

## 🎯 Objectives

- To analyze trends monthly churn rate
- To identify the highest churn rate by plan, billing cycle, acquisition channel
- To find the top3 reasons cause the customers churn 
- To caculate CLV by plan and compare CLV to CAC

## 🛠️ Tools Used


- R: dplyr, tidyr, ggplot2, scales, lubridate and GGally 

## 🧠 Skills Demonstrated

- R analysis using  dplyr, tidyr, scales, lubridate
- Interactive dashboards with ggplot2, GGally
  
---

## 🔍 Key Findings  

### 📌 Churn Analysis  
- By plan, churn rates are :Starter(70.51%), Professional(47.98%), Business(41.25%), Enterprise(22.00%);
- By billing cycle, churn rates are : Monthly(60.51%),Annual(40.32%); 
- By acquisition channel, churn rates are : Referral(61.29%), Partner(58.00%), Social Media(55.77%), Paid Ads(53.04%), Organic Search(43.79%), Direct Sales(39.29%)
- By Company size, churn rates are: 500+(63.16%), 1-10(56.69%), 201-500(53.41%), 11-50(52.84%), 51-200(42.55%)

- For Starter and Professional customers, the most common reasons for churn are budget cuts and prices being too high; however, the primary reason for churn among Business customers is missing features. Enterprise customers have the lowest churn rate, and their main churn reasons are company closure and no longer needing the service.

- For small companies(1-10), the most common reasons for churn is budget cuts; however,for big Companies(500+) the primary reasons for churn are company closure and poor support.

### 🚨 Revenue Trends
- <img width="946" height="580" alt="Monthly MRR" src="https://github.com/user-attachments/assets/c3941b20-87f9-4fac-960c-9a8ca89a8f1c" />

- 2024-03 has the highest net revenue retention 15573; 2025-04 has the lowest net revenue retention -4263.56

### 🍽️ Unit Economics
- By plan, the Enterprise has the highest average CLV(319704), the second highest average CLV is Business(51371), the next is Professional(14702), and the lowest average CLV is Starter(1891)
- CLV:CAC ratio is 5.05

## 💡 At-Risk Indicators 
- The average churn rate is 52.17%. For churned customers, the maximum feature usage is 50, and the median feature usage for currently retained customers is 53, which indicates that customers with feature usage below 50 are at high risk of churning. Therefore, if we hypothetically set feature usage below 50 as the threshold, then the number of current customers at risk of churning is 132.

### 🙏 Credit

- **[Analyst Builder](https://www.analystbuilder.com/projects/saas-revenue-churn-analysis-UPoYs?tab=overview)** for the datasets and the directions for the analysis.

---

📬 Contact
If you'd like to connect, collaborate, or discuss this project further:

📧 **Email:** felix.xuhaixin@gmail.com

🧠 **GitHub Profile:** [Felix Xu](https://github.com/Felix-Xuhaixin)




