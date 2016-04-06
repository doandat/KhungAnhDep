//
//  SideBarViewController.m
//  KhungAnhDep
//
//  Created by DatDV on 4/5/16.
//  Copyright (c) 2016 dd. All rights reserved.
//

#import "SideBarViewController.h"
#import "MenuTableViewCell.h"
#import "SWRevealViewController.h"
#import "HomeViewController.h"
#import "CategoryViewController.h"

@interface SideBarViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) NSMutableArray *menuItems;
@property (nonatomic) BOOL sidebarMenuOpen;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SideBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
//    [self.view setBackgroundColor:[UIColor colorWithRed:12/255.0f green:40/255.0f blue:52/255.0f alpha:1.0f]];
//    UINavigationBar *navBar = self.navigationController.navigationBar;
//    [navBar setBarTintColor:[UIColor colorWithRed:12/255.0f green:40/255.0f blue:52/255.0f alpha:1.0f]];
//    [navBar setTintColor:[UIColor whiteColor]];
    
    self.sidebarMenuOpen = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"MenuTableViewCellIdentifier"];
    [self.tableView reloadData];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:VIEW_COLOR];
    
    self.menuItems= [[NSMutableArray alloc] init];
    [self.menuItems addObject:@"TrangChu"];
    [self.menuItems addObjectsFromArray:[AppService getDCategoryFromUrlString:URL_GET_CATEGORY]];
}

- (void)viewWillAppear:(BOOL)animated{
    self.sidebarMenuOpen = NO;
    [self.tableView reloadData];
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
    return [self.menuItems count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuTableViewCell *cell = (MenuTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCellIdentifier"];
    if (indexPath.row == 0) {
        cell.lbTitle.text = [self.menuItems objectAtIndex:indexPath.row];
    }else{
        cell.lbTitle.text = [(DCategory *)[self.menuItems objectAtIndex:indexPath.row] dCategory_name];
    }
    [cell.imageDes setImage:[UIImage imageNamed:@
                             "icon_defaul.png"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.contentView.backgroundColor = [UIColor colorWithRed:3/255.0f green:169/255.0f blue:245/255.0f alpha:1.0f];
    cell.contentView.backgroundColor = VIEW_COLOR;

    return cell;
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
//    [[[self.tableView cellForRowAtIndexPath:indexPath] contentView] setBackgroundColor:[UIColor colorWithRed:2/255.0f green:136/255.0f blue:209/255.0f alpha:1.0f]];
//    [[[self.tableView cellForRowAtIndexPath:indexPath] contentView] setBackgroundColor:NAVIGATIONBAR_COLOR];

    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [[[self.tableView cellForRowAtIndexPath:indexPath] contentView] setBackgroundColor:[UIColor colorWithRed:2/255.0f green:136/255.0f blue:209/255.0f alpha:1.0f]];
    [[[self.tableView cellForRowAtIndexPath:indexPath] contentView] setBackgroundColor:NAVIGATIONBAR_COLOR];

    if (indexPath.row == 0) {
        HomeViewController *homeVC = [[HomeViewController alloc]init];
        [self.revealViewController pushFrontViewController:homeVC animated:YES];
        
    }else{
        CategoryViewController *categoryVC = [[CategoryViewController alloc]init];
        categoryVC.dCategory = [self.menuItems objectAtIndex:indexPath.row];
        [self.revealViewController pushFrontViewController:categoryVC animated:YES];

    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *viewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
    UILabel *lbTitle = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, self.view.frame.size.width -20, 34)];
    [lbTitle setText:@"Menu"];
    [lbTitle setFont:[UIFont fontWithName:@"Roboto-Medium" size:30]];
    [lbTitle setTextColor:[UIColor whiteColor]];
    
    [viewHeader addSubview:lbTitle];
//    [viewHeader setBackgroundColor:[UIColor colorWithRed:2/255.0f green:136/255.0f blue:209/255.0f alpha:1.0f]];
    [viewHeader setBackgroundColor:NAVIGATIONBAR_COLOR];
    UIView *viewSeparator = [[UIView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 1)];
    [viewSeparator setBackgroundColor:SEPARATOR_COLOR];
    [viewHeader addSubview:viewSeparator];
    
    return viewHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.sidebarMenuOpen == YES){
        return nil;
    } else {
        self.sidebarMenuOpen = YES;
        return indexPath;
    }
}

@end
