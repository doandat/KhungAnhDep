//
//  AddImageTextViewController.m
//  ThiepMung
//
//  Created by DatDV on 3/5/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import "AddImageTextViewController.h"
#import "AddTextTableViewCell.h"
#import "WYPopoverController.h"
#import "DialogViewController.h"
#import "CropImageViewController.h"
#import "MessageViewController.h"
#import "ResultViewController.h"
#import "ActivityIndicatorViewController.h"

#import "InputHelper.h"

@interface AddImageTextViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,WYPopoverControllerDelegate,DialogViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CropImageDelegate,MessageDelegate>{
    UIImageView *imageView;
    UIView *viewContainDes;
    UILabel *lbDes;
    UILabel *lbTitleViewAddImage;
    UIButton *btnOk;
    WYPopoverController *btnAddImagePopoverController;
    NSInteger indexSelectDialog;
    CropImageViewController *cropImageVC;
    NSInteger tagSelected;
    NSMutableArray *arrImage;
    
    NSInteger indexTextViewChanging;
    NSInteger indexImageInputSelected;
    BOOL checkBookMark;
    
}
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) UIImage *imagePicker;
@property (nonatomic) BOOL *check;

@property (nonatomic) NSInteger numberInputText;
@property (nonatomic) NSInteger numberInputImg;
@property (nonatomic) CGFloat heightImgAdd;

@end

