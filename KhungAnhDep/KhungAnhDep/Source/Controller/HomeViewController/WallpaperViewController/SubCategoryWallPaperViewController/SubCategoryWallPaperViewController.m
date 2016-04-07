//
//  SubCategoryWallPaperViewController.m
//  KhungAnhDep
//
//  Created by DatDV on 4/6/16.
//  Copyright (c) 2016 dd. All rights reserved.
//

#import "SubCategoryWallPaperViewController.h"
#import "CustomNavigationBar.h"
#import "RootViewController.h"
#import "ItemCollectionView.h"
#import "DTheme.h"
#import "ShowBackgroundController.h"

@interface SubCategoryWallPaperViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet CustomNavigationBar *customNavigationBar;

@property (nonatomic) NSArray *arrDataSource;


@end

@implementation SubCategoryWallPaperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNavigationBar.btnMenu addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavigationBar.btnMenu setImage:IMAGE_BACK forState:UIControlStateNormal];
    [self.customNavigationBar.lbTitle setText:self.dCategoryTheme.name];
    [self.customNavigationBar.lbTitle setFont:FONT_ROBOTO_MEDIUM(20)];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ItemCollectionView" bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:@"ItemCollectionIdentifier"];
    self.collectionView.backgroundColor = VIEW_COLOR;
    
    ActivityIndicatorViewController *activityVC = [[ActivityIndicatorViewController alloc]initWithNibName:@"ActivityIndicatorViewController" bundle:nil];
    
    [Helper showViewController:activityVC inViewController:[RootViewController sharedInstance] withSize:CGSizeMake(80, 80)];
    
    [self loadData];

}

-(void)loadData{
    self.arrDataSource = [[NSMutableArray alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.arrDataSource =[NSMutableArray arrayWithArray:[AppService getWallPaperSubListWithId:self.dCategoryTheme.categoryThemeId page:1]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [Helper removeDialogViewController:[RootViewController sharedInstance]];
            [self.collectionView reloadData];
        });
    });
    
}


- (void)btnBack:(id) sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark config collectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrDataSource.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ItemCollectionIdentifier";
    DTheme *dTheme = [self.arrDataSource objectAtIndex:indexPath.row];
    ItemCollectionView *cell = (ItemCollectionView *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if(!cell){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ItemCollectionView" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell.imageBackgroud sd_setImageWithURL:[NSURL URLWithString: dTheme.thumb] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [cell.viewLabel setHidden:YES];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DTheme *dTheme = [self.arrDataSource objectAtIndex:indexPath.row];
    ShowBackgroundController *showBackgroundVC = [[ShowBackgroundController alloc]initWithNibName:@"ShowBackgroundController" bundle:nil];
    showBackgroundVC.urlBackground = dTheme.link;
    [self.navigationController pushViewController:showBackgroundVC animated:YES];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat availableWidthForCells = CGRectGetWidth(collectionView.frame) - 20;
    CGFloat cellWidth;
    if (CGRectGetWidth(collectionView.frame) >1024) {
        cellWidth = (CGRectGetWidth(collectionView.frame)-80)/4;
    }else if(CGRectGetWidth(collectionView.frame) >=480){
        cellWidth = (CGRectGetWidth(collectionView.frame)-60)/3;
    }else{
        cellWidth = availableWidthForCells / 2;
    }
    return CGSizeMake(cellWidth, cellWidth*3/4);
}

- (void)reload:(UIButton*)button {
}

@end
