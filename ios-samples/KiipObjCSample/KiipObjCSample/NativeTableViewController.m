//
//  NativeTableViewController.m
//  Sample
//
//  Created by encore on 30/10/18.
//  Copyright © 2018 Kiip, Inc. All rights reserved.
//

#import "NativeTableViewController.h"
#import <KiipSDK/KiipSDK.h>
#import "NativeTableViewCell.h"
#import "KPNativeRecord.h"

@interface NativeTableViewController ()<KPPoptartDelegate, KPModalDelegate>

@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic,strong) NSMutableArray *adList;
@property (strong, nonatomic) KPNativeRewardView *nativeRewardView;
@property (strong, nonatomic) NSMutableArray *adPosition;
@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) NSOperation *completionOperation;
@property (nonatomic, strong) KPNativeRecord *nativeRecord;
@end

@implementation NativeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.adPosition = [[NSMutableArray alloc] init];
    self.adList = [[NSMutableArray alloc] init];
    self.data = [NSMutableArray arrayWithCapacity:1000];
    for (int i = 0; i < 1000; i++) {
        [self.data addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    [self adIndexPath];
    
    CGRect tableRect = CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height - 50);
//    self.tableview = [[UITableView alloc] initWithFrame:tableRect];
//   // [self.tableview registerClass:[KPTableViewCell class] forCellReuseIdentifier:@"NativeTableViewCell"];
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    [self.view addSubview:self.tableview];
    
    self.queue = [[NSOperationQueue alloc] init];
    self.queue.name = @"AFHTTPSessionManager queue";
    
    // Do any additional setup after loading the view from its nib.
}


- (void)adIndexPath {
    
    NSArray * indexPathArray = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:3 inSection:0],[NSIndexPath indexPathForRow:6 inSection:0],[NSIndexPath indexPathForRow:9 inSection:0],[NSIndexPath indexPathForRow:12 inSection:0],[NSIndexPath indexPathForRow:15 inSection:0], nil];
    for (int i= 0 ; i< [indexPathArray count] ; i++ ){
            self.nativeRecord = [[KPNativeRecord alloc] init];
            self.nativeRecord.indexPath = [indexPathArray objectAtIndex:i];
            [self.adList addObject:self.nativeRecord];
            [self.adPosition addObject:[indexPathArray objectAtIndex:i]];
    }
    
    
}


- (IBAction)dismissTableView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;   //have to think about when a user define more then 1 section
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count]+[self.adList count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    if([self.adPosition containsObject:indexPath]) {
        static NSString *cellIdentifier = @"NativeTableViewCell";
        
        NativeTableViewCell *nativeCell = (NativeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (nativeCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NativeTableViewCell" owner:self options:nil];
            nativeCell = [nib objectAtIndex:0];
        }
        
        [self loadImagesForOnscreenRows];
        return nativeCell;
    } else {
        
        static NSString *cellIdentifier = @"kiip";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text =  [self.data objectAtIndex:indexPath.row];
        return cell;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.adPosition containsObject:indexPath]) {
        return  250;
    }
    return UITableViewAutomaticDimension;
}

-(void)addNativeView:(NSIndexPath *)indexPath {
    
    void (^handler)(KPPoptart *, NSError *) = ^(KPPoptart *poptart, NSError *error) {
        KPNativeRecord *appRecord = (self.adList)[[self.adPosition indexOfObject:indexPath]];

        if (error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }

        // Since we've implemented this block, Kiip will no longer show the poptart automatically
        poptart.delegate = self;

        if (poptart.modal) {
            poptart.modal.delegate = self;
        }
        [poptart showNativeRewardView:appRecord.nativeRewardView];
        appRecord.isCompleted = YES;
    };
    
    [[Kiip sharedInstance] saveMoment:@"d" withCompletionHandler:handler];
    
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self loadImagesForOnscreenRows];
    }
}

// -------------------------------------------------------------------------------
//    scrollViewDidEndDecelerating:scrollView
//  When scrolling stops, proceed to load the app icons that are on screen.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}

- (void)loadImagesForOnscreenRows {
    
    NSArray *visibleCell = [self.tableview visibleCells];
    
    for (UITableViewCell *cell in visibleCell) {
        
        if([cell isKindOfClass:NativeTableViewCell.class]) {
            
            NativeTableViewCell *nativeCell = (NativeTableViewCell *)cell;
            NSIndexPath *indexPath = [self.tableview indexPathForRowAtPoint:nativeCell.center];

            if([self.adPosition containsObject:indexPath]) {
            KPNativeRecord *appRecord = (self.adList)[[self.adPosition indexOfObject:indexPath]];
            if (appRecord.isCompleted) {

                NSArray * subviews  = [nativeCell subviews];
                for (UIView *subview in subviews) {
                    if([subview isKindOfClass:KPNativeRewardView.class]) {
                        [subview removeFromSuperview];
                    }
                }
                
                [nativeCell addSubview:appRecord.nativeRewardView];

            } else {
                
                NSArray * subviews  = [nativeCell subviews];
                for (UIView *subview in subviews) {
                    if([subview isKindOfClass:KPNativeRewardView.class]) {
                        [subview removeFromSuperview];
                    }
                }

                if (appRecord.isStarted){
                    
                } else {
                    appRecord.isStarted = YES;
                    appRecord.indexPath = indexPath;
                    appRecord.nativeRewardView = [self newnativeRewardView];
                    [self addNativeView:indexPath];
                }
             }
            }
            
          }
     }
}

-(KPNativeRewardView *) newnativeRewardView {
    
    KPNativeRewardView *nativeRewardView  = [[KPNativeRewardView alloc] initWithCGpoint:CGPointMake(0, 0) setViewType:FLUID_RECTANGLE];
    return nativeRewardView;
}


- (void) willPresentPoptart:(KPPoptart *)poptart{
    
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
