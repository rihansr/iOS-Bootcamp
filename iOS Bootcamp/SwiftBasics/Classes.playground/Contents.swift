import Foundation

// Classes are slow!
// Classes are stored in the Heap (memory)
// Objects in the Heap are Reference types
// Reference types point to an object in memory and update the object in memory

struct Movie{
    let title: String
    let genre: String
    private(set) var isFavourite: Bool
    
    func updateFavouriteStatus1(favourite: Bool) -> Movie {
        Movie(title: title, genre: genre, isFavourite: favourite)
    }
    
    mutating func updateFavouriteStatus2(favourite: Bool){
        isFavourite = favourite
    }
}

class MovieManager {
    let title: String
    let showButton: Bool
    
    // Same init as a Struct, except structs have implicit inits
    init(title: String, showButton: Bool){
        self.title = title
        self.showButton = showButton
    }
    
    deinit{
        // runs as the object is being remove from memory
        // Structs do NOT have deinit!
    }
    
    public var movie1 = Movie(title: "Avatar", genre: "Action", isFavourite: false)
    private var movie2 = Movie(title: "Bee", genre: "Comedy", isFavourite: false)
    private(set) var movie3 = Movie(title: "Spiderman", genre: "Action", isFavourite: false)
}

let manager = MovieManager(title: "Avatar", showButton: false)

// We can GET and SET the value from outside the object
let movie1 = manager.movie1
movie1.updateFavouriteStatus1(favourite: false)
manager.movie1.updateFavouriteStatus2(favourite: false)

// We can't GET and SET the value from outside the object
// let movie2 = manager.movie2

// We can GET but can't set the value from outside the object.
let movie3 = manager.movie3
movie3.updateFavouriteStatus1(favourite: false)
