//
//  AddImageTextViewController.h
//  ThiepMung
//
//  Created by DatDV on 3/5/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import "BaseViewController.h"
#import "DEffect.h"
#import "CustomNavigationBar.h"

@interface AddImageTextViewController : BaseViewController

@property (nonatomic) DEffect *dEffect;

@property (weak, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *addImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewAddImage;

@property (strong, nonatomic) IBOutlet UIView *addTextView;
@property (weak, nonatomic) IBOutlet UITableView *tableViewAddText;

@property (weak, nonatomic) IBOutlet CustomNavigationBar *customNavigationBar;

@end
