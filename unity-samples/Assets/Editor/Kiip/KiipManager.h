//
//  KiipManager.h
//  Unity-iPhone
//
//  Created by Mike Desaro on 11/6/12.
//
//

#import <Foundation/Foundation.h>
#import "KiipSDK.h"


@interface KiipManager : NSObject <KiipDelegate, KPModalDelegate, KPNotificationDelegate, KPPoptartDelegate>


+ (KiipManager*)sharedManager;

- (void)saveMoment:(NSString*)momentId value:(double)value;

- (void)showRemotePoptart;

@end
