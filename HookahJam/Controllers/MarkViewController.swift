//
//  MarkViewController.swift
//  HookahJam
//
//  Created by Ihor Kovalenko on 3/23/20.
//  Copyright © 2020 Ihor Kovalenko. All rights reserved.
//

import UIKit
import SwiftyJSON

class MarkViewController: UIViewController {

    @IBOutlet weak var markTable: UITableView!
    var product = ""
    var json : JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        markTable.delegate = self
        markTable.dataSource = self
    }
    
    func setProduct(product: String){
        if (product == "Табак") {
            self.product = "tobacco"
        } else if (product == "Уголь") {
            self.product = "coal"
        }
    }
    
    func getData() {
        let data = "\(product)JSON.json".contentsOrBlank()
        let jsondata = data.data(using: .utf8, allowLossyConversion: false)
        json = try? JSON(data: jsondata!)
    }

}


public extension String {
func contentsOrBlank()->String {
    if let path = Bundle.main.path(forResource:self , ofType: nil) {
        do {
            let text = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
            return text
            } catch { print("Failed to read text from bundle file \(self)") }
    } else { print("Failed to load file from bundle \(self)") }
    return ""
}
}

extension MarkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json![product].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = markTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MarkCell
        cell.textLabel?.text = json![product][indexPath.row]["name"].string
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SamplesViewController") as? SamplesListController {
            vc.setMark(mark: json![product][indexPath.row]["name"].string!, grams: json![product][indexPath.row]["grams"].arrayValue.map { $0.stringValue})
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
