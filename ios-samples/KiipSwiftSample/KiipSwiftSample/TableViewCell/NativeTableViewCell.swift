//
//  NativeTableViewCell.swift
//  KiipSwiftSample
//
//  Created by encore on 03/06/19.
//  Copyright © 2019 Kiip. All rights reserved.
//

import UIKit
import KiipSDK

class NativeTableViewCell: UITableViewCell {
    @IBOutlet weak var nativeRewardView: KPNativeRewardView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
