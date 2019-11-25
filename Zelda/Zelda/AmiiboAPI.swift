//
//  AmiiboAPI.swift
//  Zelda
//
//  Created by Aksel Kantar on 1/04/2019.
//  Copyright © 2019 Aksel Kantar. All rights reserved.
//

import Foundation

final class AmiiboAPI {
    
    static let shared = AmiiboAPI()
    
    func fetchAmiiboList(onCompletion: @escaping ([Amiibo]) -> ()){
        
        let apiURL = URL(string: "https://www.amiiboapi.com/api/amiibo")!
        let task = URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
            
            guard let data = data else{
                print("data was nil")
                return
            }
            guard let amiiboList = try? JSONDecoder().decode(AmiiboList.self, from: data) else {
                print("error decoding JSON")
                return
            }
           // print(amiiboList.amiibo)
            onCompletion(amiiboList.amiibo)
        }
        task.resume()
    }
   
    
}

struct AmiiboList: Codable {
    let amiibo: [Amiibo]
}

struct Amiibo: Codable {
    
    let amiiboSeries: String
    let character: String
    let gameSeries: String
    let head: String
    let image: String
    let name: String
    let release: AmiiboRelease
    let tail: String
    let type: String
}

struct AmiiboRelease: Codable {
    
    let au: String?
    let eu: String?
    let jp: String?
    let na: String?
}





//{
//    "amiiboSeries": "Super Mario Bros.",
//    "character": "Mario",
//    "gameSeries": "Super Mario",
//    "head": "00000000",
//    "image": "https://raw.githubusercontent.com/N3evin/AmiiboAPI/master/images/icon_00000000-00340102.png",
//    "name": "Mario",
//    "release": {
//        "au": "2015-03-21",
//        "eu": "2015-03-20",
//        "jp": "2015-03-12",
//        "na": "2015-03-20"
//    },
//    "tail": "00340102",
//    "type": "Figure"
//},
