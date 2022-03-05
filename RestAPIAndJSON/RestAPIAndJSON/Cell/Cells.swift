//
//  Cells.swift
//  RestAPIAndJSON
//
//  Created by Владимир on 05.03.2022.
//

import UIKit

struct Cells {
    let header : String?
    let date : String
    let title : String?
    let image : UIImage?
}
let arrayOfCells = [Cells(header: Constants.Text.header, date: Constants.Text.date, title: "text", image: Constants.Image.contentBlock),
                    Cells(header: Constants.Text.header, date: Constants.Text.date, title: Constants.Text.title, image: Constants.Image.contentBlock)
                    ,Cells(header: Constants.Text.header, date: Constants.Text.date, title: "now", image: Constants.Image.contentBlock)
                    ,Cells(header: Constants.Text.header, date: Constants.Text.date, title: "hello", image: Constants.Image.contentBlock),]
