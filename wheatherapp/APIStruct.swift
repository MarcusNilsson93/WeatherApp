//
//  APIStruct.swift
//  wheatherapp
//
//  Created by Marcus Nilsson on 2020-02-08.
//  Copyright © 2020 Marcus Nilsson. All rights reserved.
//

import Foundation
struct APIStruct:Codable {
var weather:[WeatherDetails]
var main:MainDetails
var name:String
}


struct WeatherDetails:Codable {
var id:Int
var main:String
var description:String
var icon:String
}

struct MainDetails:Codable {
var temp:Float
var pressure:Float
var humidity:Float
var temp_min:Float
var temp_max:Float
}

