//
//  MoatPassiveVideoTracker.h
//  MoatMobileAppKit
//
//  Copyright © 2016 Moat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KIIPMoatAdEvent.h"
#import "KIIPMoatBaseTracker.h"

typedef enum KIIPMoatTrackerState : NSUInteger {
    MTStateUninitialized
    , MTStateInitialized
    , MTStateTracking
    , MTStateDestroyed
} KIIPMoatTrackerState;

/** Tracker for tracking custom native video ads.
 *
 *  Unlike our standard video integration, which requires a reference to the player object and monitors playback
 * events automatically, this integration defines an API for you to dispatch the playback events to the Moat SDk and
 * does not require a reference to the player. This allows for a great degree of flexibility in the types of custom 
 * players we can support as long as you are able to dispatch the necessary events.
 *
 */
@interface KIIPMoatReactiveVideoTracker : KIIPMoatBaseTracker

@property (readonly) KIIPMoatTrackerState state;

/** Creates tracker for tracking video ads.
 *
 * Should be called before the ad is ready to play.
 *
 * @param partnerCode The code provided to you by Moat for video ad tracking.
 * @return KIIPMoatReactiveVideoTracker instance
 */
+ (KIIPMoatReactiveVideoTracker *)trackerWithPartnerCode:(NSString *)partnerCode;

/** Call to start tracking custom video ad.
 *
 * Should be called right before the ad is about to start playing.
 *
 * @param adIds information to identify and segment the ad
 * @param layer a reference to the ad's CALayer.
 * @param view the view that renders the video ad.
 * @param duration the length of the ad in milliseconds
 */
- (bool)trackVideoAd:(NSDictionary *)adIds
           withLayer:(CALayer *)layer
  withContainingView:(UIView *)view
  withDurationMillis:(NSTimeInterval)duration __deprecated_msg("Use -trackVideoAd:withLayer:withDurationMillis instead.");
/** Call to start tracking custom video ad.
 *
 * Should be called right before the ad is about to start playing.
 *
 * @param adIds information to identify and segment the ad
 * @param layer a reference to the ad's CALayer.
 * @param duration the length of the ad in milliseconds
 */
- (bool)trackVideoAd:(NSDictionary *)adIds
           withLayer:(CALayer *)layer
  withDurationMillis:(NSTimeInterval)duration;

/** Call to report a video ad event.
 *
 * @see KIIPMoatAdEvent to see the required video ad events that must be reported to the SDK if they occur
 */
- (void)dispatchEvent:(KIIPMoatAdEvent *)event;

/** Call if the layer or view in which the video ad is rendered changes.
 *
 * @param newLayer the new parent layer of the player
 * @param view the new view tha renders the video ad.
 */
- (void)changeTargetLayer:(CALayer *)newLayer
        withContainingView:(UIView *)view __deprecated_msg("Use -changeTargetLayer: instead.");

/** Call if the layer or view in which the video ad is rendered changes.
 *
 * @param newLayer the new parent layer of the player
 */
- (void)changeTargetLayer:(CALayer *)newLayer;

/**
 Sets the current volume of the player. This should be used if the player has an adjustable volume control similar to the \p volume property on AVPlayer.
 
 @param volume The volume of the player. Acceptable values are between 0.0 and 1.0.
 */

- (void)setVolume:(float)volume;

/**
 Sets whether the player is muted. This should be used if the player has a mute function similar to the \p muted property on AVPlayer.
 
 @param muted Whether the player is muted.
 */

- (void)setMuted:(BOOL)muted;

/** Call to stop tracking the ad.
 *
 * Should be called at the completion of playback to ensure that all resources are disposed of properly.
 */
- (void)stopTracking;

@end
