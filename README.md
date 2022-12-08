![banner](https://user-images.githubusercontent.com/89077571/186985006-1055aae2-afa3-471c-b57a-84618406c226.png)
![beverages](https://user-images.githubusercontent.com/89077571/186986593-f3060000-0def-42a6-a823-864ff8ee3a3a.png)

# INTRODUCTION

Beverage stores data about various alcoholic drinks such as Wines, Beers, and Spirits and can also track your alcohol consumption.

![infoBeverages](https://user-images.githubusercontent.com/89077571/187050688-83ff042f-77cd-410d-85dc-db25ff8ce8f3.png)

# DATA
To store the data I chose to use Core Data for its ability to fetch data more efficiently and filter with the system of predicates.

The data is initially loaded towards the database on first app launch from a JSON file. Since I could not find any API for alcoholic drinks, I created the JSON file manually. It took me a while but I filled the database with **20 Wines**, **10 Beers**, and **10 Spirits**.
### :warning: Disclaimer

I do not own the data used for this app. Therefore, I borrowed them from different sources:

* Wines & Spirits → [Vinello](http://vinello.eu) 

* Beers → [Saveur Bière](http://saveur-biere.com/) & [Best Beer Near Me](https://bestbeernearme.com/wp-content/uploads/2020/10/food-and-beer-pairings-1024x999.jpg)

### Information of a beverage is presented on 3 cards:

![data](https://user-images.githubusercontent.com/89077571/187097573-c6366212-f27b-4ba0-9148-b1a1ca1e3cde.png)

1. The 1st one displays the type of wine/beer/spirit, the vintage if it is a wine, the ABV, and a short description of the beverage
2. The 2nd one inform about its origin (country and region). 
3. The 3rd one gives food recommendations that matches the beverage, what does it taste like and, if it is a wine, the grape variety.

# FEATURES
## Favorites
<img align="right" width="180" margin-right= 10 src="https://user-images.githubusercontent.com/89077571/187071021-471deb32-6964-4aef-a7ef-945ade3544f7.png">
<img align="right" width="180" src="https://user-images.githubusercontent.com/89077571/187070861-88ce3ec9-7c5c-4763-9ef2-1e7eac03bdee.gif">

You can add any beverage to your "Favorites" and find it among all your favorites.

Your favorites are organized and sorted according to their categories (Wines, Beers, and Spirits).


## Add an alcohol intake

You can add an alcohol intake by indicating the time and volume of the intake. You can choose to express the volume in mL, fl oz, or standard drinks.

Generally, a standard drink corresponds to the amount of alcohol served at the bar. Anyhow, in the United States, a standard drink has 14g of pure alcohol.
It can also be found in:
* 5 fl oz (150mL) of 12% Wine
* 1.5 fl oz (45mL) of 40% Spirit
* 12 fl oz (350mL) of 5% Beer

## Track your alcohol consumption

Once you have added the alcohol intake to your consumption, the app calculate your Blood Alcohol Content (BAC) using the Widmark formula given your sex and weight. The result is not 100% accurate but gives an idea of your actual BAC.
Your BAC can be found on the Dashborad among other figures such as:
* The time before getting back to 0% BAC
* The amount of standard drink consumned
* The time you started drinking

You will also find on the Dashboard your driving ability based on your consumption.

![trackBAC](https://user-images.githubusercontent.com/89077571/187098793-9da420e7-7d04-45fe-aecf-0569ec988153.png)

## Health App

The Beverage App can also be linked to the Health App to send data.
If you have allowed the app to access the Health app it can therefore send your BAC and the number of alcoholic beverages you have consumned directly to the app.