@implementation AddImageTextViewController
@synthesize numberInputText;
@synthesize numberInputImg;
@synthesize heightImgAdd;
@synthesize collectionViewAddImage;
@synthesize tableViewAddText;
@synthesize imagePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.customNavigationBar.btnMenu addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavigationBar.btnMenu setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [self.customNavigationBar.lbTitle setText:self.dEffect.label];
    [self.customNavigationBar.lbTitle setFont:[UIFont fontWithName:@"Roboto-Medium" size:22]];
    [self.customNavigationBar.btnReload addTarget:self action:@selector(btnBookmark:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavigationBar.btnReload setImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
    [self.customNavigationBar.btnReload setImage:[UIImage imageNamed:@"favorited.png"] forState:UIControlStateSelected];
    
    RLMResults *bookMark = [EffectBookMark objectsWhere:@"dEffect_id = %@",[NSString stringWithFormat:@"%@",_dEffect.dEffect_id]];
    if (bookMark.count) {
        NSLog(@"đã lưu rồi");
        checkBookMark = YES;
        [self.customNavigationBar.btnReload setSelected:YES];
    }

    imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_dEffect.avatar ] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.scrollView addSubview:imageView];
    
    viewContainDes = [[UIView alloc]init];
    [viewContainDes setBackgroundColor:VIEW_COLOR];
    viewContainDes.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:viewContainDes];
    
    lbDes = [[UILabel alloc]init];
    [lbDes setText:_dEffect.effectDescription];
    [lbDes setNumberOfLines:0];
    lbDes.textAlignment = NSTextAlignmentJustified;
    [lbDes setFont:[UIFont fontWithName:@"Helvetica Neue" size:14]];
    [lbDes setTextColor:MU_RGBA(255, 255,255,0.9)];
    lbDes.translatesAutoresizingMaskIntoConstraints = NO;
    
    [viewContainDes addSubview:lbDes];
    
    
    numberInputImg = _dEffect.input_pic.count;
    heightImgAdd = 60;
    numberInputText = _dEffect.input_line.count;
    indexImageInputSelected = 0;
    
    lbTitleViewAddImage = [[UILabel alloc]init];
    if (numberInputImg) {
        lbTitleViewAddImage.text = @"Chọn ảnh ghép";
    }
    lbTitleViewAddImage.textColor =MU_RGB(70, 6, 143);
    lbTitleViewAddImage.translatesAutoresizingMaskIntoConstraints = NO;

    [self.scrollView addSubview:lbTitleViewAddImage];
    
    /*Create add Image input View*/
    collectionViewAddImage.translatesAutoresizingMaskIntoConstraints = NO;
    collectionViewAddImage.backgroundColor = [UIColor yellowColor];
    [self.scrollView addSubview:collectionViewAddImage];
    
    /*Create add Text input View*/
    tableViewAddText.translatesAutoresizingMaskIntoConstraints = NO;
    tableViewAddText.backgroundColor = [UIColor darkGrayColor];
    [self.scrollView addSubview:tableViewAddText];
    
    
    btnOk = [[UIButton alloc]init];
    [btnOk setBackgroundColor:MU_RGB(108,46 , 184)];
    btnOk.layer.cornerRadius = 6.0f;
    [btnOk setTitle:@"OK" forState:UIControlStateNormal];
    [btnOk addTarget:self action:@selector(btnOK:) forControlEvents:UIControlEventTouchUpInside];
    btnOk.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:btnOk];
    

    [self updateViewConstraints];
    
    /*config collection view*/
    self.collectionViewAddImage.dataSource = self;
    self.collectionViewAddImage.delegate = self;
    [self.collectionViewAddImage registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.collectionViewAddImage setBackgroundColor:[UIColor whiteColor]];
    
    /*config tableview view*/
    self.tableViewAddText.dataSource = self;
    self.tableViewAddText.delegate = self;
    self.tableViewAddText.scrollEnabled = NO;
    [self.tableViewAddText reloadData];
    [self.tableViewAddText registerNib:[UINib nibWithNibName:@"AddTextTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddTextTableViewCellIdentifier"];
    self.tableViewAddText.allowsSelection = NO;
    
    arrImage = [[NSMutableArray alloc] initWithCapacity:numberInputImg];
    for (int i = 0; i < numberInputImg; i++) {
        [arrImage insertObject:[NSNull null] atIndex:i];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    [self.view layoutIfNeeded];
    

}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
//    [_btnBack addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];

    [self.scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, imageView.frame.size.height+100+self.addImageView.frame.size.height+numberInputText*80)];
    NSLog(@"viewWillAppear dEffect:%@",_dEffect);
}
-(void)viewWillDisappear:(BOOL)animated{
    /*  Turn off Keyboard Notification */
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
}
-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    /*add constraint for imageview with constraint Top, left, right, height(aspect ratio) */

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.scrollView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.scrollView
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.scrollView
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:imageView
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:imageView
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:2.0/3.0 //Aspect ratio: 4*height = 3*width
                                                            constant:0.0f]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:imageView
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:1.0
                                                            constant:0.0f]];

    /*add constraint for viewContainDes with constraint Top (imageview), left, right, height(70) */
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:viewContainDes attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:imageView attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:viewContainDes
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.scrollView
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:viewContainDes
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.scrollView
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[viewContainDes(==70)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(viewContainDes)]];
    /*add constraint for lbDes with constraint Top (ViewContainDes), left, right, height(70) */
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:lbDes attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:viewContainDes attribute:NSLayoutAttributeTop
                                                         multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:lbDes
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:viewContainDes
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:10.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:lbDes
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:viewContainDes
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:-10.0]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:lbDes attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:viewContainDes attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0 constant:0]];


    /*add constraint for lbTitleViewAddImage with constraint Top (lbDes), left, right, height(30) */

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:lbTitleViewAddImage attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:viewContainDes attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:lbTitleViewAddImage
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.scrollView
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:10.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:lbTitleViewAddImage
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.scrollView
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:0.0]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lbTitleViewAddImage(==30)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(lbTitleViewAddImage)]];

    
    
    

    /*add constraint for collectionViewAddImage with constraint Top (lbTitleViewAddImage), left, right, height(must caculator follow total image input) */

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:collectionViewAddImage attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:lbTitleViewAddImage attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:collectionViewAddImage
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.scrollView
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:10.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:collectionViewAddImage
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.scrollView
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:-10.0]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat: @"V:[collectionViewAddImage(==%f)]",[self hightOfAddImageVCWithTotalImage:numberInputImg]]
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(collectionViewAddImage)]];

    
    /*add constraint for tableViewAddText with constraint Top (collectionViewAddImage), left, right, height(must caculator follow total text input) */

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tableViewAddText attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:collectionViewAddImage attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tableViewAddText
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.scrollView
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tableViewAddText
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.scrollView
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat: @"V:[tableViewAddText(==%f)]",numberInputText*75.0]
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(tableViewAddText)]];
    
    /*add constraint for btnOk with constraint Top (tableViewAddText), width(70), height (50), centerX */
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btnOk attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:tableViewAddText attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0 constant:20]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btnOk
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.scrollView
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[btnOk(==50)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(btnOk)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[btnOk(==100)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(btnOk)]];
    
    
}


