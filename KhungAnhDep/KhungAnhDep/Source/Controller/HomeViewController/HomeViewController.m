//
//  HomeViewController.m
//  KhungAnhDep
//
//  Created by DatDV on 4/5/16.
//  Copyright (c) 2016 dd. All rights reserved.
//

#import "HomeViewController.h"
#import "NewViewController.h"
#import "WallpaperViewController.h"
#import "BookMarkViewController.h"
#import "ToolViewController.h"

@interface HomeViewController ()

@property (nonatomic) NSInteger indexPendingView;
@property (nonatomic) int indexDayInArr; //chỉ số để hiển tính view thứ mấy được hiển thị

@property (weak, nonatomic) IBOutlet UIButton *btnTabNew;
@property (weak, nonatomic) IBOutlet UIButton *btnTabBookMark;
@property (weak, nonatomic) IBOutlet UIButton *btnTabWallPaper;
@property (weak, nonatomic) IBOutlet UIButton *btnTabTool;

@end

@implementation HomeViewController

static HomeViewController *sharedInstance;

+ (HomeViewController *)sharedInstance {
    if (sharedInstance) {
        return sharedInstance;
    }
    
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES];
    SWRevealViewController *revealController = [self revealViewController];
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    //custom navigationbar
    [self.customNavigationBar.btnMenu addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavigationBar.lbTitle setText:@"Home"];
    [self.customNavigationBar.lbTitle setFont:[UIFont fontWithName:@"Roboto-Medium" size:22]];
    [self.customNavigationBar.btnReload addTarget:self action:@selector(btnReload:) forControlEvents:UIControlEventTouchUpInside];
//    [self.customNavigationBar.btnBookMark setHidden:YES];
//    [self.customNavigationBar.btnReload setHidden:YES];
    [self configTabbar];
    
    self.indexDayInArr = 0;
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    self.pageController.view.translatesAutoresizingMaskIntoConstraints = NO;

//    [[self.pageController view] setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-85)];
    [self.pageController.view setBackgroundColor:VIEW_COLOR];
    
    NewViewController *initialViewController = [[NewViewController alloc]initWithNibName:@"NewViewController" bundle:nil];
    
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    [self.btnTabNew setSelected:YES];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:self.pageController];
    [self.viewContain addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    [self addConstraint];


}
-(void)addConstraint{
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.pageController.view
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.viewContain
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.pageController.view
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.viewContain
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.pageController.view
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.viewContain
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.pageController.view
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.viewContain
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];

}

