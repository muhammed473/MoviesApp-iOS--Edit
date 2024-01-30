//
//  ModelHomeFor.swift
//  MyFinalMoviesApp
//
//  Created by muhammed dursun on 4.11.2023.
//

import Foundation

struct GeneralDictionaryModel : Codable {
    
    let myMovies : [ExampleModelHome]?
    let totalResults: String?
    let response : String
    let error: String?
    
    enum CodingKeys : String,CodingKey {
        case myMovies = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }
    
}

struct ExampleModelHome :Codable{
    
    let title,year,poster,imdbID,type:String
    
    
    enum CodingKeys : String,CodingKey {
        
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
        
    }
    
   
    
}


/* struct posterModel : Decodable {
    let poster : String
    
    enum CodingKeys : String,CodingKey {
        
        case poster = "Poster"
    }
} */





