//
//  KPCustomButton.h
//  SimpleSample
//
//  Created by Ash Bhat on 7/11/13.
//  Copyright (c) 2013 Ash Bhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPCustomButton : UIButton

@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *message;
@property (strong, nonatomic) UIImageView *icon;

-(void)setPoptart:(KPPoptart *)poptart;

@end
