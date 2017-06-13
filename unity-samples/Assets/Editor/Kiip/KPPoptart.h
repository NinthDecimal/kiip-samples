//
//  KPPoptart.h
//  Kiip
//
//  Created by Grantland Chew on 9/21/12.
//  Copyright (c) 2012 Kiip, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KPNotification.h"
#import "KPModal.h"

@protocol KPPoptartDelegate;

/**
 Use the KPPoptart to display Kiip units such as rewards to your users.
 */
@interface KPPoptart : NSObject

/** @name Accessing Poptart Properties */

/**
 The unique identifier of the poptart.
 */
@property (strong, nonatomic) NSString *viewId;

/**
 The notification of the poptart.
 */
@property (strong, nonatomic) KPNotification *notification;

/**
 The modal of the poptart.
 */
@property (strong, nonatomic) KPModal *modal;


/** @name Setting and Getting the Delegate */

/**
 The delegate of the Poptart object.
 */
@property (assign, nonatomic) id<KPPoptartDelegate> delegate;


/** @name Showing the Poptart */

/**
 Show the Poptart.
 */
- (void) show;

@end


/**
 The KPPoptartDelegate protocol defines the methods that a delegate of KPPoptart should implement. This
 delegate implements callbacks to actions such as when a Poptart is shown or dismissed.
 */
@protocol KPPoptartDelegate <NSObject>

/** @name Managing Poptarts */

@optional

/**
 Tells the delegate a Poptart will be presented.
 
 @param poptart The poptart that will be presented.
 */
- (void) willPresentPoptart:(KPPoptart *)poptart;

/**
 Tells the delegate a Poptart was dismissed.
 
 @param poptart The poptart that was dismissed.
 */
- (void) didDismissPoptart:(KPPoptart *)poptart;

@end
