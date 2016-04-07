//
//  ToolViewController.h
//  KhungAnhDep
//
//  Created by Doan Dat on 4/5/16.
//  Copyright © 2016 dd. All rights reserved.
//

#import "BaseViewController.h"

@interface ToolViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *btnPickImage;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
