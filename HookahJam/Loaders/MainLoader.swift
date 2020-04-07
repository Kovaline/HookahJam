//
//  TobaccoLoader.swift
//  HookahJam
//
//  Created by Ihor Kovalenko on 3/26/20.
//  Copyright © 2020 Ihor Kovalenko. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MainLoader : NSObject {
    
    var url : String?
    var html : String?
    var pricesDict = [String:String]()
    var price: String?
    
    func loadData(mark: String, data: JSON, completion:@escaping ()->()){
        let hardsmoke = HardSmokeLoader()
        let darkHydra = DarkHydraLoader()
        let tornado = TornadoLoader()
        let kalyan = KalyanInUa()
        hardsmoke.createUrl(mark: mark, name: data["hsname"].string ?? "none")
        darkHydra.createUrl(mark: mark, name: data["hydraname"].string ?? "none")
        tornado.createUrl(mark: mark, name: data["tornadoname"].string ?? "none")
        kalyan.createUrl(mark: mark, name: data["kalyanname"].string ?? "none")
        let downloadGroup = DispatchGroup()
        downloadGroup.enter()
        downloadGroup.enter()
        downloadGroup.enter()
        downloadGroup.enter()
        hardsmoke.load {
            self.pricesDict["Hardsmoke"] = hardsmoke.price
            TobaccoShops.tobaccoDict["Hardsmoke"]![0] = hardsmoke.url!
            downloadGroup.leave()
        }
        darkHydra.load {
            self.pricesDict["DarkHydra"] = darkHydra.price
            TobaccoShops.tobaccoDict["DarkHydra"]![0] = darkHydra.url!
            downloadGroup.leave()
        }
        tornado.load {
            self.pricesDict["Tornado-hs"] = tornado.price
            TobaccoShops.tobaccoDict["Tornado-hs"]![0] = tornado.url!
            downloadGroup.leave()
        }
        kalyan.load {
            self.pricesDict["Kalyan.in.ua"] = kalyan.price
            TobaccoShops.tobaccoDict["Kalyan.in.ua"]![0] = kalyan.url!
            downloadGroup.leave()
        }
        DispatchQueue.global(qos: .background).async {
            downloadGroup.wait()
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func load (completion:@escaping ()->()) {
        if url == "none"{completion() }
        var request = URLRequest(url: NSURL.init(string: url!)! as URL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 8
        AF.request(request).responseData{ response in
            switch response.result {
            case .success(let value):
                guard let string = String(data: value, encoding: .utf8) else { return }
                self.html = string
                self.htmlParser()
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
    
    func htmlParser() {
        assert(false, "This method must be overriden by the subclass")
    }
    
    func createUrl(mark: String, name: String){
        assert(false, "This method must be overriden by the subclass")
    }
}

extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}
