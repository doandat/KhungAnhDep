//
//  BookMarkViewController.m
//  ThiepMung
//
//  Created by DatDV on 3/22/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import "BookMarkViewController.h"
#import "AddImageTextViewController.h"
#import "ItemCollectionView.h"

@interface BookMarkViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
}
@property (nonatomic) NSMutableArray *arrDataSource;

@end

@implementation BookMarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ItemCollectionView" bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:@"ItemCollectionIdentifier"];
    [self.collectionView setBackgroundColor:VIEW_COLOR];
}
-(void)viewWillAppear:(BOOL)animated{
    [self loadDB];
}
-(void)loadDB{
    self.arrDataSource = [[NSMutableArray alloc]init];
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
        [self.arrDataSource addObject:dEffect];
    }
    
    [self.collectionView reloadData];
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
    return self.arrDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DEffect *dEffect = [self.arrDataSource objectAtIndex:indexPath.row];
    AddImageTextViewController *addImageTextVC = [[AddImageTextViewController alloc]initWithNibName:@"AddImageTextViewController" bundle:nil];
    addImageTextVC.dEffect = dEffect;
    [self.navigationController pushViewController:addImageTextVC animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat width = (([UIScreen mainScreen].bounds.size.width-10)/2>202)? ([UIScreen mainScreen].bounds.size.width-30)/4:([UIScreen mainScreen].bounds.size.width-10)/2;
    return CGSizeMake(width, width*2/3+40);
}
@end
