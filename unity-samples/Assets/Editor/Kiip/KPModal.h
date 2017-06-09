//
//  KPModal.h
//  Kiip
//
//  Created by Grantland Chew on 9/25/12.
//  Copyright (c) 2012 Kiip, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KPModalDelegate;

/**
 Use the KPModal class to display a full screen Kiip unit such as a reward.
 */
@interface KPModal : NSObject

/** @name Access Modal Properties */

/**
 The title of the loading dialog.
 */
@property (strong, nonatomic) NSString *title;

/**
 The message of the loading dialog.
 */
@property (strong, nonatomic) NSString *message;


/** @name Setting and Getting the Delegate */

/**
 The delegate of the Modal object.
 */
@property (assign, nonatomic) id<KPModalDelegate> delegate;

@end


/**
 The KPModalDelegate protocol defines the methods that a delegate of KPModal should implement. This
 delegate implements callbacks to actions such as when a modal is shown or is dismissed.
 */
@protocol KPModalDelegate <NSObject>

/** @name Managing Modals */

@optional

/**
 Tells the delegate that a Modal will be presented.
 
 @param modal The Modal that will be presented.
 */
- (void) willPresentModal:(KPModal *)modal;

/**
 Tells the delegate that a Modal was dismissed.
 
 @param modal The Modal that was dismissed.
 */
- (void) didDismissModal:(KPModal *)modal;

@end
