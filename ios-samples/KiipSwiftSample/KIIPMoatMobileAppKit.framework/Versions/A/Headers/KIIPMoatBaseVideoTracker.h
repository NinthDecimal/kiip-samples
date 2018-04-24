//
//  KIIPMoatBaseVideoTracker.h
//  KIIPMoatMobileAppKit
//
//  Created by Moat 740 on 2/2/17.
//  Copyright © 2017 Moat. All rights reserved.
//

#import "KIIPMoatBaseTracker.h"
#import <Foundation/Foundation.h>

/** Tracker for tracking native video ads shown with AVPlayer or MPMoviePlayerController.
 *
 * @warning FreeWheel/IMA ads, even ones that use AVPlayer, are best tracked with specialized Moat trackers.
 * Please inform the Moat team to get custom builds and documentation for FreeWheel and IMA based ads.
 */
@interface KIIPMoatBaseVideoTracker : KIIPMoatBaseTracker

- (id)init __unavailable;
+ (id)new __unavailable;

/**
 Creates an instance of the video tracker with the provided partner code.
 
 @param partnerCode Partner code provided.
 @return Instance of tracker.
 */
+ (instancetype)trackerWithPartnerCode:(NSString *)partnerCode;

/**
 Call to stop tracking the ad. Should be called at the completion of playback to ensure that all resources are disposed of properly.
 */
- (void)stopTracking;

@end
