//
//  SamplesListController.swift
//  HookahJam
//
//  Created by Ihor Kovalenko on 3/23/20.
//  Copyright © 2020 Ihor Kovalenko. All rights reserved.
//

import UIKit
import SwiftyJSON

class SamplesListController: UIViewController {

    @IBOutlet weak var gramsSelector: UISegmentedControl!
    @IBOutlet weak var samplesTable: UITableView!
    var mark = ""
    var gramsArray = [String]()
    var grams = ""
    var json : JSON?
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setSegmentedControl()
        samplesTable.delegate = self
        samplesTable.dataSource = self
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        grams = gramsSelector.titleForSegment(at: gramsSelector.selectedSegmentIndex)!
        samplesTable.reloadData()
    }
    func setSegmentedControl() {
        gramsSelector.removeSegment(at: 0, animated: true)
        gramsSelector.removeSegment(at: 0, animated: true)
        for gram in gramsArray {
            gramsSelector.insertSegment(withTitle: gram, at: 0, animated: true)
        }
        gramsSelector.selectedSegmentIndex = 0
        
    }
    
    func setMark(mark: String, grams: [String]){
        self.mark = mark.lowercased()
        self.gramsArray = grams
        self.grams = gramsArray.last!
    }
    
    func getData() {
        let data = "\(mark)JSON.json".contentsOrBlank()
        let jsondata = data.data(using: .utf8, allowLossyConversion: false)
        json = try? JSON(data: jsondata!)
    }

}

extension SamplesListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json!["\(mark)\(grams)"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = samplesTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SampleCell
        cell.textLabel?.text = json!["\(mark)\(grams)"][indexPath.row]["name"].string
        return cell
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsInfoController {
            vc.getInfo(info: json!["\(mark)\(grams)"][indexPath.row], mark: mark)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
