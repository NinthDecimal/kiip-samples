//
//  KiipTableViewController.swift
//  KiipSwiftSample
//
//  Copyright © 2018 Kiip. All rights reserved.
//

import UIKit
import KiipSDK

class KiipTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tableview: UITableView?
    var placer: KPTableView?
    var data: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TableView"
        let tableRect = CGRect(x: 0, y: 50, width: view.bounds.size.width, height: view.bounds.size.height - 50)
        tableview = UITableView(frame: tableRect)
        tableview?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview?.kp_setDelegate(self)
        tableview?.kp_setDataSource(self)
        

        for i in 0..<1000 {
            data.append("\(i)")
        }
        placer = KPTableView.placer(with: tableview, viewController: self)
        
        view.addSubview(tableview!)
        placer?.loadAds(forAdUnitID: "d")

        // Do any additional setup after loading the view.
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in theTableView: UITableView) -> Int {
        return 1 //have to think about when a user define more then 1 section
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "kiip"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        cell?.textLabel?.text = self.data[indexPath.row]
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
        //

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
