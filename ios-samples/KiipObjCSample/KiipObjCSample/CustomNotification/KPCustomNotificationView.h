//
//  KPCustomNotificationView.h
//  kiip-qa-v3-notification
//
//  Created by Daniel on 3/26/18.
//  Copyright © 2018 Kiip, Inc. All rights reserved.
//

#import <KiipSDK/KiipSDK.h>

@interface KPCustomNotificationView : KPNotificationView
    @property (strong, nonatomic) UIImage *background;
    @property (strong, nonatomic) UIFont *titleFont;
    @property (nonatomic)         CGRect titleRect;
    @property (strong, nonatomic) UIFont *messageFont;
    @property (nonatomic)         CGRect messageRect;
@end
