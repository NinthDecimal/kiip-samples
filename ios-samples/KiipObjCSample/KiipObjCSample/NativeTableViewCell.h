//
//  NativeTableViewCell.h
//  Sample
//
//  Created by encore on 31/10/18.
//  Copyright © 2018 Kiip, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KiipSDK/KiipSDK.h>

@interface NativeTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet KPNativeRewardView *nativeRewardView;

@end
