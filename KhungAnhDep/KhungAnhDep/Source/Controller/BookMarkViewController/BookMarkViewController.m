//
//  BookMarkViewController.m
//  ThiepMung
//
//  Created by DatDV on 3/22/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import "BookMarkViewController.h"
#import "AddImageTextViewController.h"

@interface BookMarkViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSMutableArray *arrDataSource;
}

@end

@implementation BookMarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.collectionView setBackgroundColor:MU_RGBA(108, 64, 184, 0.7)];
    [_btnBack addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [self loadDB];
}
-(void)loadDB{
    arrDataSource = [[NSMutableArray alloc]init];
    RLMResults *bookMarkResult = [EffectBookMark allObjects];
    for (EffectBookMark *effBM in bookMarkResult) {
        DEffect *dEffect = [[DEffect alloc]init];
        dEffect.dEffect_id = effBM.dEffect_id;
        dEffect.label = effBM.label ;
        dEffect.effectDescription = effBM.effectDescription;
        dEffect.function = effBM.function;
        dEffect.avatar = effBM.avatar;
        RLMResults *inputlineBM = [InputLineBookMark objectsWhere:@"dEffect_id = %@",effBM.dEffect_id];
        NSMutableArray *arrInputLine = [[NSMutableArray alloc]init];
        for (InputLineBookMark *inputLine in inputlineBM) {
            DInputLine *dInputLine = [[DInputLine alloc]init];
            dInputLine.type = inputLine.type;
            dInputLine.title = inputLine.title;
            dInputLine.require = inputLine.require;
            [arrInputLine addObject:dInputLine];
        }
        dEffect.input_line = arrInputLine;
        
        RLMResults *inputPicBM = [InputPicBookMark objectsWhere:@"dEffect_id = %@",effBM.dEffect_id];
        NSMutableArray *arrInputPic = [[NSMutableArray alloc]init];
        for (InputPicBookMark *inputPic in inputPicBM) {
            DInputPic *dInputPic = [[DInputPic alloc]init];
            dInputPic.type = inputPic.type;
            dInputPic.require = inputPic.require;
            dInputPic.width = inputPic.width;
            dInputPic.height = inputPic.height;
            [arrInputPic addObject:inputPic];
        }
        dEffect.input_pic = arrInputPic;
        [arrDataSource addObject:dEffect];
    }
    
    [self.collectionView reloadData];
}

- (void)btnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return arrDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor colorWithRed:19/255.0f green:19/255.0f blue:19/255.0f alpha:1.0f]];
    DEffect *dEffect = [arrDataSource objectAtIndex:indexPath.row];
    CGFloat width = (([UIScreen mainScreen].bounds.size.width-10)/2>202)? ([UIScreen mainScreen].bounds.size.width-30)/4:([UIScreen mainScreen].bounds.size.width-10)/2;
    
//    SubItemCollectionView *subItemView = [[SubItemCollectionView alloc]initWithFrame:CGRectMake(0, 0, width, width*2/3+40)];
//    subItemView.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin |
//                                    UIViewAutoresizingFlexibleBottomMargin |
//                                    UIViewAutoresizingFlexibleLeftMargin|
//                                    UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
//    
//    [subItemView.imgAvatar sd_setImageWithURL:[NSURL URLWithString: dEffect.avatar] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//    subItemView.lbDes.text = dEffect.effectDescription;
//    [subItemView setBackgroundColor:[UIColor redColor]];
//    [cell addSubview:subItemView];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DEffect *dEffect = [arrDataSource objectAtIndex:indexPath.row];
    AddImageTextViewController *addImageTextVC = [[AddImageTextViewController alloc]initWithNibName:@"AddImageTextViewController" bundle:nil];
    UINavigationController *navigationAddImageText = [[UINavigationController alloc]initWithRootViewController:addImageTextVC];;
    addImageTextVC.dEffect = dEffect;
    [self presentViewController:navigationAddImageText animated:YES completion:nil];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat width = (([UIScreen mainScreen].bounds.size.width-10)/2>202)? ([UIScreen mainScreen].bounds.size.width-30)/4:([UIScreen mainScreen].bounds.size.width-10)/2;
    return CGSizeMake(width, width*2/3+40);
}
@end
