//
//  KPNotification.h
//  Kiip
//
//  Created by Grantland Chew on 9/25/12.
//  Copyright (c) 2012 Kiip, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    kKPGravity_Top = 0,
    kKPGravity_Bottom,
} KPGravity;

@protocol KPNotificationDelegate;

/**
 Use the KPNotification class to display an unobtrusive view to notify your users they have 
 received something such as a reward.
 */
@interface KPNotification : NSObject

/** @name Accessing Notification Properties */

/**
 The title of the notification.
 */
@property (strong, nonatomic) NSString *title;

/**
 The message of the notification.
 */
@property (strong, nonatomic) NSString *message;

/**
 The gravity of the notification.
 
 @discussion Dictacts the position that the notification gets displayed on the screen.
 */
@property (assign, nonatomic) KPGravity gravity;

/**
 The icon of the notification.
 */
//TODO use file references instead of keeping image in memory
@property (strong, nonatomic) UIImage *icon;


/** @name Setting and Getting the Delegate */

/**
 The delegate of the Notification object.
 */
@property (assign, nonatomic) id<KPNotificationDelegate> delegate;

@end


/**
 The KPNotificationDelegate protocol defines the methods that a delegate of KPNotification should implement. This
 delegate implements callbacks to actions such as when a notification is shown or is dismissed.
 */
@protocol KPNotificationDelegate <NSObject>

/** @name Managing Notifications */

@optional

/**
 Tells the delegate that a Notification will be presented.
 
 @param notification The Notification that will be presented.
 */
- (void) willPresentNotification:(KPNotification *)notification;

/**
 Tells the delegate that a Notification was dismissed.
 
 @param notification The Notification that was dismissed.
 */
- (void) didDismissNotification:(KPNotification *)notification;

/**
 Tells the delegate that a Notification was dismissed by clicking it.
 
 @param notification The Notification that was dismissed.
 */
- (void) didDismissNotificationWithClick:(KPNotification *)notification;

@end
