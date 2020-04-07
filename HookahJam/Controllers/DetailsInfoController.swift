//
//  DetailsInfoController.swift
//  HookahJam
//
//  Created by Ihor Kovalenko on 3/23/20.
//  Copyright © 2020 Ihor Kovalenko. All rights reserved.
//

import UIKit
import SwiftyJSON

class DetailsInfoController: UIViewController {
    
    var activityIndicator = UIActivityIndicatorView()
    var sortedPrices = [(key: String, value: String)]()
    @IBOutlet weak var detailsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsTable.delegate = self
        detailsTable.dataSource = self
    }

    func getInfo(info: JSON, mark: String) {
        startActivityIndicator()
        let test = MainLoader()
        test.loadData(mark: mark, data: info){
            self.activityIndicator.isHidden = true
            self.sortedPrices = test.pricesDict.sorted { $0.1 < $1.1}
            self.detailsTable.reloadData()
        }
        
    }
    
    func startActivityIndicator(){
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
}

extension DetailsInfoController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedPrices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailsTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailCell
        let priceValue = sortedPrices[indexPath.row].value == "Нет в наличии" ? "Нет в наличии" : "Price: " + sortedPrices[indexPath.row].value + " UAH"
        let siteName = sortedPrices[indexPath.row].key
        cell.price.text = priceValue
        cell.siteLogo.image = UIImage(named: TobaccoShops.tobaccoDict[siteName]![1])
        //cell.price.text = TobaccoShops.tobaccoDict[sortedPrices[indexPath.row].key]![0]
        cell.siteName.text = sortedPrices[indexPath.row].key
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let siteName = sortedPrices[indexPath.row].key
        let string = TobaccoShops.tobaccoDict[siteName]![0]
        print(string)
        let url = URL(string: string)
        UIApplication.shared.open(url!)
    }
    
    
}
