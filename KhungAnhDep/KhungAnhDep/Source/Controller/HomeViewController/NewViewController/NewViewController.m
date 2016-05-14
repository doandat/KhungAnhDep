                                //
//  NewViewController.m
//  KhungAnhDep
//
//  Created by DatDV on 4/5/16.
//  Copyright (c) 2016 dd. All rights reserved.
//

#import "NewViewController.h"
#import "RootViewController.h"
#import "ItemCollectionView.h"
#import "AddImageTextViewController.h"

@interface NewViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic) NSArray *arrDataSource;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
        self.arrDataSource =[NSMutableArray arrayWithArray:[AppService getEffectListNew]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [Helper removeDialogViewController:[RootViewController sharedInstance]];
            [self.collectionView reloadData];
        });
    });
    
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

- (void)reload:(UIButton*)button {
}

@end
