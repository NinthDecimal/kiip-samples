//
//  MoatAdEvent.h
//  MoatMobileAppKit
//
//  Created by Moat on 2/5/16.
//  Copyright © 2016 Moat. All rights reserved.
//
//  This class is simply a data object that encapsulates info relevant to a particular playback event.

#import <Foundation/Foundation.h>

typedef enum KIIPMoatAdEventType : NSUInteger {
    KIIPMoatAdEventComplete
    , KIIPMoatAdEventStart
    , KIIPMoatAdEventFirstQuartile
    , KIIPMoatAdEventMidPoint
    , KIIPMoatAdEventThirdQuartile
    , KIIPMoatAdEventSkipped
    , KIIPMoatAdEventStopped
    , KIIPMoatAdEventPaused
    , KIIPMoatAdEventPlaying
    , KIIPMoatAdEventVolumeChange
    , KIIPMoatAdEventNone
} KIIPMoatAdEventType;

static NSTimeInterval const KIIPMoatTimeUnavailable = NAN;
static float const KIIPMoatVolumeUnavailable = NAN;

@interface KIIPMoatAdEvent : NSObject

@property KIIPMoatAdEventType eventType;
@property NSTimeInterval adPlayhead;
@property float adVolume;
@property (readonly) NSTimeInterval timeStamp;

- (id)initWithType:(KIIPMoatAdEventType)eventType withPlayheadMillis:(NSTimeInterval)playhead;
- (id)initWithType:(KIIPMoatAdEventType)eventType withPlayheadMillis:(NSTimeInterval)playhead withVolume:(float)volume;
- (NSDictionary *)asDict;
- (NSString *)eventAsString;

@end