-(void)btnOK:(id) sender{
    ActivityIndicatorViewController *activityIndicator = [[ActivityIndicatorViewController alloc]initWithNibName:@"ActivityIndicatorViewController" bundle:nil];
    [Helper showViewController:activityIndicator inViewController:self withSize:CGSizeMake(80, 80)];
    
    [self.view endEditing:YES];

    
    //////////////////////
    NSString *text;
    NSArray *arrLine = [NSArray arrayWithObjects:@"line_1", @"line_2", @"line_3", @"line_4", @"line_5", @"line_6", @"line_7", @"line_8", @"line_9", @"line_10", nil];
    NSArray *arrPic = [NSArray arrayWithObjects: @"picture_1", @"picture_2", @"picture_3", @"picture_4", @"picture_5", @"picture_6", @"picture_7", @"picture_8", @"picture_9", @"picture_10", nil];
    
    BOOL checkInputLine = true;
    // Dictionary that holds post parameters.
    NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
    [_params setObject:_dEffect.function forKey:@"function"];
    //set text cho các dòng
    for (int i = 0; i< numberInputText; i++) {
        AddTextTableViewCell *cell =(AddTextTableViewCell *) [self.tableViewAddText cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (([[(DInputLine*)[_dEffect.input_line objectAtIndex:i] require] isEqualToString:@"true"])&& (([cell.tvMessage.text isEqual: @""])|| ([cell.tvMessage.text isEqual:[(DInputLine*)[_dEffect.input_line objectAtIndex:i] title]]))){
            checkInputLine = false;
            [cell.tvMessage setTextColor:[UIColor redColor]];
        }else{
            if ([cell.tvMessage.text isEqualToString:[(DInputLine*)[_dEffect.input_line objectAtIndex:i] title]]) {
                [_params setObject:@"" forKey:arrLine[i]];
            }else{
                [_params setObject:cell.tvMessage.text forKey:arrLine[i]];
            }
        }
    }
    if (!checkInputLine) {
        
        MessageViewController *messageVC = [[MessageViewController alloc]initWithNibName:@"MessageViewController" bundle:nil];
        messageVC.titleText = @"Message";
        messageVC.message = @"You must fill input line. Please fill now";
        messageVC.delegate = self;
        [Helper showViewController:messageVC inViewController:self withSize:CGSizeMake(300, 200)];
        
        return;
    }
    //set các picture
    for (int i = 0; i< numberInputImg; i++) {
        //NSLog(@"countPic");
        
        if (([[(DInputPic*)[_dEffect.input_pic objectAtIndex:i] require] isEqualToString:@"true"])&& ([[arrImage objectAtIndex:i] isEqual:[NSNull null]])){
            MessageViewController *messageVC = [[MessageViewController alloc]initWithNibName:@"MessageViewController" bundle:nil];
            messageVC.titleText = @"Message";
            messageVC.message = @"You have to select a sufficient number of photographs. Please pick now";
            messageVC.delegate = self;
            [Helper showViewController:messageVC inViewController:self withSize:CGSizeMake(300, 200)];
            return;
        }else{
            
            text = [Helper encodeToBase64String:[arrImage objectAtIndex:i]];
            [_params setObject: text forKey:arrPic[i]];
            
        }
    }
    
    NSLog(@"_params:%@",_params);
    //encode dữ liệu trước khi gửi server
    NSString *encodedDictionary = [Helper encodeDataFromDictionary:_params];
    
    NSData *bodyEncodedString = [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        UIImage *imageResult = [AppService createPictureWithUrlString:URL_CREATE_PICTURE bodyRequest:bodyEncodedString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //đặt lại dữ liệu
            for (int i = 0; i< numberInputImg; i++) {
                UIButton *button = (UIButton *) [self.collectionViewAddImage viewWithTag:2000+i];
                [button setBackgroundImage:[UIImage imageNamed:@"addpicture.png"] forState:UIControlStateNormal];
            }
            
            for (int i = 0; i < numberInputImg; i++) {
                [arrImage replaceObjectAtIndex:i withObject:[NSNull null]];
            }
            ResultViewController *resultVC = [[ResultViewController alloc]initWithNibName:@"ResultViewController" bundle:nil];
            resultVC.imageResult = imageResult;
            [Helper removeDialogViewController:self];
            if (!imageResult) {
                NSLog(@"err");
            }else{
                [self.navigationController pushViewController:resultVC animated:YES];
            }
            
        });
        
    });
    ///////////////////////
    
}


