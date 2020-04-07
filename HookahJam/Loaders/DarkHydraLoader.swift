//
//  DarkHydraLoader.swift
//  HookahJam
//
//  Created by Ihor Kovalenko on 3/27/20.
//  Copyright © 2020 Ihor Kovalenko. All rights reserved.
//

import Foundation
import Kanna

class DarkHydraLoader: MainLoader {
    override func createUrl(mark: String, name: String) {
        if name == "none"{ self.url = "none"; return}
        let url = "https://darkhydra.com.ua/product/\(mark)_\(name)"
        self.url = url
    }
    
    override func htmlParser() {
        if html == nil {return}
        if let doc = try? HTML(html: self.html!, encoding: .utf8) {
          
            if((doc.at_xpath("//*[@id='main']/div/div[2]/div/div/div[1]/div[1]/div[2]/p [@class='stock out-of-stock']")?.text) != nil) {
                    self.price = "Нет в наличии"
            } else {
                guard let price = doc.at_xpath("//*[@id='main']/div/div[2]/div/div/div[1]/div[1]/div[2]/div[1]/p/span") else {return}
                self.price = price.text?.digits
            }
        }
    }
}
