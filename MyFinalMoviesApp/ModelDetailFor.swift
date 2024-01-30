//
//  ModelDetailFor.swift
//  MyFinalMoviesApp
//
//  Created by muhammed dursun on 5.11.2023.
//

import Foundation



struct ModelDetailFor: Codable {
    
    let title,year,poster,imdbID,type,writer,director,plot : String
    
    enum CodingKeys: String,CodingKey {
        
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
        case writer = "Writer"
        case director = "Director"
        case plot = "Plot"
       
    }
    
    
}
