//
//  HardSmokeLoader.swift
//  HookahJam
//
//  Created by Ihor Kovalenko on 3/26/20.
//  Copyright © 2020 Ihor Kovalenko. All rights reserved.
//

import Foundation
import Kanna

class HardSmokeLoader: MainLoader {
 
    override func createUrl(mark: String, name: String){
        if name == "none"{ self.url = "none"; return}
        let url = "https://hardsmoke.com.ua/shop/tabak-\(mark)-\(name)"
        self.url = url
    }
    
    override func htmlParser() {
        if html == nil {return}
        if let doc = try? HTML(html: self.html!, encoding: .utf8) {
            if((doc.at_xpath("//*[@id='comjshop']/form/div[1]/div[2]/div[@class='button_buy no_in_stock']")?.text) != nil){
                self.price = "Нет в наличии"
            } else {
                guard let price = doc.at_xpath("//*[@id='comjshop']/form/div[1]/div[2]/div[2]/span[1]")else {return}
                self.price = price.text?.digits
            }
        }
    }
}
