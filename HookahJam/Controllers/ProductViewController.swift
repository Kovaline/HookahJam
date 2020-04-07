//
//  ViewController.swift
//  HookahJam
//
//  Created by Ihor Kovalenko on 3/23/20.
//  Copyright © 2020 Ihor Kovalenko. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    
    let products = [["Product":"Табак", "Image":"image"], ["Product":"Уголь", "Image":"image"]]

    @IBOutlet weak var productTable: UITableView!
    
    override func viewDidLoad() {
        productTable.delegate = self
        productTable.dataSource = self
        super.viewDidLoad()
    }


}

extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductCell
        cell.textLabel?.text = products[indexPath.row]["Product"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MarkViewController") as? MarkViewController {
            vc.setProduct(product: products[indexPath.row]["Product"]!)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
