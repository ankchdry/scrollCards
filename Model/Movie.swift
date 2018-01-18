//
//  Movie.swift
//  scrollCards
//
//  Created by Ankit  Chaudhary on 31/12/17.
//  Copyright © 2017 Ankit  Chaudhary. All rights reserved.
//

import Foundation
import UIKit
struct Movie {
    var name: String?
    var image: UIImage?
    var genre:String?
    var releaseDate:String?
    var rating:String?
    var runtime:String?
    var description:String?
    
    init(name:String, image: UIImage, genre:String, releaseDate:String, rating:String, runtime:String, description:String) {
        self.name = name
        self.image = image
        self.genre = genre
        self.rating = rating
        self.runtime = runtime
        self.releaseDate = releaseDate
        self.description = description
    }
    
    static func fetchMovieData() -> [Movie] {
        let movieOne =  Movie(name: "It", image: UIImage(named: "itMovie")!, genre: "Fantasy, Drama", releaseDate: "Sep 15 2017", rating: "7.2", runtime: "2hr 14 min", description: "In a small town in Maine, seven children known as The Losers Club come face to face with life problems, bullies and a monster that takes the shape of a clown called Pennywise")
        let movieTwo =  Movie(name: "Star Wars: The Last Jedi", image: UIImage(named: "starwarslastjedi")!, genre: "Fantasy, Drama", releaseDate: "Sep 15 2017", rating: "7.2", runtime: "2hr 14 min", description: "Rey develops her newly discovered abilities with the guidance of Luke Skywalker, who is unsettled by the strength of her powers. Meanwhile, the Resistance prepares to do battle with the First Order")
        let movieThree =  Movie(name: "Coco", image: UIImage(named: "coco")!, genre: "Fantasy, Drama", releaseDate: "Sep 15 2017", rating: "7.2", runtime: "2hr 14 min", description: "Despite his family’s baffling generations-old ban on music, Miguel dreams of becoming an accomplished musician like his idol, Ernesto de la Cruz. Desperate to prove his talent, Miguel finds himself in the stunning…")
        let movieFour =  Movie(name: "There be dragons.", image: UIImage(named: "therebedragon")!, genre: "Fantasy, Drama", releaseDate: "Sep 15 2017", rating: "7.2", runtime: "2hr 14 min", description: "Arising out of the horror of the Spanish Civil War, a candidate for canonization is investigated by a journalist who discovers his own estranged father had a deep, dark and devastating connection to the saint's life.While researching the life of Josemaria Escriva")
        let movieFive =  Movie(name: "Jumanji", image: UIImage(named: "jumanji")!, genre: "Fantasy, Drama", releaseDate: "Sep 15 2017", rating: "7.2", runtime: "2hr 14 min", description: "The tables are turned as four teenagers are sucked into Jumanji's world - pitted against rhinos, black mambas and an endless variety of jungle traps and puzzles. To survive, they'll play as characters from the game.")
        
        return [movieOne, movieTwo, movieThree, movieFour, movieFive]
    }
}