-(CGFloat)hightOfAddImageVCWithTotalImage:(NSInteger)totalImg{
    CGFloat heightView ;
    if (totalImg) {
        NSInteger numRow = (int)ceilf((totalImg/ ((int)([UIScreen mainScreen].bounds.size.width-20)/(heightImgAdd+10))));
        
        heightView = numRow*heightImgAdd+(numRow-1)*10;
    }else{
        heightView = 0;
    }
    
    
    return heightView;
}
- (void)viewDidAppear:(BOOL)animated{
    [self.scrollView setContentSize:CGSizeMake(self.viewContent.frame.size.width,imageView.frame.size.height+200+self.addImageView.frame.size.height+numberInputText*80)];
}

- (void)btnBack:(id) sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)btnBookmark:(id)sender{
    if ([sender isSelected]) {
        RLMResults *inputLineArr = [InputLineBookMark objectsWhere:@"dEffect_id = %@",[NSString stringWithFormat:@"%@",_dEffect.dEffect_id]];
        for (InputLineBookMark *inputLineBM in inputLineArr) {
            RLMRealm *realm = RLMRealm.defaultRealm;
            [realm beginWriteTransaction];
            [realm deleteObject:inputLineBM];
            [realm commitWriteTransaction];
        }
        RLMResults *inputPicArr = [InputPicBookMark objectsWhere:@"dEffect_id = %@",[NSString stringWithFormat:@"%@",_dEffect.dEffect_id]];
        for (InputPicBookMark *inputPicBM in inputPicArr) {
            RLMRealm *realm = RLMRealm.defaultRealm;
            [realm beginWriteTransaction];
            [realm deleteObject:inputPicBM];
            [realm commitWriteTransaction];
        }
        RLMResults *effectBMArr = [EffectBookMark objectsWhere:@"dEffect_id = %@",[NSString stringWithFormat:@"%@",_dEffect.dEffect_id]];
        for (EffectBookMark *effBM in effectBMArr) {
            RLMRealm *realm = RLMRealm.defaultRealm;
            [realm beginWriteTransaction];
            [realm deleteObject:effBM];
            [realm commitWriteTransaction];

        }
        [self.customNavigationBar.btnReload setSelected:NO];
    }else{
        EffectBookMark *effBM = [[EffectBookMark alloc]init];
        effBM.dEffect_id = _dEffect.dEffect_id;
        effBM.label = _dEffect.label;
        effBM.effectDescription = _dEffect.effectDescription;
        effBM.function = _dEffect.function;
        effBM.avatar = _dEffect.avatar;
        RLMRealm *defaultRealm = [RLMRealm defaultRealm];
        [defaultRealm beginWriteTransaction];
        [EffectBookMark createOrUpdateInRealm:defaultRealm withValue:effBM];
        [defaultRealm commitWriteTransaction];
        
        for (DInputLine *inputLine in _dEffect.input_line) {
            InputLineBookMark *inputLineBM = [[InputLineBookMark alloc]init];
            inputLineBM.idInputLine = [[NSUUID UUID] UUIDString];
            inputLineBM.dEffect_id = _dEffect.dEffect_id;
            inputLineBM.type =  inputLine.type;
            inputLineBM.title = inputLine.title;
            inputLineBM.require = inputLine.require;
            RLMRealm *defaultRealm = [RLMRealm defaultRealm];
            [defaultRealm beginWriteTransaction];
            [InputLineBookMark createOrUpdateInRealm:defaultRealm withValue:inputLineBM];
            [defaultRealm commitWriteTransaction];
        }
        
        for (DInputPic *inputPic in _dEffect.input_pic) {
            InputPicBookMark *inputPicBM = [[InputPicBookMark alloc]init];
            inputPicBM.idInputPic = [[NSUUID UUID] UUIDString];
            inputPicBM.dEffect_id = _dEffect.dEffect_id;
            inputPicBM.type =  inputPic.type;
            inputPicBM.require = inputPic.require;
            inputPicBM.width = inputPic.width;
            inputPicBM.height = inputPic.height;
            RLMRealm *defaultRealm = [RLMRealm defaultRealm];
            [defaultRealm beginWriteTransaction];
            [InputPicBookMark createOrUpdateInRealm:defaultRealm withValue:inputPicBM];
            [defaultRealm commitWriteTransaction];
        }
        [self.customNavigationBar.btnReload setSelected:YES];


    }
    
}
#pragma mark config collectionView

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.numberInputImg;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    UIButton *btnAddImage = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, heightImgAdd, heightImgAdd)];
    [btnAddImage setBackgroundImage:[UIImage imageNamed:@"addpicture.png"] forState:UIControlStateNormal];

    [btnAddImage addTarget:self action:@selector(btnAddImage:) forControlEvents:UIControlEventTouchUpInside];
    [btnAddImage setTag:(2000+indexPath.row)];
    [cell addSubview:btnAddImage];
    
