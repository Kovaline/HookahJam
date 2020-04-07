//
//  KalyanInUa.swift
//  HookahJam
//
//  Created by Ihor Kovalenko on 4/1/20.
//  Copyright © 2020 Ihor Kovalenko. All rights reserved.
//

import Foundation
import Kanna

class KalyanInUa : MainLoader {
    
    override func createUrl(mark: String, name: String) {
        if name == "none"{ self.url = "none"; return}
        let url = "https://kalyan.in.ua/tabak-\(mark)-\(name).html"
        self.url = url
    }
    
    override func htmlParser() {
        if html == nil {return}
        if let doc = try? HTML(html: self.html!, encoding: .utf8) {
            if((doc.at_xpath("//*[@id='product_addtocart_form']/div[1]/div[2]/div[3]/p/span")?.text) == "Нет в наличии") {
                        self.price = "Нет в наличии"
                } else {
                    guard let price = doc.at_xpath("//*[@id='product_addtocart_form']/div[1]/div[2]/div[3]/div[2]/span[1]") else {return}
                    let nocoma = price.text!.components(separatedBy: ",")
                    self.price = nocoma[0].digits
                }
        }
    }
    
}