-(void)configTabbar{
    [self.btnTabNew setBackgroundImage:[Helper imageWithColor:NAVIGATIONBAR_COLOR] forState:UIControlStateNormal];
    [self.btnTabNew setBackgroundImage:[Helper imageWithColor:SELECTED_COLOR] forState:UIControlStateSelected];
    [self.btnTabNew addTarget:self action:@selector(btnTabNew:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnTabBookMark setBackgroundImage:[Helper imageWithColor:NAVIGATIONBAR_COLOR] forState:UIControlStateNormal];
    [self.btnTabBookMark setBackgroundImage:[Helper imageWithColor:SELECTED_COLOR] forState:UIControlStateSelected];
    [self.btnTabBookMark addTarget:self action:@selector(btnTabBookMark:) forControlEvents:UIControlEventTouchUpInside];

    [self.btnTabWallPaper setBackgroundImage:[Helper imageWithColor:NAVIGATIONBAR_COLOR] forState:UIControlStateNormal];
    [self.btnTabWallPaper setBackgroundImage:[Helper imageWithColor:SELECTED_COLOR] forState:UIControlStateSelected];
    [self.btnTabWallPaper addTarget:self action:@selector(btnTabWallPaper:) forControlEvents:UIControlEventTouchUpInside];

    [self.btnTabTool setBackgroundImage:[Helper imageWithColor:NAVIGATIONBAR_COLOR] forState:UIControlStateNormal];
    [self.btnTabTool setBackgroundImage:[Helper imageWithColor:SELECTED_COLOR] forState:UIControlStateSelected];
    [self.btnTabTool addTarget:self action:@selector(btnTabTool:) forControlEvents:UIControlEventTouchUpInside];


}

- (void)selectViewInPageAtIndex:(NSInteger )index{
    
    NSInteger indexPageCurrent = 0;
    if ([[self.pageController.viewControllers firstObject] isKindOfClass:[NewViewController class]]) {
        indexPageCurrent = 0;
    }else if ([[self.pageController.viewControllers firstObject] isKindOfClass:[BookMarkViewController class]]){
        indexPageCurrent = 1;
    }else if ([[self.pageController.viewControllers firstObject] isKindOfClass:[WallpaperViewController class]]){
        indexPageCurrent = 2;
    }else if ([[self.pageController.viewControllers firstObject] isKindOfClass:[ToolViewController class]]){
        indexPageCurrent = 3;
    }
    
    if (index == 0) {
        NewViewController *newVC = [[NewViewController alloc]initWithNibName:@"NewViewController" bundle:nil];
        [self.pageController setViewControllers:@[newVC]
                                      direction:UIPageViewControllerNavigationDirectionReverse
                                       animated:YES
                                     completion:nil];

    }else if (index == 1){
        BookMarkViewController *bookMarkVC = [[BookMarkViewController alloc]initWithNibName:@"BookMarkViewController" bundle:nil];

        if (indexPageCurrent >index) {
            [self.pageController setViewControllers:@[bookMarkVC]
                                          direction:UIPageViewControllerNavigationDirectionReverse
                                           animated:YES
                                         completion:nil];

        }else if (indexPageCurrent <index){
            [self.pageController setViewControllers:@[bookMarkVC]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:YES
                                         completion:nil];

        }
        
 
    }else if (index == 2){
        WallpaperViewController *wallPaperVC = [[WallpaperViewController alloc]initWithNibName:@"WallpaperViewController" bundle:nil];
        if (indexPageCurrent >index) {
            [self.pageController setViewControllers:@[wallPaperVC]
                                          direction:UIPageViewControllerNavigationDirectionReverse
                                           animated:YES
                                         completion:nil];
            
        }else if (indexPageCurrent <index){
            [self.pageController setViewControllers:@[wallPaperVC]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:YES
                                         completion:nil];
            
        }
    }else if (index == 3){
        ToolViewController *toolVC = [[ToolViewController alloc]initWithNibName:@"ToolViewController" bundle:nil];

        [self.pageController setViewControllers:@[toolVC]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[NewViewController class]]) {
        return nil;
    }else if ([viewController isKindOfClass:[BookMarkViewController class]]){
        return [[NewViewController alloc] initWithNibName:@"NewViewController" bundle:nil];
    }else if ([viewController isKindOfClass:[WallpaperViewController class]]){
        return [[BookMarkViewController alloc] initWithNibName:@"BookMarkViewController" bundle:nil];
    }else if ([viewController isKindOfClass:[ToolViewController class]]){
        return [[BookMarkViewController alloc] initWithNibName:@"BookMarkViewController" bundle:nil];
    }
    return nil;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[NewViewController class]]) {
        return [[BookMarkViewController alloc] initWithNibName:@"BookMarkViewController" bundle:nil];
    }else if ([viewController isKindOfClass:[BookMarkViewController class]]){
        return [[WallpaperViewController alloc] initWithNibName:@"WallpaperViewController" bundle:nil];
    }else if ([viewController isKindOfClass:[WallpaperViewController class]]){
        return [[ToolViewController alloc] initWithNibName:@"ToolViewController" bundle:nil];
    }else if ([viewController isKindOfClass:[ToolViewController class]]){
        return nil;
    }
    return nil;
    
}

//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
//    int currentPage = [(DailyViewController *)[pageViewController.viewControllers objectAtIndex:0] index];
//    return currentPage;
//}

//- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers{

    if ([[pendingViewControllers lastObject] isKindOfClass:[NewViewController class]]) {
        self.indexPendingView = 0;

    }else if ([[pendingViewControllers lastObject] isKindOfClass:[BookMarkViewController class]]){
        self.indexPendingView = 1;

    }else if ([[pendingViewControllers lastObject] isKindOfClass:[WallpaperViewController class]]){
        self.indexPendingView = 2;

    }else if ([[pendingViewControllers lastObject] isKindOfClass:[ToolViewController class]]){
        self.indexPendingView = 3;
        
    }
}

// Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
//- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{

    if (completed) {
        if ([[previousViewControllers firstObject] isKindOfClass:[NewViewController class]]) {
            if (self.indexPendingView > 0) {
                NSLog(@"selected bookmark");
                [self.btnTabBookMark setSelected:YES];
                [self.btnTabWallPaper setSelected:NO];
                [self.btnTabNew setSelected:NO];
                [self.btnTabTool setSelected:NO];

            }
        }else if ([[previousViewControllers firstObject] isKindOfClass:[BookMarkViewController class]]){
            if (self.indexPendingView > 1) {
                NSLog(@"selected paper");
                [self.btnTabBookMark setSelected:NO];
                [self.btnTabWallPaper setSelected:YES];
                [self.btnTabNew setSelected:NO];
                [self.btnTabTool setSelected:NO];

            }else{
                NSLog(@"selected newview");
                [self.btnTabBookMark setSelected:NO];
                [self.btnTabWallPaper setSelected:NO];
                [self.btnTabNew setSelected:YES];
                [self.btnTabTool setSelected:NO];

            }
        }else if ([[previousViewControllers firstObject] isKindOfClass:[WallpaperViewController class]]){
            if (self.indexPendingView < 2) {
                NSLog(@"selected bookmark");
                [self.btnTabBookMark setSelected:YES];
                [self.btnTabWallPaper setSelected:NO];
                [self.btnTabNew setSelected:NO];
                [self.btnTabTool setSelected:NO];

            }else{
                NSLog(@"selected tool");
                [self.btnTabBookMark setSelected:NO];
                [self.btnTabWallPaper setSelected:NO];
                [self.btnTabNew setSelected:NO];
                [self.btnTabTool setSelected:YES];


            }
        }else if ([[previousViewControllers firstObject] isKindOfClass:[ToolViewController class]]){
            if (self.indexPendingView < 3) {
                NSLog(@"selected paper");
                [self.btnTabBookMark setSelected:NO];
                [self.btnTabWallPaper setSelected:YES];
                [self.btnTabNew setSelected:NO];
                [self.btnTabTool setSelected:NO];

            }
        }
    }
    
}


#pragma mark event button in tabbar
- (void)btnTabNew:(id)sender{
    if (!self.btnTabNew.selected) {
        [self.btnTabNew setSelected:YES];
        [self selectViewInPageAtIndex:0];
        
    }
    [self.btnTabBookMark setSelected:NO];
    [self.btnTabWallPaper setSelected:NO];
    [self.btnTabTool setSelected:NO];

}
- (void)btnTabBookMark:(id)sender{
    if (!self.btnTabBookMark.selected) {
        [self.btnTabBookMark setSelected:YES];
        [self selectViewInPageAtIndex:1];

    }
    [self.btnTabNew setSelected:NO];
    [self.btnTabWallPaper setSelected:NO];
    [self.btnTabTool setSelected:NO];
}
- (void)btnTabWallPaper:(id)sender{
    if (!self.btnTabWallPaper.selected) {
        [self.btnTabWallPaper setSelected:YES];
        [self selectViewInPageAtIndex:2];

    }
    [self.btnTabBookMark setSelected:NO];
    [self.btnTabNew setSelected:NO];
    [self.btnTabTool setSelected:NO];
}
- (void)btnTabTool:(id)sender{
    if (!self.btnTabTool.selected) {
        [self.btnTabTool setSelected:YES];
        [self selectViewInPageAtIndex:3];

    }
    [self.btnTabBookMark setSelected:NO];
    [self.btnTabWallPaper setSelected:NO];
    [self.btnTabNew setSelected:NO];
}
@end