////    UIImageView *imageViewBackground = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, heightImgAdd, heightImgAdd)];
////    //    [imageViewBackground setBackgroundColor:[UIColor colorWithRed:19/255.0f green:19/255.0f blue:19/255.0f alpha:1.0f]];
////    imageViewBackground.contentMode = UIViewContentModeScaleToFill;
////    [imageViewBackground setImage:[UIImage imageNamed:@"addpicture.png"]];
//    [cell addSubview:imageViewBackground];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didDeselectItemAtIndexPath:%tu",indexPath.row);
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(heightImgAdd, heightImgAdd);
}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 40, 0, 0);
//}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numberInputText;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DInputLine *inputLine = [_dEffect.input_line objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"AddTextTableViewCellIdentifier";
    
    AddTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AddTextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.lbMessage.text = [NSString stringWithFormat:@"Thông điệp %tu:",indexPath.row+1];
    cell.tvMessage.delegate = self;
    cell.tvMessage.text = inputLine.title;
    cell.tvMessage.textColor = [UIColor grayColor];
    [cell.tvMessage setTag:(3000+indexPath.row)];
    [cell.lbMessage setTextColor:MU_RGBA(108, 64, 184, 0.9)];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0f;
}


- (void)btnAddImage:(id)sender{
    if (btnAddImagePopoverController == nil)
    {
        UIView *btn = (UIView *)sender;
        tagSelected = [sender tag];
        indexImageInputSelected = tagSelected-2000;
        DialogViewController *dialogVC = [[DialogViewController alloc]initWithNibName:@"DialogViewController" bundle:nil];
        dialogVC.preferredContentSize = CGSizeMake(130, 88);
        dialogVC.delegate = self;
        dialogVC.arrDataSource = [NSArray arrayWithObjects:@"Camera",@"Library", nil];
        dialogVC.arrImageDes = [NSArray arrayWithObjects:@"camera.png",@"library.png", nil];

        dialogVC.modalInPopover = NO;
        
        UINavigationController *contentViewController = [[UINavigationController alloc] initWithRootViewController:dialogVC];
        
        btnAddImagePopoverController = [[WYPopoverController alloc] initWithContentViewController:contentViewController];
        btnAddImagePopoverController.delegate = self;
        btnAddImagePopoverController.passthroughViews = @[btn];
        btnAddImagePopoverController.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 10, 10);
        btnAddImagePopoverController.wantsDefaultContentAppearance = NO;
        
        [btnAddImagePopoverController presentPopoverFromRect:btn.bounds
                                                  inView:btn
                                permittedArrowDirections:WYPopoverArrowDirectionAny
                                                animated:YES
                                                 options:WYPopoverAnimationOptionFadeWithScale];
    }
    else
    {
        [self close:nil];
    }
}

#pragma mark implement WYPopoverControllerDelegate
- (void)close:(id)sender
{
    
    [btnAddImagePopoverController dismissPopoverAnimated:YES completion:^{
        [self popoverControllerDidDismissPopover:btnAddImagePopoverController];
    }];
}
#pragma mark - WYPopoverControllerDelegate

- (void)popoverControllerDidPresentPopover:(WYPopoverController *)controller
{
    NSLog(@"popoverControllerDidPresentPopover");
}

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    //    if (controller == anotherPopoverController)
    //    {
    //        anotherPopoverController.delegate = nil;
    //        anotherPopoverController = nil;
    //    }
    //    else
    if (controller == btnAddImagePopoverController)
    {
        btnAddImagePopoverController.delegate = nil;
        btnAddImagePopoverController = nil;
    }
}

- (BOOL)popoverControllerShouldIgnoreKeyboardBounds:(WYPopoverController *)popoverController
{
    return YES;
}

- (void)popoverController:(WYPopoverController *)popoverController willTranslatePopoverWithYOffset:(float *)value
{
    // keyboard is shown and the popover will be moved up by 163 pixels for example ( *value = 163 )
    *value = 0; // set value to 0 if you want to avoid the popover to be moved
}

