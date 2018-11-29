//
//  KiipNativeViewController.m
//  KiipObjCSample
//
//  Created by encore on 28/11/18.
//  Copyright © 2018 Kiip. All rights reserved.
//

#import "KiipNativeViewController.h"
#import <KiipSDK/KiipSDK.h>

@interface KiipNativeViewController ()<KPPoptartDelegate, KPModalDelegate>
@property (strong, nonatomic) KPNativeRewardView *nativeRewardView;

@end

@implementation KiipNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NativeView";
    // Do any additional setup after loading the view.
    self.nativeRewardView  = [[KPNativeRewardView alloc] initWithCGpoint:CGPointMake(20, 80) setViewType:FLUID_RECTANGLE];
    self.nativeRewardView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.nativeRewardView];
}

- (IBAction)actionNativeView:(id)sender {
    
    void (^handler)(KPPoptart *, NSError *) = ^(KPPoptart *poptart, NSError *error) {
        if (error) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Title" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
        // Since we've implemented this block, Kiip will no longer show the poptart automatically
        poptart.delegate = self;
        
        if (poptart.modal) {
            poptart.modal.delegate = self; 
        }
        [poptart showNativeRewardView:self.nativeRewardView];
    };
    [[Kiip sharedInstance] saveMoment:@"d" withCompletionHandler:handler];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
