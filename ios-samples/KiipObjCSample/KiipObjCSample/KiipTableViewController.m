//
//  KiipTableViewController.m
//  KiipObjCSample
//
//  Copyright © 2018 Kiip. All rights reserved.
//

#import "KiipTableViewController.h"
#import <KiipSDK/KiipSDK.h>

@interface KiipTableViewController ()

@property (strong, nonatomic) KPTableView *placer;
@property (nonatomic,strong) NSMutableArray *data;

@end

@implementation KiipTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"TableView";
    CGRect tableRect = CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height - 50);
    self.tableview = [[UITableView alloc] initWithFrame:tableRect];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableview kp_setDelegate:self];
    [self.tableview kp_setDataSource:self];

    self.data = [NSMutableArray arrayWithCapacity:1000];
    for (int i = 0; i < 1000; i++) {
        [self.data addObject:[NSString stringWithFormat:@"%d", i]];
    }
    self.placer = [KPTableView placerWithTableView:self.tableview viewController:self];
    
    [self.view addSubview:self.tableview];
    [self.placer loadAdsForAdUnitID:@"Enter Your Moment ID"];

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;   //have to think about when a user define more then 1 section
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"kiip";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text =  [self.data objectAtIndex:indexPath.row];
    //    cell.textLabel.text = [NSString stringWithFormat:@"Cell : %ld", (long)indexPath.row];
    return cell;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
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
