# Introduction

Hello, welcome to Spatial Data Analysis Project. I am Aveek and this is a part of CS621B Spatial Databases module. *Next Slide*

In this project, we will try to analyse the apartments in Mumbai for rent or sale in 2020 and draw conclusions based on some  pre-defined conditions using PostGIS and QGIS.

Mumbai is one of the most populous metropolitan city in India with an ever increasing populuation of over 20M people. It is also considered as the economic captial of India due to the presence of a large number of industries and organization head quarters within the city. As a result, people from all over the country move to Mumbai with various prospects of studies and jobs and that makes the real estate sector boom with sky rocketing prices of apartments to rent or lease. *Next Slide*

# Motivation

A few months back, my cousin was trying to find a suitable apartment for sale within the city. She had few conditions to narrow down her search from the entire city of Mumbai to some specified locations. The conditions were as follows.

1. She wants to understand what are the rates of the properties in order to decide on her budget.
2. The apartment should be within 5kms radius of [Mumbai International Airport](https://www.google.com/maps/place/Chhatrapati+Shivaji+Maharaj+International+Airport/@19.0814197,72.8559774,14.43z/data=!4m5!3m4!1s0x3be7c85099bd2947:0x1ecc1a60c474a8ae!8m2!3d19.0895595!4d72.8656144) (as she works at the airport).
3. The apartment should be near the beach and have a sea facing view.
4. Finally, she also wanted to find out the fastest route to the [Mumbai Naval Dockyard](https://www.google.com/maps/place/Naval+Dockyard+Building,+Fort,+Mumbai,+Maharashtra+400001,+India/@18.9262575,72.8321752,17z/data=!3m1!4b1!4m5!3m4!1s0x3be7d1c4069faccb:0xf0ae6235c8bb1d79!8m2!3d18.9262575!4d72.834285) as my BIL works there.

This intrigued me to work on this project and find her a good apartment which meets most of her criteria. *Next Slide*

# Analysis

For the purpose of analysis, I have divided it into 5 parts. First, we will fetch the apartment price dataset from Kaggle and then visualize all the apartments available for rent or sale.
Next, we will try to analyze the apartment prices by dividing it into three ranges or bins, one: below 20K, second: 20K to 40K and third: above 40K. Then we will move forward by selecting the apartments within the range of 5km from  the airport. We will also continue our analysis by limiting the apartments that have a sea facing view and finally, we will plan the fastest route available to travel from the apartment to the Naval Dockyard. *Next Slide*

## View all data
Here, as you can see, I have fetched the data from Kaggle and loaded it into a table in Postgre and then imported it as a layer into QGIS. As you can see, all the apartments available for sale in Mumbai are marked in red.  *Next Slide*

This is data from the raw SQL table.  *Next Slide*



## Price Range Analysis
Moving on to the price range analysis, here I have created a calculated column in PostGre to find the price range of the apartments. Looking at the analysis, we can see that most of the houses are marked in red, i.e. they are priced above 40K. This gives us an idea that in order to secure an apartment near the airport, our budget should be above 40K.  *Next Slide*

The SQL behind calculating the price range is as shown below. I have added a new column and used a CASE statement to calculate the price ranges based on the house price. *Next Slide*

## Within 5km radius
Moving on to the next, we need to find the apartments that lie within the 5km range of the airport. Here I have built a view in SQL that takes the co-ordinates of the Mumbai International Airport and filter the apartments that fall within the radius.
In the analysis, I have marked all such apartments in green. *Next Slide*

Here is the view definition that filters the apartments within the 5km range of the airport. I have transformed the geometry points from EPSG:4326 to EPSG:7755 and then calculated the distance from the Mumbai Airport using ST_Distance Postgis function. *Next Slide*

## Sea facing
In this part where we find the sea facing apartments, we actually try to find out the apartments that are facing towards the sea. This is a tricky part to analyse as we need to assume a few things here. 
* First we assume that in order to have a sea facing apartment, it should be near the coastline. So we assume that any apartment within a distance of 1000m from the beach can be considered.
* Secondly, we can see that the coastline runs along from north to south. So in order to face the sea, the apartment should be west facing. The description column in the dataset provides that information and we can filter it using REGEX and create a view to fetch only those apartments that are within 5kms from the airport and face west.
* Once we perform both the above analysis, we can see a few apartments, as highlighted by the red arrow which suffices both the above criteria, i.e. it faces west and also within the 1000m distance from the beach.

From this, we can select and finalize any one apartment by physically visiting the places and examining the properties. *Next Slide*

Here are the SQL that does the heavy lifting behind the scenes. On the left, we create a view that gives us the buffer of 1000m from the coastline and on the right, we create another view that filters the west facing apartments based on the REGEX value. *Next Slide*

# Fastest Route
Assuming that we have finalized an apartment, we can calculate the fastest route to the Mumbai Naval Dockyard Junction. This can be done by using the plugin Open Route Service known as ORS Tools. After installing the plugin, you need to signup for it and obtain an API key to use it. 
As you can see in the figure above, we have selected the starting point as the home and the end point as Naval Dockyard Junction. The above picture shows the route to be taken while driving a car and the distance is around 19.5 kms. *Next Slide*

This is the example of ORS Tools where we select and provide information about the start and the end point of the route. *Next Slide*

# Conclusion
With this, I have completed my analysis and was able to aid her in finding a suitable apartment matching her criteria.
Thank you.

The code for the project is hosted on Github and the link is mentioned here.