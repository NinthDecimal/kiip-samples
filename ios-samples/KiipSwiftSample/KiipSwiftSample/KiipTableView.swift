//
//  KiipTableView.swift
//  KiipSwiftSample
//
//  Created by Daniel on 4/25/18.
//  Copyright © 2018 Kiip, Inc. All rights reserved.
//


import Foundation

class KiipTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let list = ["Milk", "Honey", "Bread", "Tacos", "Banana", "Rice" ]
    
    var placer: KPTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set both delegate and datasource to kp.
        self.tableView.kp_setDelegate(self)
        self.tableView.kp_setDataSource(self)
        
        //By default, the ad will display in row # 3
        placer = KPTableView.placer(with: tableView, viewController: self)
        
        //load the add with a moment and change the reward to native (not default)
        //in Kiip app dashboard
        placer.loadAds(forAdUnitID: "<Your Moment ID>")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(list.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        
        return(cell)
    }
}
