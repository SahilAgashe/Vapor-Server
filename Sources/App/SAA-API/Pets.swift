//
//  File.swift
//  
//
//  Created by SAHIL AMRUT AGASHE on 11/08/24.
//

import Vapor

struct Pets: Content {
    let pageTitle: String
    let components: [Component]
}

struct Component: Content {
    let type: String
    let data: [String: String]
}

private let jsonString = """
{
  "pageTitle": "Pets",
  "components": [
    {
      "type": "featuredImage",
      "data": {
        "imageUrl": "https://img.freepik.com/free-photo/beautiful-pet-portrait-dog_23-2149218450.jpg?size=626&ext=jpg"
      }
    },
    {
      "type": "featuredImage",
      "data": {
        "imageUrl": "https://hips.hearstapps.com/hmg-prod/images/chow-chow-portrait-royalty-free-image-1652926953.jpg?crop=0.44455xw:1xh;center,top&resize=980:*"
      }
    },
    {
      "type": "featuredImage",
      "data": {
        "imageUrl": "https://hips.hearstapps.com/hmg-prod/images/happy-dog-outdoors-royalty-free-image-1652927740.jpg?crop=0.447xw:1.00xh;0.187xw,0&resize=980:*"
      }
    }
  ]
}
"""

private let jsonData = jsonString.data(using: .utf8)!

let petsData = try! JSONDecoder().decode(Pets.self, from: jsonData)
