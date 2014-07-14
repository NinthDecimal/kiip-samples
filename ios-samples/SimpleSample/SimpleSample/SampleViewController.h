//
//  KPViewController.h
//  Sample
//
//  Created by Grantland Chew on 9/19/12.
//  Copyright (c) 2012 Kiip, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SampleViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *momentIdField;
@property (strong, nonatomic) IBOutlet UITextField *momentValueField;
@property (strong, nonatomic) IBOutlet UIButton *saveMoment;

@property (strong, nonatomic) IBOutlet UILabel *deviceLabel;

@end
