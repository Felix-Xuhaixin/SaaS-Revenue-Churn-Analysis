# libraries
library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)
library(lubridate)
library(GGally)

# 1. Import and Explore

# Load both CSVs.

df <- read.csv("D:\\Data Analysis\\1.Projects\\3.SaaS Revenue & Churn Analysis\\Resources\\subscriptions.csv")

Revenue <- read.csv("D:\\Data Analysis\\1.Projects\\3.SaaS Revenue & Churn Analysis\\Resources\\monthly_revenue.csv")

# Understand the structure, check for missing values, and get familiar with the fields.


# 2. Churn Analysis

# Calculate churn rate by plan, billing cycle, acquisition channel, and company size.
avg_churn_rate <- round(sum(ifelse(df$churned == "Yes",1,0)) / nrow(df) * 100,2)

plan_churn_rate <- df %>%
  group_by(plan) %>%
  summarize(churn_rate = round(sum(ifelse(churned == "Yes",1,0))/ n() * 100,2)) %>%
  arrange(desc(churn_rate))
# Plan churn rate are :Starter(70.51%), Professional(47.98%), Business(41.25%), Enterprise(22.00%).
  rm(plan_churn_rate)

billing_cycle_churn_rate <- df %>%
  group_by(billing_cycle) %>%
  summarize(churn_rate = round(sum(ifelse(churned == "Yes",1,0))/ n() * 100,2)) %>%
  arrange(desc(churn_rate))
# Billing cycle churn rate are : Monthly(60.51%),Annual(40.32%).
  rm(billing_cycle_churn_rate)

acquisition_channel_churn_rate <- df %>%
  group_by(acquisition_channel) %>%
  summarize(churn_rate = round(sum(ifelse(churned == "Yes",1,0))/ n() * 100,2)) %>%
  arrange(desc(churn_rate))
# Acquisition channel churn rate are : Referral(61.29%), Partner(58.00%), Social Media(55.77%), Paid Ads(53.04%), Organic Search(43.79%), Direct Sales(39.29%)
  rm(acquisition_channel_churn_rate)

company_size_churn_rate <- df %>%
  group_by(company_size) %>%
  summarize(churn_rate = round(sum(ifelse(churned == "Yes",1,0))/ n() * 100,2)) %>%
  arrange(desc(churn_rate))
company_size_churn_rate $churn_rate
# Company size churn rate are: 500+(63.16%), 1-10(56.69%), 201-500(53.41%), 11-50(52.84%), 51-200(42.55%)
  rm(company_size_churn_rate)

# Identify the highest-risk segments.
# What are the top 3 reasons customers churn, and do these reasons differ by plan type or company size?
top3_reasons_churn <- df %>%
  filter(churn_reason != "") %>%
  group_by(churn_reason) %>%
  summarize(reason_amount = n()) %>%
  arrange(desc(reason_amount)) %>%
  head(3)
# The top 3 reasons that cause customers to churn are Budget Cuts, Price Too High, Company Closed.
churn_reason_by_plan <- df %>%
  filter(churn_reason != "") %>%
  group_by(plan,churn_reason) %>%
  summarise(reason_amount = n(),.groups = "drop_last") %>%
  mutate(rank = rank(desc(reason_amount),ties.method = "min")) %>%
  filter(rank == 1)
# For Starter and Professional customers, the most common reasons for churn are budget cuts and prices being too high; however, the primary reason for churn among Business customers is missing features. Enterprise customers have the lowest churn rate, and their main churn reasons are company closure and no longer needing the service.  

churn_reason_by_companysize <- df %>%
  filter(churn_reason != "") %>%
  group_by(company_size,churn_reason) %>%
  summarise(reason_amount = n(),.groups = "drop_last") %>%
  mutate(rank = rank(desc(reason_amount),ties.method = "min")) %>%
  filter(rank == 1)
# For small companies(1-10), the most common reasons for churn is budget cuts; however,for big Companies(500+) the primary reasons for churn are company closure and poor support. 


  # 3.Revenue Trends
# Plot monthly MRR over time.

Revenue <- Revenue %>%
  mutate(date = parse_date_time(month,order = "Y-m"))

Revenue %>%
  ggplot(aes(x = date, y = total_mrr, group = 1)) +
  geom_line() +
  geom_point(color = "steelblue", size = 1) +
  labs(title = "Monthly MRR",y = "Revenue") +
  scale_x_date(
    date_breaks = "1 year", # optional: set breaks to every year
    date_labels = "%Y-%m"      # format labels as four-digit years
  ) +
  scale_y_continuous(labels = scales::number_format(accuracy = 1),breaks = seq(0, 300000, by = 50000)) +
  theme(axis.title.x = element_blank())
  
    
