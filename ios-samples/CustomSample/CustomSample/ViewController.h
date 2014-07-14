//
//  ViewController.h
//  SimpleSample
//
//  Created by Ash Bhat on 7/9/13.
//  Copyright (c) 2013 Ash Bhat. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KPCustomButton.h"

@interface ViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, retain) NSString *notifType;
@property (nonatomic, retain) KPPoptart *savedPoptart;

@property (nonatomic, retain) IBOutlet UITextField *momentField;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;
@property (nonatomic, retain) IBOutlet KPCustomButton * redeemButton;

@end

