//
//  Cropper.m
//  Crop
//
//  Created by Franco Santa Cruz on 2/6/15.
//  Copyright (c) 2015 BirdMaker. All rights reserved.
//

#import "Cropper.h"

typedef enum : NSUInteger {
    PanStateNone,
    PanStateMoving,
    PanStateChangingSize,
} PanState;

typedef enum : NSUInteger {
    None,
    Left = 1 << 0,
    Top = 1 << 1,
    Right = 1 << 2,
    Bottom = 1 << 3,
} ResizingState;


@interface Cropper ()

@property (assign, nonatomic) CGRect croppingRect;
@property (assign, nonatomic) CGPoint lastDistance;
@property (assign, nonatomic) CGPoint lastDistancePan;
@property (strong, nonatomic) UIView *bar;
@property (strong, nonatomic) UIImageView *imageView;

@property (nonatomic, assign) PanState panState;
@property (nonatomic, assign) ResizingState resizingState;


@end

@implementation UIImageView (util)

-(CGRect)cropRectForFrame:(CGRect)frame
{
//    NSAssert(self.contentMode == UIViewContentModeScaleAspectFit, @"content mode must be aspect fit");
    
    CGFloat widthScale = self.bounds.size.width / self.image.size.width;
    CGFloat heightScale = self.bounds.size.height / self.image.size.height;
    
    float x, y, w, h, offset;
    if (widthScale<heightScale) {
        offset = (self.bounds.size.height - (self.image.size.height*widthScale))/2;
        x = frame.origin.x / widthScale;
        y = (frame.origin.y-offset) / widthScale;
        w = frame.size.width / widthScale;
        h = frame.size.height / widthScale;
    } else {
        offset = (self.bounds.size.width - (self.image.size.width*heightScale))/2;
        x = (frame.origin.x-offset) / heightScale;
        y = frame.origin.y / heightScale;
        w = frame.size.width / heightScale;
        h = frame.size.height / heightScale;
    }
    //////////NSLog(@"cropRectForFrame: %f,%f,%f,%f",x,y,w,h);
    return CGRectMake(x, y, w, h);
}

@end

@implementation Cropper
CGFloat width;
CGFloat height;
- (instancetype)initWithImageView:(UIImageView*)imageView InitialCroppingRect:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h
{
//    CGFloat widthBounds = self.frame.size.width;
    //NSLog(@"widthBounds aaa: %f",widthBounds);
    width = w;
    height = h;
    [imageView setNeedsLayout];
    [imageView layoutIfNeeded];
    self = [super initWithFrame:imageView.frame];
    if (self) {
        self.imageView = imageView;
        [self setupInitialCroppingRect:x y:y w:w h:h];

        [self setBackgroundColor:[UIColor clearColor]];
        self.userInteractionEnabled = YES;
        self.multipleTouchEnabled = YES;
        [self addGestures];
        
        UIView *sup = [imageView superview];
        [self addViewToHierarchy:imageView parent:sup];
        
    }
    return self;
}

- (UIImage*)image
{
    return self.imageView.image;
}

