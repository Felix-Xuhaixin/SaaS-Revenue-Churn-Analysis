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

### 🍽️ Cuisine Analysis  

- Top 3 cuisine with highest grades are **North American**(75.38% grade A), **Neutral**(74.97% grade A) and **European**(68.65% grade A).
- The **Filipino**(25.97% grade C),**Bangladeshi**(24.16% grade C),**Creole**(24.12% grade C),**Pakistani**(22.94 grade C) and **African**(21.72% grade C) are the top 5 cuisine with lowest score.
- The cuisine with the highest proportion of 'Critical' are **Czech**(69.23%), **Creole**(60.32%), **Bangladeshi**(60.12%) and **Pakistani**(59.93%); The geographic cuisine with the highest proportion of 'Critical' is **South Asian**(58.94%); The geographic cuisine with the highest proportion of 'Critical' are **Ethnic cuisine**(55.65%) and **Fine dining**(55.36%) 


## 💡 Recommendations 

1. Improve re-inspection frequency in high-risk areas and restaurants
2. Targeted education for cuisines with frequent violations.
3. A city campaign to train food workers on hygiene and safety.
4. Restaurants should adhere to temperature control guidelines.
5. Pass legislation for restaurants to have internal quality assurance managers to ensure compliance to the health codes.


### 🙏 Credit

- **[Analyst Builder](https://www.analystbuilder.com/projects/restaurant-health-inspection-analysis-nyc-FhAOm)** for the datasets and the directions for the analysis.

- **[NYC Environmental Health Services team at DOHMH](https://github.com/nycehs/NYC_geography)** for the topo-json of NYC.  

---

📬 Contact
If you'd like to connect, collaborate, or discuss this project further:

📧 **Email:** felix.xuhaixin@gmail.com

🧠 **GitHub Profile:** [Felix Xu](https://github.com/Felix-Xuhaixin)




