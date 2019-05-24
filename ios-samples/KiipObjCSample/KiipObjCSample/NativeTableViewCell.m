//
//  NativeTableViewCell.m
//  Sample
//
//  Created by encore on 31/10/18.
//  Copyright © 2018 Kiip, Inc. All rights reserved.
//

#import "NativeTableViewCell.h"

@implementation NativeTableViewCell
@synthesize nativeRewardView;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//-(void)prepareForReuse {
//    [super prepareForReuse];
//    nativeRewardView = nil;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