sum(Revenue$total_mrr)


# Calculate net revenue retention (new MRR minus churned MRR). Identify months with unusual spikes or dips.

Revenue %>%
  mutate(nrr = (new_customers - churned_customers) * avg_revenue_per_customer) %>%
  select(month,nrr) %>%
  filter(nrr == max(nrr,na.rm = TRUE)|nrr == min(nrr,na.rm = TRUE))
# 2024-03 has the highest net revenue retention 15573; 2025-04 has the lowest net revenue retention -4263.56


# 4. Unit Economics
# Compute average CLV per plan using average MRR and average customer lifespan.
# Monthly Churn Rate = Customers Lost During Month / Customers at Start of Month
# Average Customer Lifespan = 1 / Monthly Churn Rate

avg_mrr_by_plan <- df %>%
  group_by(plan) %>%
  summarize(avg_mrr = mean(monthly_revenue,na.rm = TRUE),.groups = "drop")

Signup_Churn <- df %>%
  select(customer_id,plan,signup_date,churned,churn_date) %>%
  mutate(signup_month = format(as.Date(signup_date,format ="%Y-%m-%d"),"%Y-%m"),
         churn_month = format(as.Date(churn_date,format ="%Y-%m-%d"),"%Y-%m"))

signup <- Signup_Churn %>%
  group_by(plan,signup_month) %>%
  summarize(amount_signup = n(),.groups = "drop")

churn <- Signup_Churn %>%
  filter(!is.na(churn_month)) %>%
  group_by(plan,churn_month) %>%
  summarize(amount_churn = n(),.groups = "drop")

monthly_churn_rate <- signup %>%
  left_join(churn,by = c("plan","signup_month" = "churn_month")) %>%
  mutate(amount_churn = replace_na(amount_churn,0)) %>%
  group_by(plan) %>%
  mutate(net_increase_num = amount_signup - amount_churn,
         total_num = cumsum(net_increase_num), 
         churn_rate = amount_churn / lag(total_num),)
  
avg_CLV <- monthly_churn_rate %>%
  group_by(plan) %>%
  summarize(avg_churn_rate = mean(churn_rate,na.rm = TRUE),
            Average_Customer_Lifespan = 1 / avg_churn_rate) %>%
  inner_join(avg_mrr_by_plan,by = "plan") %>%
  mutate(average_CLV = round(Average_Customer_Lifespan * avg_mrr,2)) %>%
  arrange(desc(average_CLV))
# By plan the Enterprise has the highest average CLV(319704),the second highest average CLV is Business(51371), the next is Professional(14702), and the lowest average CLV is Starter(1891).

# Compare CLV to CAC to determine the CLV:CAC ratio.
CLV_CAC_ratio <- mean(Revenue$avg_revenue_per_customer) / mean(Revenue$customer_acquisition_cost)


# 5. At-Risk Indicators
# Analyze the relationship between feature usage and churn. Define a threshold (e.g., feature usage below X%) that flags at-risk customers, and estimate how many current customers fall into that bucket.
churn_feature_usage <- df %>%
  filter(churned == 'Yes') %>%
  select(feature_usage_pct)

ggplot(churn_feature_usage, aes(x=feature_usage_pct))+
  geom_bar(aes(x = feature_usage_pct), fill="steelblue1", width = 1) +
  geom_density(aes(y = stat(count))) +
  ggtitle("Distribution of Feature Usage for Churned Customers")

summary(churn_feature_usage$feature_usage_pct)

retention_feature_usage <- df %>%
  filter(churned == 'No') %>%
  select(feature_usage_pct)

ggplot(retention_feature_usage, aes(x=feature_usage_pct))+
  geom_bar(aes(x = feature_usage_pct), fill="steelblue1", width = 1) +
  geom_density(aes(y = stat(count))) +
  ggtitle("Distribution of Feature Usage for Retained Customers")

summary(retention_feature_usage$feature_usage_pct)

amount_of_risk_customers <- df %>%
  filter(churned == "No" & feature_usage_pct < 50 ) %>%
  nrow()

# The average churn rate is 52.17%. For churned customers, the maximum feature usage is 50, and the median feature usage for currently retained customers is 53, which indicates that customers with feature usage below 50 are at high risk of churning. Therefore, if we hypothetically set feature usage below 50 as the threshold, then the number of current customers at risk of churning is 132.  