#pragma mark implement dialogDelegate
-(void)dialogViewController:(DialogViewController *)dialogVC selectIndex:(NSInteger)index{
    [self close:nil];
    indexSelectDialog = index;
    if (index==0) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                  message:@"Device has no camera"
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles: nil];
            
            [myAlertView show];
            
        }else{
            _imagePickerController = [[UIImagePickerController alloc] init];
            _imagePickerController.delegate = self;
            _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:_imagePickerController animated:YES completion:nil];
            //                _indexOfPicture = [button tag];
        }
    }else if(index == 1){
        
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }
}

#pragma mark implement pickerImage
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    imagePicker = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    if (!imagePicker) {
        NSLog(@"Không lấy được ảnh");
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"đã lấy được ảnh");
            DInputPic *dInputPic = [_dEffect.input_pic objectAtIndex:indexImageInputSelected];
            
            cropImageVC = [[CropImageViewController alloc]initWithNibName:@"CropImageViewController" bundle:nil];
            cropImageVC.imageTest = imagePicker;
            cropImageVC.sizeWidth = [dInputPic.width floatValue];
            cropImageVC.sizeHeight = [dInputPic.height floatValue];
            cropImageVC.tagImage = tagSelected;
            cropImageVC.delegate = self;
            UINavigationController *navigationCropImg = [[UINavigationController alloc]initWithRootViewController:cropImageVC];
            [self.navigationController presentViewController:navigationCropImg animated:YES completion:nil];
        }];
    }
    
    
}

#pragma mark implement cropImageVC
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    [[self navigationController] dismissViewControllerAnimated:NO completion:nil];
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.check = false;
    
}

- (void)cropImageButtonDonePress:(CropImageViewController*)cropImageVC image:(UIImage *)image tag:(NSInteger)tag{
    NSLog(@"cropImageButtonDonePress:%f:%f:%@",image.size.width,image.size.height,image);
    [arrImage replaceObjectAtIndex:tag-2000 withObject:image];
    UIButton *button = (UIButton *) [self.collectionViewAddImage viewWithTag:tag];
    [button setBackgroundImage:image forState:UIControlStateNormal];
}

//
- (void)_keyboardWillShowNotification:(NSNotification*)notification{
//    CGFloat hightOfset  = imageView.frame.size.height+70+self.addImageView.frame.size.height+indexTextViewChanging*75;
//    CGFloat hightOfset =  [sender.superview convertRect:sender.frame toView:self.view];
//    [self.scrollView setContentOffset:CGPointMake(0, hightOfset) animated:YES];
//    [self.scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, imageView.frame.size.height+200+self.addImageView.frame.size.height+numberInputText*80+215)];
}

- (void)_keyboardWillHideNotification:(NSNotification*)notification{
    [self.scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width,imageView.frame.size.height+200+self.addImageView.frame.size.height+numberInputText*80)];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    indexTextViewChanging = textView.tag-3000;
    DInputLine *inputLine = [_dEffect.input_line objectAtIndex:indexTextViewChanging];
    if ([textView.text isEqualToString:inputLine.title]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }

    CGFloat hightOfset  = [textView.superview convertRect:textView.frame toView:self.scrollView].origin.y-30 ;

    [self.scrollView setContentOffset:CGPointMake(0, hightOfset) animated:YES];
    [self.scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, hightOfset+[UIScreen mainScreen].bounds.size.height)];

    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    indexTextViewChanging = textView.tag-3000;
    DInputLine *inputLine = [_dEffect.input_line objectAtIndex:indexTextViewChanging];
    if ([textView.text isEqualToString:@""]) {
        textView.text = inputLine.title;
        textView.textColor = [UIColor grayColor];
    }
    return YES;
}

#pragma mark config keyboard

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        indexTextViewChanging = textView.tag-3000;
        if (indexTextViewChanging <numberInputText-1) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexTextViewChanging+1 inSection:0];
            UITableViewCell *cell = [self.tableViewAddText cellForRowAtIndexPath:indexPath];
            UITextView *textView1 =(UITextView *)[cell viewWithTag:indexTextViewChanging+3001];
            [textView1 becomeFirstResponder];
        }else{
            [textView resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}


#pragma mark implement MessageDelegate
-(void)messageOkPress:(MessageViewController *)messageVC{
    [Helper removeDialogViewController:self];
}

@end
