//
//  DialogViewController.m
//  ThiepMung
//
//  Created by DatDV on 3/10/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import "DialogViewController.h"
#import "DiaLogTableViewCell.h"
#import "MacroUtilities.h"
#import "config.h"

@interface DialogViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DialogViewController

+(DialogViewController *)dialogVC{
    return [[DialogViewController alloc] initWithNibName:@"DialogViewController" bundle:[NSBundle bundleForClass:self.class]];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"DiaLogTableViewCell" bundle:nil] forCellReuseIdentifier:@"DiaLogTableViewCellIdentifier"];
    self.tableView.scrollEnabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrDataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"DiaLogTableViewCellIdentifier";
    DiaLogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DiaLogTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.lbTitle setText:[_arrDataSource objectAtIndex:indexPath.row]];
    [cell.imageDes setImage:[UIImage imageNamed:[_arrImageDes objectAtIndex:indexPath.row]]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:[UIColor redColor]];
    [self.delegate dialogViewController:self selectIndex:indexPath.row];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    [[[self.tableView cellForRowAtIndexPath:indexPath] contentView] setBackgroundColor:VIEW_COLOR];
    DiaLogTableViewCell *cell = (DiaLogTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    [cell.lbTitle setTextColor:[UIColor whiteColor]];
    return YES;
}


@end
