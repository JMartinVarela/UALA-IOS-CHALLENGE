# UALA-IOS-CHALLENGE
SwiftUI App created as part of Mobile Challenge - UALA. Related document is included in Repo.

## Search problem approach
It was decided to preprocess the city list into a Trie structure that is considered efficient for prefix searches with large datasets (like the provided one to use in this challenge). A Trie is a special data structure used to store strings that can be visualized like a graph. It consists of nodes and edges. Each node store a character and edges connect each parent node to its children:

![trie image example](https://media.geeksforgeeks.org/wp-content/uploads/20240417114225/trie-data.webp) 

For the solution applied in the app, on each leaf node in trie structure was stored the related City, to be returned as part of search result.

### Search process 
The search process involves breaking the search string into individual characters and sequentially comparing them with the characters stored in the Trie structure, starting from the root node. If a match is found for the first character, the process continues by accessing the child nodes of the matched node to search for the second character. This pattern repeats for each subsequent character in the search string. If a node matching the last character is reached, a function is called to collect all related leaf nodes. Finally, all City objects stored in these leaf nodes are returned.

## Considerations
- After displaying the initial splash screen, the app fetches the list of cities from Gist. In order to minimize UI blocking while showing the Skeleton View, instead of waiting for the preprocessing step (loading all cities into the Trie) to complete and makes dissapear Skeleton View, the city list is displayed immediately, but the search bar remains hidden. Once preprocessing is finished, the search bar becomes visible, allowing users to search for cities if desired.
- Given the requirement to create the views in SwiftUI, it was decided to build the entire app using SwiftUI, as it allows for faster development. This approach also enables me to focus on showcasing my SwiftUI knowledge. Developing a hybrid app with both UIKit and SwiftUI would require significantly more code and time.
