//
//  FilmsViewModel.swift
//  RestAPIAndJSON
//
//  Created by Владимир on 05.03.2022.
//

import UIKit

struct Films : Decodable{
    let results : [FilmsViewModel]
}


struct FilmsViewModel : Decodable {
    let image : String
    let title : String?
    let description : String
    let resultType : String?
}
