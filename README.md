# Desserts App / Take Home

https://github.com/kleber-maia/desserts-take-home/assets/10270929/5928c0fc-0c1c-4877-b472-913013f55e96

### The architectural design
I chose MVVM for the application's view tier, also caring about single-responsibility and dependency injection principles for everything else. The reasons behind those choices were:

- I wanted to showcase the kind of work I'm used to do;
- I believe these are current industry standards / best practices widely adopted.

For consuming `The Meal DB` REST API, I've created `MealService` and `MealDetailService` types. Each one creates their corresponding GET HTTP request, deals with possible failure scenarios and return their correspondent decoded models upon success. 

`MealListView` / `MealListViewModel` are responsible for fetching and displaying the list of available desserts. When the user taps on a dessert, `MealDetailView` / `MealDetailViewModel` will fetch and display ingredients and preparation instructions.

### 3rd party libraries
I haven't used any third party library for this project.

### Main features
These are the main functionalities:

1. allows the user to search for desserts by keywords;
2. presents a list of matching desserts depicted by image, name;
3. presents detailed information on a given dessert: image, name, ingredients, instructions.

Some UI / UX system features supported:

- light / dark theme;
- dynamic fonts (accessibility);
- localization ready.

### Unit Testing
In addition to the features above, these were the high value areas I chose to put under test:

1. `MealServiceTests`, `MealDetailServiceTests`: covering fetching data from the remote API (happy path and possible failure);
2. `MealModelTests`, `MealDetailModelTests`: covering decoding from JSON (happy path and possible failure).

### The trade-offs
These were the limitations imposed due to time constraints:

1. Device: iPhone only;
2. Orientation: portrait only;
3. Localization: none;
4. Lack of pagination for long results;
5. Lack of features covering local storage;
6. Skipped Git's best practices.

### How to run the project.
1. Open `Desserts Take Home.xcodeproj`
2. Pick an iPhone simulator
3. Run

### Additional information.
I wanted to show as much as possible my mindset and passion for creating software, which includes aspects of craftsmanship for writing code, as well as looking into the product from owner's and end user's standing points.
