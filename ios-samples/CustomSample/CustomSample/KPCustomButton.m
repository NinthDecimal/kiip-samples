//
//  KPCustomButton.m
//  SimpleSample
//
//  Created by Ash Bhat on 7/11/13.
//  Copyright (c) 2013 Ash Bhat. All rights reserved.
//

#import <KiipSDK/KPPoptart.h>

#import "KPCustomButton.h"

@implementation KPCustomButton

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setBackgroundImage:[[UIImage imageNamed:@"button"] stretchableImageWithLeftCapWidth:6 topCapHeight:6] forState:UIControlStateNormal];
        
        //sets up button's objects' frames
        self.icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 45)];
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(80, 9, 200, 20)];
        self.message = [[UILabel alloc]initWithFrame:CGRectMake(64, 20, 220, 20)];
        
        //sets up font size, font type, text color
        self.title.font = [UIFont boldSystemFontOfSize:13];
        self.message.font = [UIFont systemFontOfSize:11];
        self.title.textColor = [UIColor whiteColor];
        self.message.textColor = [UIColor whiteColor];
        
        //sets background color of button objects
        self.title.backgroundColor = [UIColor clearColor];
        self.message.backgroundColor = [UIColor clearColor];
        self.icon.backgroundColor = [UIColor clearColor];
        
        //adds objects to button
        [self addSubview:self.title];
        [self addSubview:self.message];
        [self addSubview:self.icon];
    }
    return self;
}

//called in ViewController, sets info from poptart to objects
- (void)setPoptart:(KPPoptart *)poptart {
    [self.title setText:poptart.notification.title];
    [self.icon setImage:poptart.notification.icon];
    [self.message setText:poptart.notification.message];
}
@end
