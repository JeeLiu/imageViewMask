//
//  ViewController.m
//  imageViewMask
//
//  Created by eshore on 15/4/16.
//  Copyright (c) 2015年 com.eshore. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _imageView.image = [UIImage imageNamed:@"NewYearShake"];
    
    CALayer *layer = [[self class] getBubbleMaskLayer:_imageView.frame isFromMe:NO];
    _imageView.layer.mask = layer;
    
    
    _imageView2.image = [UIImage imageNamed:@"NewYearShake2"];
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(120, 120) radius:120 startAngle:0 endAngle:2*M_PI clockwise:YES];
    CAShapeLayer* shape = [CAShapeLayer layer];
    shape.path = path.CGPath;
    _imageView2.layer.mask = shape;
    _imageView2.layer.shouldRasterize = YES; //去除UIImageView锯齿
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (CALayer *)getBubbleMaskLayer:(CGRect)frame isFromMe:(BOOL)fromMe
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [[self class] bubbleImageWithMessageOwner:fromMe];
    imageView.layer.frame = (CGRect){ {0, 0}, imageView.layer.frame.size };
    return imageView.layer;
}

+ (UIImage *)bubbleImageWithMessageOwner:(BOOL)fromMe
{
    NSString *imageName = @"chat_bubble";
    if (fromMe) {
        imageName = [imageName stringByAppendingString:@"_me"];
    }
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(30, 28, 85, 28);
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        image = [image stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top];
    } else {
        image = [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch];
    }
    return image;
}

@end
