//
//  Kiip.h
//  Kiip
//
//  Created by Grantland Chew on 9/19/12.
//  Copyright (c) 2012 Kiip, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const KPErrorDomain;
extern NSString * const KPVersion;


extern NSString * const kKPCapabilities_Real;
extern NSString * const kKPCapabilities_Virtual;
extern NSString * const kKPCapabilities_Video;


@protocol KiipDelegate;
@class KPNotificationView;
@class KPPoptart;

/**
 Use the Kiip class to interface your application with the Kiip service.
 */
@interface Kiip : NSObject

/** @name Accessing Kiip Properties */

/**
 Setting whether or not Kiip views should sync their rotation with the application on their own/
 */
@property (assign, nonatomic) BOOL shouldAutoRotate;

/**
 The global orientation for all Kiip views. Must set shouldAutoRotate to YES for this to work.
 */
@property (assign, nonatomic) UIInterfaceOrientation interfaceOrientation;

/**
 The view that will be displayed in a notification.
 */
@property (strong, nonatomic) KPNotificationView *notificationView;

/**
 Defines the capabilities that this application is able to support.
 
 *THIS SHOULD ONLY BE SET BY WRAPPERS*
 
 This must be called AFTER setting the delegate to override the automatically detected capabilities.
 
 Use kKPCapabilities_Real, kKPCapabilities_Virtual, kKPCapabilities_Video
 */
@property (strong, nonatomic) NSArray *capabilities;

/**
 The user's email address. Setting this will auto-populate units with their email address.
 */
@property (strong, nonatomic) NSString *email;

/**
 The user's gender. Setting this will help target rewards to your users more effectively.
 */
@property (strong, nonatomic) NSString *gender;

/**
 The user's birthday. Setting this will help target rewards to your users more effectively.
 */
@property (strong, nonatomic) NSDate *birthday;

/**
 The the string Kiip uses to uniquely identify devices.
 */
@property (strong, nonatomic, readonly) NSString *deviceIdentifier;

/**
 The boolean value to receive test rewards in developement/debug mode. Default is NO.
 */
@property (assign, nonatomic) BOOL testMode;


/** @name Setting and Getting the Delegate */

/**
 The delegate of the Kiip object.

 @discussion The delegate must adopt the KiipDelegate formal protocol.
 */
@property (assign, nonatomic, setter = setDelegate:) id<KiipDelegate> delegate;


/** @name Setting and Getting the Kiip instance */

/**
 Returns the shared Kiip instance.
 */
+ (Kiip *) sharedInstance;

/**
 Sets the shared Kiip instance
 
 @param kiip New shared Kiip instance.
 */
+ (void) setSharedInstance:(Kiip *)kiip;


/** @name Creating a new Kiip object */

/**
 Initializes a Kiip object with the specified values.
 
 @param appKey The Application's key.
 @param appSecret The Application's secret.
 */
- (id) initWithAppKey:(NSString *)appKey andSecret:(NSString *)appSecret;


/** @name Saving Moments */

/**
 Saves a moment.
 
 @param momentId The unique identifier of the moment to be recorded.
 @param handler A block to be called when the HTTP request asynchronously completes, with a Poptart
        and an Error. The Poptart may return nil if no reward has been issued. The Error will be 
        nil if the request completed successfully.
 */
- (void) saveMoment:(NSString *)momentId withCompletionHandler:(void (^)(KPPoptart *poptart, NSError *error))handler;

- (void) saveMoment:(NSString *)momentId withAssetId:(NSString *)assetId withCompletionHandler:(void (^)(KPPoptart *, NSError *))handler;

/**
 Saves a moment.

 @param momentId The unique identifier of the moment to be recorded.
 @param value The value of the moment.
 @param handler A block to be called when the HTTP request asynchronously completes, with a Poptart
 and an Error. The Poptart may return nil if no reward has been issued. The Error will be
 nil if the request completed successfully.
 */
- (void) saveMoment:(NSString *)momentId value:(double)value withCompletionHandler:(void (^)(KPPoptart *poptart, NSError *error))handler;

@end

/**
 The KiipDelegate protocol defines the methods that a delegate of Kiip should implement. This
 delegate implements the session, swarm and virtual content callbacks.
 */
@protocol KiipDelegate <NSObject>

@optional

/** @name Managing Kiip Sessions */

/**
 Tells the delegate that Kiip attempted to start a new session.
 
 @param kiip The Kiip instance that started the session.
 @param poptart A unit to be displayed. May be nil.
 @param error If not nil, an error occured.
 */
- (void) kiip:(Kiip *)kiip didStartSessionWithPoptart:(KPPoptart *)poptart error:(NSError *)error;

/**
 Tells the delegate that Kiip attempted to end it's session.

 @param kiip The Kiip instance that ended the session.
 @param error If not nil, an error occured.
 */
- (void) kiip:(Kiip *)kiip didEndSessionWithError:(NSError *)error;


/** @name Managing Virtual Achievements */

/**
 Tells the delegate that the user has recieved in-game content.

 @param kiip The Kiip instance that indicated the user should receive in-game content.
 @param content The identifier of the content that should be awarded to the user.
 @param quantity The amount of content that should be awarded to the user.
 @param transactionId The unique identifer of this transaction.
 @param signature The signature that can be checked to validate this transaction.
 */
- (void) kiip:(Kiip *)kiip didReceiveContent:(NSString *)content quantity:(int)quantity transactionId:(NSString *)transactionId signature:(NSString *)signature;

/** @name Video Playback Callbacks */

/**
 Tells the delegate that a video session has begun.
 
@param kiip The Kiip instance that has begun playing video.
 */
- (void) kiipVideoPlaybackDidBegin:(Kiip *)kiip;

/**
 Tells the delegate that a video session has ended.
 
 @param kiip The Kiip instance that has finished playing video.
 */
- (void) kiipVideoPlaybackDidEnd:(Kiip *)kiip;

@end
