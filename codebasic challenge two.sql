create database insights

select *  from  [dbo].[dim_cities]

select * from  [dbo].[dim_repondents]

select * from [dbo].[fact_survey_responses]

####Provide Insights to the Marketing Team in Food & Beverage Industry


1]Demographic Insights
q]Who prefers energy drink more?
select count(*) as count, Gender
from [dbo].[dim_repondents]
group by Gender

##b]Which age group Prefers energy drinks more?

select count(*) as count , Age
from [dbo].[dim_repondents]
group by age
order by count desc

c]Which type of marketing reaches the most youth?

select  count(*) as count,[dbo].[fact_survey_responses].Marketing_channels from [dbo].[dim_repondents] join [dbo].[fact_survey_responses]

on [dbo].[dim_repondents].Respondent_ID = [dbo].[fact_survey_responses].Respondent_ID

where [dbo].[dim_repondents].Age =  '15-18' or [dbo].[dim_repondents].Age = '19-30'

group by [dbo].[fact_survey_responses].Marketing_channels 

order by count desc




2] Consumer Prefernces
a] What are the prefereed Ingredients of energy drinks among respondents?
select  count(Ingredients_expected)as Number_of_Respondents,Ingredients_expected  
from [dbo].[fact_survey_responses]
group by Ingredients_expected 
order by Number_of_Respondents desc

b]What packaging preferences do respondents have for energy drinks?

select count(packaging_preference)as count, packaging_preference from [dbo].[fact_survey_responses]
group by packaging_preference
order by count desc


3]Competition Analysis
a]Who are the current market leaders?

select count(current_brands) as count , current_brands 
from [dbo].[fact_survey_responses]
group by current_brands
order by count desc

b]What are the primary reasons consumers prefer those brands over ours?

select count(Reasons_for_choosing_brands) as count , Reasons_for_choosing_brands 
from [dbo].[fact_survey_responses]
group by Reasons_for_choosing_brands
order by count desc



4]Marketing Channels and Brand Awareness
a]Which marketing channel can be used to reach more customers?

select count(Marketing_channels) as count , Marketing_channels 
from [dbo].[fact_survey_responses]
group by Marketing_channels
order by count desc

b]How effective are different marketing strategies and channels in reaching our 
customers? (need to cross check))

SELECT Marketing_channels, Packaging_Preference , price_range , COUNT(*) AS Customer_Count
FROM [dbo].[fact_survey_responses]
GROUP BY Marketing_channels , Packaging_Preference , price_range 
ORDER BY Customer_Count DESC;


5]Brand Penetration
a]What do people think about our brand? (overall rating)

select count(taste_experience) as rating ,Taste_experience
from [dbo].[fact_survey_responses]
group by taste_experience
order by rating desc

b]Which cities do we need to focus more on?

SELECT count([dbo].[dim_cities].City_ID)as city_count , [dbo].[dim_cities].City , [dbo].[fact_survey_responses].Taste_experience
FROM [dbo].[dim_cities]
JOIN [dbo].[dim_repondents] ON [dbo].[dim_cities].City_ID = [dbo].[dim_repondents].City_ID
JOIN [dbo].[fact_survey_responses] ON [dbo].[dim_repondents].Respondent_ID = [dbo].[fact_survey_responses].Respondent_ID
where Taste_experience = '5'
group by [dbo].[dim_cities].City , [dbo].[fact_survey_responses].Taste_experience
order by   city_count desc





6]Purchase Behavior
a]Where do respondents prefer to purchase energy drinks?

select count(Purchase_location) as location ,Purchase_location
from [dbo].[fact_survey_responses]
group by Purchase_location
order by location desc

b]What are the typical consumption situations for energy drinks among 
respondents?

select count(Typical_consumption_situations) as situation ,Typical_consumption_situations
from [dbo].[fact_survey_responses]
group by Typical_consumption_situations
order by situation desc


c]What factors influence respondents purchase decisions, such as price range and 
####limited edition packaging 

SELECT Price_range, Limited_edition_packaging, COUNT(*) AS Respondent_Count , Ingredients_expected
FROM [dbo].[fact_survey_responses]
GROUP BY Price_range, Limited_edition_packaging , Ingredients_expected
order by Respondent_Count desc


7]Product Development
a]Which area of business should we focus more on our product development?

select count(reasons_preventing_trying) , reasons_preventing_trying ,count(*)
from [dbo].[fact_survey_responses]
group by reasons_preventing_trying

select count(Taste_experience) , Taste_experience ,count(*)
from [dbo].[fact_survey_responses]
group by Taste_experience


select count(Improvements_desired) , Improvements_desired ,count(*)
from [dbo].[fact_survey_responses]
group by Improvements_desired

select count(General_perception) , General_perception ,count(*)
from [dbo].[fact_survey_responses]
group by General_perception


8]what is the main reason behind consuming energy drink?
select count(*) , consume_reason 
from [dbo].[fact_survey_responses]
group by Consume_reason


9] extract data for the popular brand by every city

 SELECT count([dbo].[dim_cities].City_ID)as city_count , [dbo].[dim_cities].City , [dbo].[fact_survey_responses].Current_brands
FROM [dbo].[dim_cities]
JOIN [dbo].[dim_repondents] ON [dbo].[dim_cities].City_ID = [dbo].[dim_repondents].City_ID
JOIN [dbo].[fact_survey_responses] ON [dbo].[dim_repondents].Respondent_ID = [dbo].[fact_survey_responses].Respondent_ID
group by [dbo].[dim_cities].City , [dbo].[fact_survey_responses].Current_brands
order by city


10]Which marketing channels are most effective in reaching consumers who have tried the companys energy drink before?

select Marketing_channels , count(tried_before ) ,tried_before
from [dbo].[fact_survey_responses]
where Tried_before = '1' and Marketing_channels = 'Online ads'
group by Marketing_channels , tried_before

11]
select price_range , count(*) as count
from [dbo].[fact_survey_responses]
group by price_range
order by count desc