// add contraints so the view is always align with imageview
- (void)addViewToHierarchy:(UIImageView*)imageView parent:(UIView*)sup
{
    //add
    [sup addSubview:self];
    
    // add contraints so the view is always align with imageview
    //
    // left
    [sup addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    // right
    [sup addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    // top
    [sup addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    // bottom
    [sup addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
}

- (void)cancel:(id)sender
{
    if( self.cropAction )
    {
        self.cropAction(CropperActionCancel, nil);
//        [self finishCropper];
//        [self.navigationController popViewControllerAnimated:YES];
        
        
        ////NSLog(@"cancel crop");
    }
}

- (void)crop:(id)sender
{
    if( self.cropAction )
    {
        UIImage *image = [self generateCroppedImage];
        self.cropAction(CropperActionDidCrop, image);
        [self finishCropper];
    }
}

- (void)finishCropper
{
    [self removeFromSuperview];
}

- (void)setupInitialCroppingRect: (CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h
{
    CGFloat w1 = w;
    CGFloat h1 = h;
    CGFloat x1 = 0;
    CGFloat y1 = 0;
    CGFloat scaleWHCrop = w/h;
    CGFloat scaleWHImg = self.frame.size.width/self.frame.size.height;
    
    // set
    if (self.frame.size.width>self.frame.size.height)
    {
        if (scaleWHImg>scaleWHCrop)
        {
            h1 = self.frame.size.height-40;
            w1 = h1*w/h;
        }else
        {
            w1 = self.frame.size.width-40;
            h1 = w1*h/w;
        }
//        h1 = self.frame.size.height-40;
//        w1 = h1*w/h;
    }else
    {
        if (scaleWHImg<scaleWHCrop)
        {
            w1 = self.frame.size.width-40;
            h1 = w1*h/w;
            
        }else
        {
            h1 = self.frame.size.height-40;
            w1 = h1*w/h;
        }
//        w1 = self.frame.size.width-40;
//        h1 = w1*h/w;
    }
//    if ((x+w)>self.frame.size.width) {
//        x1 = 0;
//        w1 = self.frame.size.width;
//        h1 = w1*h/w;
//    }
//    if ((y+h)>self.frame.size.height) {
//        y1 = 0;
//        h1 = self.frame.size.height;
//        w1 = h1*w/h;
//    }
    x1 = (self.frame.size.width-w1)/2;
    y1 = (self.frame.size.height-h1)/2;
    self.croppingRect = CGRectMake(x1, y1, w1, h1);
    // invalidate view so initial rect gets drawn
    [self setNeedsDisplay];
}


- (UIImage*)generateCroppedImage
{
    CGRect rect = [self.imageView cropRectForFrame:self.croppingRect];
    // begin
    UIGraphicsBeginImageContext(rect.size);
    // translated rectangle for drawing sub image
    CGRect drawRect = CGRectMake(-rect.origin.x, -rect.origin.y, self.image.size.width, self.image.size.height);
    //////////NSLog(@"%f -- %f width image %f, hight image %f",-rect.origin.x, -rect.origin.y, self.image.size.width, self.image.size.height);
    // draw image
    [self.image drawInRect:drawRect];
    // grab image
    UIImage* croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    // end
    UIGraphicsEndImageContext();
    //////////NSLog(@"width image %f, hight image %f", drawRect.size.width ,drawRect.size.height);
    return croppedImage;
}


- (void)addGestures
{
    // create pinch
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    // add
    [self addGestureRecognizer:
        pinch
     ];
    
    // create & configure pan
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.maximumNumberOfTouches = 1;
    pan.minimumNumberOfTouches = 1;
    ////NSLog(@"maximumNumberOfTouches minimumNumberOfTouches ");
    // add pan
    [self addGestureRecognizer:pan];
    
    [pinch addTarget:self action:@selector(genericGesture:)];
    [pan addTarget:self action:@selector(genericGesture:)];
}

#pragma mark - Gestures

- (void)genericGesture:(UIGestureRecognizer*)gesture
{
    CGFloat duration = 0.1;
    if( gesture.state == UIGestureRecognizerStateBegan )
    {
        ////NSLog(@"UIGestureRecognizerStateBegan");
        [UIView animateWithDuration:duration animations:^{
            [self.bar setAlpha:0];
        }];
    }
    else if( gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateFailed || gesture.state == UIGestureRecognizerStateCancelled )
    {
        ////NSLog(@"else UIGestureRecognizerStateBegan");
        [UIView animateWithDuration:duration animations:^{
            [self.bar setAlpha:1];
        }];
    }
}

- (void)printState:(UIGestureRecognizer*)g
{
    ////NSLog(@"printState");
//    id array = @{
//                 
//                 @(UIGestureRecognizerStatePossible):@"Possible",
//                 
//                 @(UIGestureRecognizerStateBegan):@"Began",
//                 @(UIGestureRecognizerStateChanged):@"Changed",
//                 @(UIGestureRecognizerStateEnded):@"Ended",
//                 @(UIGestureRecognizerStateCancelled):@"Cancelled",
//                 @(UIGestureRecognizerStateFailed):@"Failed",
//                 @(UIGestureRecognizerStateRecognized):@"Recognized",
//                 };
    //////////NSLog(@"g = %@, state = %@",[g class], array[@(g.state)]);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [touches arra]
    if( touches.count != 1 ){
        return;
    }

    CGFloat padding2 = 10;
    UITouch *touch = [touches.objectEnumerator nextObject];
    CGPoint point = [touch locationInView:self];
//    CGRect left = CGRectMake(_croppingRect.origin.x-padding2,
//                             _croppingRect.origin.y+cornerPadding,
//                             padding2*2,
//                             _croppingRect.size.height-(cornerPadding*2));
//    CGRect top = CGRectMake(_croppingRect.origin.x + cornerPadding,
//                            _croppingRect.origin.y - padding2,
//                            _croppingRect.size.width - (cornerPadding*2),
//                            padding2*2);
//    CGRect right = CGRectMake(_croppingRect.origin.x + _croppingRect.size.width - padding2,
//                              _croppingRect.origin.y - cornerPadding,
//                              padding2*2,
//                              _croppingRect.size.height - (cornerPadding*2));
//    CGRect bottom = CGRectMake(_croppingRect.origin.x + cornerPadding,
//                               _croppingRect.origin.y + _croppingRect.size.height - padding2,
//                               _croppingRect.size.width - (cornerPadding*2),
//                               padding2*2);
    CGRect left = CGRectMake(0,
                             0,
                             _croppingRect.origin.x + padding2,
                             self.frame.size.height);
    CGRect top = CGRectMake(0,
                            0,
                            self.frame.size.width,
                            _croppingRect.origin.y + padding2);
    CGRect right = CGRectMake(_croppingRect.origin.x + _croppingRect.size.width - padding2,
                              0,
                              self.frame.size.width,
                              self.frame.size.height);
    CGRect bottom = CGRectMake(0,
                               _croppingRect.origin.y + _croppingRect.size.height - padding2,
                               self.frame.size.width,
                               self.frame.size.height);

    
    if( CGRectContainsPoint(left, point) )
    {
        _resizingState |= Left;
    }
    if( CGRectContainsPoint(top, point) )
    {
        _resizingState |= Top;
    }
    if( CGRectContainsPoint(right, point) )
    {
        _resizingState |= Right;
    }
    if( CGRectContainsPoint(bottom, point) )
    {
        _resizingState |= Bottom;
    }
//    else
//    {
//        CGRect leftCorner = CGRectMake(_croppingRect.origin.x - cornerPadding, _croppingRect.origin.y - cornerPadding, cornerPadding, cornerPadding);
//        
//    }

}

- (void)pan:(UIPanGestureRecognizer*)pan
{
//    [self printState:pan];
    if( pan.state == UIGestureRecognizerStateEnded || !pan.numberOfTouches )
    {
        ////NSLog(@"UIGestureRecognizerStateEnded and !pan.numberOfTouches");
        _panState = PanStateNone;
        _resizingState = None;
        return;
    }
    CGFloat padding = 5;
//    CGFloat padding2 = 5;
    CGPoint point = [pan locationOfTouch:0 inView:self];
    if( pan.state == UIGestureRecognizerStateBegan ){
        if( _resizingState != None ){
            //////////NSLog(@"PanStateChangingSize");
            _panState = PanStateChangingSize;
            // resizing, no op
        } else if( CGRectContainsPoint(CGRectMake(_croppingRect.origin.x+padding, _croppingRect.origin.y+padding, _croppingRect.size.width-(padding*2), _croppingRect.size.height-(padding*2)), point) ){
            // moving
            //////////NSLog(@"PanStateMoving");
            _panState = PanStateMoving;
        } else {
            //////////NSLog(@"PanStateNone");
            _panState = PanStateNone;
            _resizingState = None;
            // cancel
            [pan setEnabled:NO];
            [pan setEnabled:YES];
            return;
        }
    }

    if( pan.state == UIGestureRecognizerStateChanged )
    {

        if( _panState == PanStateMoving ){
            // x
            _croppingRect.origin.x += (point.x-_lastDistancePan.x);
            // x checks
            _croppingRect.origin.x = _croppingRect.origin.x < 0 ? 0 : _croppingRect.origin.x;
            _croppingRect.origin.x = CGRectGetMaxX(_croppingRect) > self.bounds.size.width ? self.bounds.size.width - _croppingRect.size.width : _croppingRect.origin.x;
            
            // y
            _croppingRect.origin.y += (point.y-_lastDistancePan.y);
            // y checks
            _croppingRect.origin.y = _croppingRect.origin.y < 0 ? 0 : _croppingRect.origin.y;
            _croppingRect.origin.y = CGRectGetMaxY(_croppingRect) > self.bounds.size.height ? self.bounds.size.height - _croppingRect.size.height : _croppingRect.origin.y;
        } else if( _panState == PanStateChangingSize ){
            //tính tỷ lệ w/h
            if (_croppingRect.size.height>0) {
                CGFloat ratio = _croppingRect.size.width/_croppingRect.size.height;
                CGFloat distance;
                
                if( (_resizingState&Left) ){
                    
                    distance = _lastDistancePan.x - point.x;
                    if ((-distance)>=_croppingRect.size.width-10) {
                        distance = 0;
                    }
                    _croppingRect.origin.x -= distance;
                    if (_croppingRect.origin.x < 0) {
                        distance = distance + _croppingRect.origin.x;
                        ////NSLog(@"distance 1: %f",distance);
                        _croppingRect.origin.x = 0;
                        
                    }
                    _croppingRect.origin.y -= distance;
                    if ((_croppingRect.origin.y < 0)& (distance!=0)) {
                        distance += _croppingRect.origin.y;
                        ////NSLog(@"distance 2: %f",distance);
                        _croppingRect.origin.y = 0;
                    }
                    _croppingRect.size.height += distance;
                    
                    _croppingRect.size.width = _croppingRect.size.height*ratio;
                    
                }
                
                if( (_resizingState&Top) ){
                    distance = _lastDistancePan.y - point.y;
                    if ((-distance)>=_croppingRect.size.height-10) {
                        distance = 0;
                    }
                    _croppingRect.origin.y -= distance;
                    if ((_croppingRect.origin.y < 0)&(distance!=0)) {
                        distance += _croppingRect.origin.y;
                        ////NSLog(@"distance 2: %f",distance);
                        _croppingRect.origin.y = 0;
                    }
                    
                    _croppingRect.origin.x -= distance;
                    if ((_croppingRect.origin.x < 0) &(distance!=0)) {
                        ////NSLog(@"distance: %f",distance);
                        distance = distance + _croppingRect.origin.x;
                        ////NSLog(@"distance 1: %f",distance);
                        _croppingRect.origin.x = 0;
                        
                    }
                    _croppingRect.size.height += distance;
                    _croppingRect.size.width = _croppingRect.size.height*ratio;
                }
                
                if( (_resizingState&Right) ){
                    if (CGRectGetMaxX(_croppingRect) > self.bounds.size.width) {
                        distance = 0;
                    }else{
                        distance = _lastDistancePan.x - point.x;
                        if (distance>=_croppingRect.size.width-10) {
                            distance =0;
                        }
                    }
                    if(CGRectGetMaxY(_croppingRect) > self.bounds.size.height) {
                        distance = 0;
                    }
                    
                    _croppingRect.size.height -= distance;
                    _croppingRect.size.width = _croppingRect.size.height*ratio;
                }
                if( (_resizingState&Bottom) ){
                    if (CGRectGetMaxY(_croppingRect) > self.bounds.size.height) {
                        ////NSLog(@"CGRectGetMaxy");
                        distance = 0;
                    }else{
                        distance = _lastDistancePan.y - point.y;
                        ////NSLog(@"No CGRectGetMaxY");
                        if (distance>=_croppingRect.size.height-10) {
                            distance =0;
                        }
                    }
                    if (CGRectGetMaxX(_croppingRect) > self.bounds.size.width) {
                        distance = 0;
                        ////NSLog(@"CGRectGetMaxX");
                    }
                    
                    _croppingRect.size.height -= distance;
                    _croppingRect.size.width = _croppingRect.size.height*ratio;
                    
                }

            }
            
        }
        // make redraw happen
        [self setNeedsDisplay];

    }
    // advance last distance
    _lastDistancePan = point;

    
 
}

- (void)pinch:(UIPinchGestureRecognizer*)pinch
{
    if( pinch.state == UIGestureRecognizerStateEnded || [pinch numberOfTouches] != 2 )
    {
        ////NSLog(@"UIGestureRecognizerStateEnded numberOfTouches");
        return;
    }
    
    // get points
    CGPoint point1 = [pinch locationOfTouch:0 inView:self];
    CGPoint point2 = [pinch locationOfTouch:1 inView:self];
    // calc diff
    int xDiff = fabs(point1.x-point2.x);
    int yDiff = fabs(point1.y-point2.y);
    
    if( pinch.state == UIGestureRecognizerStateChanged )
    {
        [self growWidth:(xDiff-_lastDistance.x)];
        [self growHeight:(yDiff-_lastDistance.y)];
        [self setNeedsDisplay];
    }
    
    _lastDistance.x = xDiff;
    _lastDistance.y = yDiff;
    
}

#pragma mark - Helper



- (void)growWidth:(int)distance
{
    if (CGRectGetMaxY(_croppingRect) > self.bounds.size.height) {
        ////NSLog(@"CGRectGetMaxy");
        distance = 0;
    }
    if (CGRectGetMaxX(_croppingRect) > self.bounds.size.width) {
        distance = 0;
        ////NSLog(@"CGRectGetMaxX");
    }
    _croppingRect.origin.x -= (distance/3.0);
    _croppingRect.size.width += (distance*2.0/3.0);
    // checks
    _croppingRect.origin.x = _croppingRect.origin.x < 0 ? 0 : _croppingRect.origin.x;
    _croppingRect.size.width = _croppingRect.size.width < 20 ? 20 : _croppingRect.size.width;
    
    
    _croppingRect.size.width = _croppingRect.size.width > self.bounds.size.width ? self.bounds.size.width : _croppingRect.size.width;
    _croppingRect.size.height = _croppingRect.size.width*height/width;
}

- (void)growHeight:(int)distance
{
    if (CGRectGetMaxY(_croppingRect) > self.bounds.size.height) {
        //////NSLog(@"CGRectGetMaxy");
        distance = 0;
    }
    if (CGRectGetMaxX(_croppingRect) > self.bounds.size.width) {
        distance = 0;
        //////NSLog(@"CGRectGetMaxX");
    }
    _croppingRect.origin.y -= (distance/3.0);
    _croppingRect.size.height += (distance*2.0/3.0);
    // checks
    _croppingRect.origin.y = _croppingRect.origin.y < 0 ? 0 : _croppingRect.origin.y;
    _croppingRect.size.height = _croppingRect.size.height < 20 ? 20 : _croppingRect.size.height;
    _croppingRect.size.height = _croppingRect.size.height > self.bounds.size.height ? self.bounds.size.height : _croppingRect.size.height;
    _croppingRect.size.width = _croppingRect.size.height*width/height;
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6].CGColor);
    // fill bkg with black transparent
    CGContextSetLineWidth(context, 5.0);
//    CGRect border = CGRectInset(self.bounds, 20, 20);
    CGContextFillRect(context, self.bounds);
//    CGContextFillRect(c, border);
    
    // set clear the cropping rect
    CGContextClearRect(context, self.croppingRect);

    // set cropping rect border
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1].CGColor);
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor);

    CGContextStrokeRect(context, self.croppingRect);
    
    CGFloat minHeightToShow = 100;
    UIColor *horizColor = [UIColor colorWithWhite:1 alpha:(self.croppingRect.size.height/minHeightToShow)-0.5];
    // draw lines
    // horizontal
    CGContextSetLineWidth(context, 1.0);
    CGFloat yPart = self.croppingRect.size.height/3;
    CGFloat yLine;
    yLine = self.croppingRect.origin.y + yPart;

    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.croppingRect.origin.x,  yLine);
    CGContextAddLineToPoint(context, self.croppingRect.origin.x + self.croppingRect.size.width, yLine);
    CGContextSetStrokeColorWithColor(context, horizColor.CGColor);
    CGContextStrokePath(context);
    
    yLine = self.croppingRect.origin.y + (yPart * 2);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.croppingRect.origin.x, yLine);
    CGContextAddLineToPoint(context, self.croppingRect.origin.x + self.croppingRect.size.width, yLine);
    CGContextSetStrokeColorWithColor(context, horizColor.CGColor);
    CGContextStrokePath(context);

    CGFloat minWidthToShow = 100;
    UIColor *vertColor = [UIColor colorWithWhite:1 alpha:(self.croppingRect.size.width/minWidthToShow)-0.5];

    // vertical
    CGFloat xPart = self.croppingRect.size.width/3;
    CGFloat xLine;
    xLine = self.croppingRect.origin.x + xPart;
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, xLine,  self.croppingRect.origin.y);
    CGContextAddLineToPoint(context, xLine, self.croppingRect.origin.y + self.croppingRect.size.height);
    CGContextSetStrokeColorWithColor(context, vertColor.CGColor);
    CGContextStrokePath(context);

    xLine = self.croppingRect.origin.x + (xPart * 2);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, xLine,  self.croppingRect.origin.y);
    CGContextAddLineToPoint(context, xLine, self.croppingRect.origin.y + self.croppingRect.size.height);
    CGContextSetStrokeColorWithColor(context, vertColor.CGColor);
    CGContextStrokePath(context);

    // vamos rafa
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, xLine,  self.croppingRect.origin.y);
    
}




@end
