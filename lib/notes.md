- The General idea is that the data service data fields will controll the whole UI, the UI can respond to changes in it because it is in a ChangeNotifierPovider. Then the data should only be changed through the data service, so we need to expose all the funcionality we need in the data service itself
# Menus Side
- Menus list populates from DataService.menus
- add button takes you to editMenuScreen
    - get rid of save button, just persist changes as they happen
        - tapping dish adds it to menu object and persists that change, same with toggling it off
    - create dish takes you to editDishScreen
        - **if editing existing, do we change the menu object or not? we won't necessarily know if it's part of a menu or not.** 
            - Solutions:
                - only store id's in the menu object
                - pass in optional menu object if it's selected on the previous page
                - format the editMenuPage like the edit dish page where you only see the dishes that you have added, and clicking add dish, takes you to an SearchDishPage
                    - we could even make a generic search page
                        - but then we might want to make a search walmart thing, which wouldn't be the same between dishes and ingredients
        - get rid of save button
        - adding ingredient adds it to dish object and persists that change
        - changing dish name changes dish object and persists
            - onChange or on field submitted?
        - description is the same as dish name ^
        - add ingredient takes you to search ingredients page

- When we add a new menu or edit an existing one, when should we persist that data? 
    * Just when we hit save?
    - every change made? To each dish or ingredient or amount? 
        - That would be a lot of changes, and it would reserialize the whole menus json file (at least) every time. What if it gets huge?
            - I have no idea how much that would slow things down
                - so maybe I shouldn't prematurely optimize.
                - If I don't even know how bad that would make it, maybe I should try, because it might be a cool thing to be able to close the app anywhere in the middle.
    - Is there a way to tell when the app is closing? And you could just make the persisted data match the data in memory. Just reserialize then?
        - I should look into this option first because that's just a good idea.
        - Is there any other problems with that?
            - Crashes? 
                - I don't think that's a huge worry
        - https://stackoverflow.com/questions/60184497/how-to-execute-code-before-app-exit-flutter
        - https://stackoverflow.com/questions/51284437/is-it-possible-to-run-code-when-app-terminated
        - Without knowing too much about it myself, people seem to think there's not a really reliable way to do this. Back to every change made ^^^