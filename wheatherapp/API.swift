//
//  API.swift
//  wheatherapp
//
//  Created by Marcus Nilsson on 2020-02-08.
//  Copyright © 2020 Marcus Nilsson. All rights reserved.
//

import Foundation

struct weatherAPI {
    let baseUrl: String = "https://api.openweathermap.org/data/2.5/weather?q="
    var city = ""
    var countryCode = ",swe"
    var celciusMode = "&mode=json&units=metric"
    var myApiKey = "&appid=474162a4983426301b2af56e1ee15fca"
    
    
    
    func getWeather(city: String,completion: @escaping (Result<APIStruct,Error>) -> Void){
        let urlString = "\(baseUrl)\(city)\(countryCode)\(celciusMode)\(myApiKey)"
        print(urlString)
        guard let url: URL = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let unwrappedError = error{
                print("något gick fel: error: \(unwrappedError)")
                completion(.failure(unwrappedError))
                return
            }
            if let unwrapped = data{

                do{
                    let decoder = JSONDecoder()
                    let wheather: APIStruct = try decoder.decode(APIStruct.self, from: unwrapped)
                    completion(.success(wheather))
                }catch let err{
                    print(err)
                    print("Json Error")
            }
        }
    }
        task.resume()
    }
}
