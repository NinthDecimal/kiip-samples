//
//  KPNativeRecord.h
//  Kiip
//
//  Created by encore on 18/02/19.
//  Copyright © 2019 Kiip, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KiipSDK/KiipSDK.h>

@interface KPNativeRecord : NSObject

@property (strong, nonatomic) KPNativeRewardView *nativeRewardView;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property ( nonatomic) BOOL isCompleted;
@property ( nonatomic) BOOL isStarted;

@end
