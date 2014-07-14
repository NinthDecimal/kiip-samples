//
//  KPAppDelegate.h
//  Sample
//
//  Created by Grantland Chew on 9/19/12.
//  Copyright (c) 2012 Kiip, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KiipSDK/KiipSDK.h>

@class SampleViewController;

@interface SampleAppDelegate : UIResponder <UIApplicationDelegate, KiipDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIViewController *viewController;

@end
