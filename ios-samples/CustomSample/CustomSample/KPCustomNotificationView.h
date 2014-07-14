//
//  KPCustomNotificationView.h
//  Kiip
//
//  Created by Ash Bhat on 7/9/13.
//  Copyright (c) 2013 Kiip, Inc. All rights reserved.
//

#import <KiipSDK/KPNotificationView.h>

@interface KPCustomNotificationView : KPNotificationView

@property (strong, nonatomic) UIImage *background;
@property (strong, nonatomic) UIFont *titleFont;
@property (nonatomic)         CGRect titleRect;
@property (strong, nonatomic) UIFont *messageFont;
@property (nonatomic)         CGRect messageRect;

@end
