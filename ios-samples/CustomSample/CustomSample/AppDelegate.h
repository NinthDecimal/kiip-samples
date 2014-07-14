//
//  AppDelegate.h
//  SimpleSample
//
//  Created by Ash Bhat on 7/9/13.
//  Copyright (c) 2013 Ash Bhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KiipSDK/KiipSDK.h>

@class KPCustomNotificationView;

@interface AppDelegate : UIResponder <UIApplicationDelegate, KiipDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *viewController;

@property (strong, nonatomic) KPCustomNotificationView *customNotificationView;

- (void)toggleCustomNotification:(BOOL)enabled;

@end
