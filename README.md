# Clothical

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

[Link to deployed application](#TBD)


![image](https://user-images.githubusercontent.com/97912154/191071199-5ade446d-0274-46ab-912b-f0ba7cfdb557.png)


Table of contents
=================

   * [User Story](#user-story)
   * [Visuals](#visuals)
   * [Demo](#demo)
   * [Installation Guidelines](#installation-guidelines)
   * [Technologies](#technologies)
   * [Libraries](libraries)
   * [Contributors](#contributors)
   * [Acknowledgements](#acknowledgements)
   * [License](#license)
  
    

User Story
=================
1. A User can register to access more functionality of the website:
    - Once logged in, a user is taken to the homepage. Homepage header will show unhidden profile & shopping cart icons.
    - Clicking on the profile icon, the user is transported to user profile page, where the user can review order history, and favorites.
    - Clicking on the shopping cart icon, the user is transported to the shopping cart page, where the user can review the current items in the shopping cart, or alternatively check-out and purchase the items.
2. A User will be able to search for Products based on category (Men, Women, Kids), color, price
(All Products must have a name, description, image and purchase price)
    - A User will see products matching their search
3. When a User selects a product 
    - Navigate to product description page - they can add it to the shopping cart, update qty
    - Add it to their favorites 
4. A User must be able to make a purchase using Stripe
    - As a customer I’m able to add a product or products to my cart
    - As a customer I’m able to  update the quantity of a product in my cart
    - As a customer I’m able to see a summary of the amount I need to pay during checkout
    - As a customer I am able to pay/checkout with the products in my cart.
5. A User will receive order confirmation after making a purchase 


Visuals
=================

Miro Board:

![image](https://user-images.githubusercontent.com/97912154/191072105-b7f29d49-d6a9-458e-b7e9-900392f6984e.png)

![image](https://user-images.githubusercontent.com/97912154/191072379-17a2f5bb-6683-405b-9f01-be94187fcff0.png)

Demo
=================
To be added at a later date


Installation Guidelines
=================

To enjoy this application, you will need to install Node JS on your local computer. [Click here for links to download Node JS.](https://nodejs.org/en/download/)

Then, clone this repository to your local computer, and open up the folder in your coding software (i.e. Visual Studio Code). Once open, open up your Terminal (on Mac OS) or GitBash (on Windows OS). You will have to direct yourself to the cloned repository, and then run this command in the terminal: 

`npm install`

This will download the node modules MySQL2, Express, Nodemon, Sequelize, and DOTENV that this application needs to run on your local computer. After install, you will run the following command to open a MySQL shell in your terminal: 

`mysql -u root` 

Then you will install the schema.sql file so MySQL can format your database. The semi-colon is necessary.

`SOURCE db/schema.sql;`

You can exit the shell by entering:

`exit`

If you would like to use dummy information on deployment, run:

`npm run seed`

To initiate the server, run:

`nodemon`

If the last message in the terminal says "App listening on port (#)!", then you have installed the program correctly. If you ever need to shut down this server application use this command:

`^C`

Technologies
=================

* Node JS
* MySQL2
* Sequelize
* Express
* Dotenv


Libraries
================= 
TBD


Contributors
=================
1. James Compagnoni (Coding)
2. June Lin (Digital Marketing)
3. Izabella Torres (UXUI)
4. Priyanka Dhende (Coding)
5. Rocio Galvan (Coding)
6. Tracy Suares (UXUI) 
7. Yui Suematsu (Digital Marketing)

Acknowledgements
=================
Thank you to our mentor, Christian Castanares, for the support and guidance throughout the development of the app

 License
=================

[MIT](./LICENSE)
