//
//  NativeTableViewController.h
//  Sample
//
//  Created by encore on 30/10/18.
//  Copyright © 2018 Kiip, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NativeTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSArray *nativeViewList;

@end
