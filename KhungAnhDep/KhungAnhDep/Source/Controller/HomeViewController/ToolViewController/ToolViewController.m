//
//  ToolViewController.m
//  KhungAnhDep
//
//  Created by Doan Dat on 4/5/16.
//  Copyright © 2016 dd. All rights reserved.
//

#import "ToolViewController.h"
#import "WYPopoverController.h"
#import "DialogViewController.h"
#import "CropImageViewController.h"

@interface ToolViewController ()<WYPopoverControllerDelegate,DialogViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    WYPopoverController *btnAddImagePopoverController;
    NSInteger indexSelectDialog;

}
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) UIImage *imagePicker;

@end

@implementation ToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.btnPickImage addTarget:self action:@selector(btnAddImage:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnAddImage:(id)sender{
    if (btnAddImagePopoverController == nil)
    {
        UIView *btn = (UIView *)sender;
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
    self.imagePicker = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    if (!self.imagePicker) {
        NSLog(@"Không lấy được ảnh");
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"đã lấy được ảnh");
            [self.imageView setImage:self.imagePicker];
            
        }];
    }
    
    
}


@end
