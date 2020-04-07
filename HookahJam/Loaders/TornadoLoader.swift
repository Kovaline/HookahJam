//
//  AladinLoader.swift
//  HookahJam
//
//  Created by Ihor Kovalenko on 3/30/20.
//  Copyright © 2020 Ihor Kovalenko. All rights reserved.
//

import Foundation
import Kanna
class TornadoLoader : MainLoader {
    override func createUrl(mark: String, name: String) {
        if name == "none"{ self.url = "none"; return}
               let url = "https://www.tornado-hs.com.ua/tabak-\(mark)-\(name)"
               self.url = url
    }
    
    override func htmlParser() {
        if html == nil {return}
        if let doc = try? HTML(html: self.html!, encoding: .utf8) {
            if((doc.at_xpath("//*[@id='content']/div[2]/div[2]/div[1]/text()[4]")?.text) ==  " Нет на складе"){
                    self.price = "Нет в наличии"
            } else {
                guard let price = doc.at_xpath("//*[@id='content']/div[2]/div[2]/div[2]/span[1]") else {
                    return
                }
                self.price = price.text?.digits
            }
        }
    }
}
