//
//  KPCustomNotificationView.m
//  Kiip
//
//  Created by Ash Bhat on 7/9/13.
//  Copyright (c) 2013 Kiip, Inc. All rights reserved.
//

#import <KiipSDK/KPPoptart.h>

#import "KPCustomNotificationView.h"

#define HEIGHT 46

@implementation KPCustomNotificationView

- (id)initWithFrame:(CGRect)frame {    
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        self.backgroundColor = [UIColor clearColor];
        self.background = [[UIImage imageNamed:@"button"] stretchableImageWithLeftCapWidth:6 topCapHeight:6];
        
        self.titleFont = [UIFont fontWithName:@"AvenirNext-DemiBold" size:12];
        self.messageFont = [UIFont fontWithName:@"AvenirNext-Medium" size:12];
        
        // Fallbacks
        if (!self.titleFont) {
            self.titleFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:11];
        }
        if (!self.messageFont) {
            self.messageFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:11];
        }
    }
    return self;
    
}

- (void) didMoveToSuperview {
    self.frame = CGRectMake(0, 0, CGRectGetWidth(self.superview.bounds), HEIGHT);
    
    self.titleRect = CGRectMake(65, 7, CGRectGetWidth(self.bounds) - 65 - 20 - 10, self.titleFont.lineHeight);
    self.messageRect = CGRectMake(65, 23, CGRectGetWidth(self.bounds) - 65 - 10, self.messageFont.lineHeight);
}

- (void) drawRect:(CGRect)rect {
    KPNotification *notification = self.poptart.notification;
    
    // Background
    [self.background drawInRect:self.bounds];
    
    // Icon
    [notification.icon drawInRect:CGRectMake(5, 2, 55, 42)];
    
    // Title
    [[UIColor whiteColor] set];
    [notification.title drawInRect:self.titleRect withFont:self.titleFont lineBreakMode:UILineBreakModeTailTruncation];
    
    // Message
    [[UIColor whiteColor] set];
    [notification.message drawInRect:self.messageRect withFont:self.messageFont lineBreakMode:UILineBreakModeTailTruncation];
}

@end
