//
//  NativeTableViewController.swift
//  KiipSwiftSample
//
//  Created by encore on 03/06/19.
//  Copyright © 2019 Kiip. All rights reserved.
//

import UIKit
import KiipSDK

class NativeTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,KPPoptartDelegate,KPModalDelegate {
    @IBOutlet var tableview: UITableView!
    var nativeViewList: [Any] = []
    
    var data: [AnyHashable] = []
    var adList: [AnyHashable] = []
    var nativeRewardView: KPNativeRewardView?
    var adPosition: [AnyHashable] = []
    var queue: OperationQueue?
    var completionOperation: Operation?
    var nativeRecord: KPNativeRecord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adPosition = [AnyHashable]()
        adList = [AnyHashable]()
        data = [AnyHashable](repeating: 0, count: 1000)
        for i in 0..<1000 {
            data.append("\(i)")
        }
        
        adIndexPath()
        
        let tableRect = CGRect(x: 0, y: 50, width: view.bounds.size.width, height: view.bounds.size.height - 50)
        //    self.tableview = [[UITableView alloc] initWithFrame:tableRect];
        //   // [self.tableview registerClass:[KPTableViewCell class] forCellReuseIdentifier:@"NativeTableViewCell"];
        //    self.tableview.delegate = self;
        //    self.tableview.dataSource = self;
        //    [self.view addSubview:self.tableview];
        
        queue = OperationQueue()
        queue?.name = "AFHTTPSessionManager queue"
        
        // Do any additional setup after loading the view from its nib.
    }
    
    func adIndexPath() {
        
        var indexPathArray = [IndexPath(row: 3, section: 0), IndexPath(row: 6, section: 0), IndexPath(row: 9, section: 0), IndexPath(row: 12, section: 0), IndexPath(row: 15, section: 0)]
        for i in 0..<indexPathArray.count {
            nativeRecord = KPNativeRecord()
            nativeRecord?.indexPath = indexPathArray[i] as NSIndexPath
            adList.append(nativeRecord!)
            adPosition.append(indexPathArray[i])
        }
    }
    
    @IBAction func dismissTableView(_ sender: Any) {
        dismiss(animated: true) {
            
        }
    }
    
    func numberOfSections(in theTableView: UITableView) -> Int {
        return 1 //have to think about when a user define more then 1 section
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count + adList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let tableViewCellIdentifier = "NativeTableViewCell"

        if adPosition.contains(indexPath) {
            
            var nativeCell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier) as? NativeTableViewCell
            //var nativeCell: NativeTableViewCell!
            if nativeCell == nil {
                let nib:Array = Bundle.main.loadNibNamed("NativeTableViewCell", owner: self, options: nil)!
                nativeCell = nib[0] as? NativeTableViewCell
            }
            
            loadImagesForOnscreenRows()
            return nativeCell!
        } else {
            var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier)
            
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: tableViewCellIdentifier)
            }
            cell?.textLabel?.text = data[indexPath.row] as? String
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if adPosition.contains(indexPath) {
            return 250
        }
        return UITableViewAutomaticDimension
    }

    func addNativeView(_ indexPath: IndexPath?) {
        
        let handler: ((KPPoptart?, Error?) -> Void)? = { poptart, error in
            var appRecord: KPNativeRecord? = nil
            if let indexPath = indexPath {
                appRecord = (self.adList)[self.adPosition.index(of: indexPath)!] as? KPNativeRecord
            }
            
            if error != nil {
                let alert = UIAlertView(title: "Error", message: (error?.localizedDescription)!, delegate: nil, cancelButtonTitle: "Ok", otherButtonTitles: "")
                alert.show()
            }
            
            // Since we've implemented this block, Kiip will no longer show the poptart automatically
            poptart?.delegate = self as! KPPoptartDelegate
            
            if poptart?.modal != nil {
                poptart?.modal.delegate = self as! KPModalDelegate
            }
            poptart?.show(appRecord?.nativeRewardView)
            appRecord?.isCompleted = true
        }
        
        Kiip.sharedInstance().saveMoment("d", withCompletionHandler: handler)
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            loadImagesForOnscreenRows()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImagesForOnscreenRows()
    }
    
    func loadImagesForOnscreenRows() {
        
        let visibleCell = tableview.visibleCells
        
        for cell in visibleCell {
            
            if (cell is NativeTableViewCell) {
                
                let nativeCell = cell as? NativeTableViewCell
                let indexPath: IndexPath? = tableview.indexPathForRow(at: nativeCell?.center ?? CGPoint.zero)
                
                if let indexPath = indexPath {
                    if adPosition.contains(indexPath) {
                        let appRecord = (adList)[adPosition.index(of: indexPath)!] as? KPNativeRecord
                        if appRecord?.isCompleted != nil {
                            
                            let subviews = nativeCell?.subviews
                            for subview in subviews ?? [] {
                                if (subview is KPNativeRewardView) {
                                    subview.removeFromSuperview()
                                }
                            }
                            
                            if let nativeRewardView = appRecord?.nativeRewardView {
                                nativeCell?.addSubview(nativeRewardView)
                            }
                        } else {
                            
                            let subviews = nativeCell?.subviews
                            for subview in subviews ?? [] {
                                if (subview is KPNativeRewardView) {
                                    subview.removeFromSuperview()
                                }
                            }
                            
                            if appRecord?.isStarted != nil {
                            } else {
                                appRecord?.isStarted = true
                                appRecord?.indexPath = indexPath as NSIndexPath
                                appRecord?.nativeRewardView = newnativeRewardView()
                                addNativeView(indexPath)
                            }
                        }
                    }
                }
            }
        }
    }
    func newnativeRewardView() -> KPNativeRewardView? {
        
        let nativeRewardView = KPNativeRewardView(cGpoint: CGPoint(x: 0, y: 0), setViewType: viewType.FLUID_RECTANGLE)
        return nativeRewardView
    }
    
    func willPresent(_ poptart: KPPoptart?) {
    }
    
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
