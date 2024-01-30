//
//  ApiService.swift
//  MyFinalMoviesApp
//
//  Created by muhammed dursun on 4.11.2023.
//

import Foundation

class ApiService {
    
    
    func  fetchData(page:Int, completion: @escaping(GeneralDictionaryModel) ->Void) {
        
      //  let url =  URL(string: "http://www.omdbapi.com/?s=power&page=1&apikey=9893101c" )!
        let url =  URL(string: "http://www.omdbapi.com/?s=power&apikey=9893101c" )!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let myTask = URLSession.shared.dataTask(with: request,completionHandler: { 
            
            (data,response,error) in
            
            if let response = response as? HTTPURLResponse {
                print("Cevap(yanıt) durum kod sayısı : \(response.statusCode)")
            }
            
            if let data = data {
                let allData = String(data: data, encoding: .utf8)
                print("Datalarımın hepsi : \(allData)")
            }
            else{
                print("Data yok.")
            }
            
            if let error = error {
                print("Hata var : \(error.localizedDescription)")
            }
            
            do {
               
                let decoder = JSONDecoder()
                let movieList = try decoder.decode(GeneralDictionaryModel.self, from: data!)
                completion(movieList)
                
            }catch {
                print("Şuan Catch 'de şu hata  var : \(error)")
            }
            
        })
        
        myTask.resume()
    
    }
    
    func fetchDetailData(imdbID:String,completion : @escaping (ModelDetailFor) ->Void) {
        
        let url = URL(string: "http://www.omdbapi.com/?i=\(imdbID)&plot=full&apikey=9893101c")!
    
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
     
        let myTask = URLSession.shared.dataTask(with: request,completionHandler: {
            
            (data,response,error) in
            
            if let response = response as? HTTPURLResponse {
                print("Cevap(yanıt) durum kod sayısı : \(response.statusCode)")
            }
            
            if let data = data {
                let allData = String(data: data, encoding: .utf8)
                print("Seçilen Datanın bilgileri : \(allData)")
               // return
            }
            else{
                print("Data yok.")
            }
            
            if let error = error {
                print("Hata var : \(error.localizedDescription)")
            }
            
            do {
               
                let decoder = JSONDecoder()
                let dataResponse = try decoder.decode( ModelDetailFor.self, from: data!)
              //  print("Data benim response : \(dataResponse)")
                completion(dataResponse)
                
            }catch {
                print("Şuan Catch 'de şu hata  var : \(error)")
            }
            
        }) 
      
        myTask.resume()
        
    }

  
}
