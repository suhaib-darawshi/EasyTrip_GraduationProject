# demo

A new Flutter project.

## Getting Started

Easy Trip is a mobile application that creates an enviroment between Travelling companies and users , companies can publish trips and users can book them using G-Pay , also a website for admin to control everything in the app .

Easy trip has an intro page that shows only once when the application is downloaded, also has pages for sign in an sign up for both company and user.


contains more than 30 pages for companies and users .
Signing up is by recieving a confirmation key on the entered email , after entering the key the account is created ,

For copanies , they have pages to add trips , edit trips ,edit profile , upload logo , control trips .
for users also , they have home page for showing the trips , a search page provided with filters accoring to categories if they wanted to , a page for personal information , update information , adding a personal picture, showing the history , and controlling the language and the dark mode , also a simple chat system for contacting the Help Center .


For admin he has 4 main pages other than sign in , three of them contains a table of the data in the system , trips ,companies and users , the admin can update , delete any of them , also a chat page that is a copy from the Whatsapp Web , for replying to messages from users . 

Features in the application :

Localization : English and Arabic using Easy_localization package .
Responsive using the screen_uril package .
State Management : Provider .
supported themes : Dark mode / Light mode .
Local storage : for History only , the rest is from the backend 



The application is connected to a server implemented using TS.ED Frame work , which is a framework built on the top of express.js server using typescript as syntax .
