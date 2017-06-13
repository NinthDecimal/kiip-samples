//
//  KPNotificationView.h
//  Kiip
//
//  Created by Grantland Chew on 9/27/12.
//  Copyright (c) 2012 Kiip, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KPPoptart;

/**
 Use the KPNotification class to customize the look and feel of the KPNotifications shown in your app.
 
 Use the notificationView property in Kiip and KPNotificationView's poptart property to change it for
 each new KPPoptart.
 */
@interface KPNotificationView : UIButton

/** @name Access NotificationView Properties */

/**
 The poptart that will be displayed.
 
 @discussion The setter for this property should be overritten to read the Notification's properties
 to change the rendering of this view to match the current Poptart.
 */
@property (strong, nonatomic) KPPoptart *poptart;

@end
