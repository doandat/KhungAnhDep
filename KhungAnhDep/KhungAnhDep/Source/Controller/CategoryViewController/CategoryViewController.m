//
//  CategoryViewController.m
//  KhungAnhDep
//
//  Created by DatDV on 4/5/16.
//  Copyright (c) 2016 dd. All rights reserved.
//

#import "CategoryViewController.h"
#import "RootViewController.h"
#import "ItemCollectionView.h"
#import "AddImageTextViewController.h"

@interface CategoryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSArray *arrDataSource;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    SWRevealViewController *revealController = [self revealViewController];
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    //custom navigationbar
    [self.customNavigationBar.btnMenu addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavigationBar.lbTitle setText:self.dCategory.dCategory_name];
    [self.customNavigationBar.lbTitle setFont:FONT_ROBOTO_MEDIUM(20)];
    [self.customNavigationBar.btnReload addTarget:self action:@selector(btnReload:) forControlEvents:UIControlEventTouchUpInside];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ItemCollectionView" bundle:[NSBundle mainBundle]]
        forCellWithReuseIdentifier:@"ItemCollectionIdentifier"];
    self.collectionView.backgroundColor = VIEW_COLOR;

    ActivityIndicatorViewController *activityVC = [[ActivityIndicatorViewController alloc]initWithNibName:@"ActivityIndicatorViewController" bundle:nil];
    
    [Helper showViewController:activityVC inViewController:[RootViewController sharedInstance] withSize:CGSizeMake(80, 80)];

    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadData{
    self.arrDataSource = [[NSMutableArray alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.arrDataSource =[NSMutableArray arrayWithArray:[AppService getEffectListWithCategoryId:self.dCategory.dCategory_id]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [Helper removeDialogViewController:[RootViewController sharedInstance]];
            [self.collectionView reloadData];
        });
    });
    
}

#pragma mark config collectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrDataSource.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ItemCollectionIdentifier";
    
    DEffect *dEffect = [self.arrDataSource objectAtIndex:indexPath.row];
    ItemCollectionView *cell = (ItemCollectionView *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if(!cell){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ItemCollectionView" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    [cell.imageBackgroud sd_setImageWithURL:[NSURL URLWithString: dEffect.avatar] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//    [cell setBackgroundColor:[UIColor redColor]];
    [cell.lbTitle setText:dEffect.label];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DEffect *dEffect = [self.arrDataSource objectAtIndex:indexPath.row];
    AddImageTextViewController *addImageTextVC = [[AddImageTextViewController alloc]initWithNibName:@"AddImageTextViewController" bundle:nil];
    addImageTextVC.dEffect = dEffect;
    [self.navigationController pushViewController:addImageTextVC animated:YES];

    
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

- (void)btnReload:(id)sender {
    ActivityIndicatorViewController *activityVC = [[ActivityIndicatorViewController alloc]initWithNibName:@"ActivityIndicatorViewController" bundle:nil];
    [Helper showViewController:activityVC inViewController:[RootViewController sharedInstance] withSize:CGSizeMake(80, 80)];
    [self loadData];
}

@end
