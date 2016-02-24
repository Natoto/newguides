//
//  NewCustomerGuide.m
//  PENG
//
//  Created by zeno on 16/2/23.
//  Copyright © 2016年 nonato. All rights reserved.
//

#import "NewCustomerGuide.h"
#import "AppDelegate.h"
@interface NewCustomerGuide()
@property(strong,nonatomic)  UIImageView * img_partScreenShot;
@property(strong,nonatomic)  UIImageView * img_tips;
@property(strong,nonatomic)  UIButton    * btn_iknown;
@end

@implementation NewCustomerGuide

+(id)guide
{
    NewCustomerGuide * guideview = [[NewCustomerGuide alloc] initWithFrame:[UIScreen mainScreen].bounds];
    return guideview;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) { 
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
        [self img_partScreenShot];
        [self img_tips];
        [self btn_iknown];
    }
    return self;
}

-(UIImage *)tipsImageForNewGuideType:(NewGuideType)type
{
    UIImage * image = [UIImage imageNamed:[self tipsImageName:type]];
    return image;
}


-(void)showTipsWithView:(UIView *)fromview
{
    UIImage * image = [self snapshotImageWithView:fromview];
    CGRect fromFrame = [fromview convertRect:fromview.bounds toView:self];
    self.img_partScreenShot.image = image;
    self.img_partScreenShot.frame = fromFrame;    
}

//-(void)showNewGuideWithView:(UIView *)fromview type:(NewGuideType)type
//{
//    UIImage * image = [self snapshotImageWithView:fromview];
//    CGRect fromFrame = [fromview convertRect:fromview.bounds toView:self];
//    self.img_partScreenShot.image = image;
//    self.img_partScreenShot.frame = fromFrame;
//    
//    self.img_tips.image = [self tipsImageForNewGuideType:type];
//    self.img_tips.frame = [self tipsFrame:type fromviewframe:fromFrame];
//    self.btn_iknown.frame = [self frameOfbtniknown:type fromTipsframe:self.img_tips.frame];
////    self.tapblock = [block copy];
//}

-(NewCustomerGuide *)showNewGuideWithView:(UIView *)fromview type:(NewGuideType)type tapblock:(NEWGUIDETAPTAPBLOCK)block
{
    BOOL isshow = [self isshowguidewith:type];
    if (isshow) {
        if (block) {
            block();
        }
    }
    else
    {
        UIImage * image = [self snapshotImageWithView:fromview];
        //相对于屏幕
        CGRect fromFrame = [fromview convertRect:fromview.bounds toView:nil];
        self.img_partScreenShot.image = image;
        self.img_partScreenShot.frame = fromFrame;
        self.img_tips.image = [self tipsImageForNewGuideType:type];
        self.img_tips.frame = [self tipsFrame:type fromviewframe:fromFrame];
        self.btn_iknown.frame = [self frameOfbtniknown:type fromTipsframe:self.img_tips.frame];
    }
    self.currentType = type;
    if (block) {
        self.tapblock = [block copy];
    }
    return self;
}
-(void)addToAppWindow
{
    BOOL isshow = [self isshowguidewith:self.currentType];
    if (isshow) {
        
    }
    else
    {
        AppDelegate * appdelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
        [appdelegate.window addSubview:self];
        [appdelegate.window bringSubviewToFront:self];
        [self setisshownewguidewith:self.currentType shown:YES];
    }
}

-(NewCustomerGuide *)with
{
    return self;
}

-(NSString *)key_isshownewguide:(NewGuideType)type
{
    return [NSString stringWithFormat:@"show_newguide%ld",type];
}

-(void)setisshownewguidewith:(NewGuideType)type shown:(BOOL)show
{
    [[NSUserDefaults standardUserDefaults] setObject:@(show) forKey:[self key_isshownewguide:type]];
}

-(BOOL)isshowguidewith:(NewGuideType)type
{
    NSNumber * isshow = [[NSUserDefaults standardUserDefaults] objectForKey:[self key_isshownewguide:type]];
    //正式版后用回 isshow.boolValue;
    return NO;//isshow.boolValue;
}

-(IBAction)imageViewTap:(id)sender
{
    if (self.tapblock) {
        self.tapblock();
    }
}

#pragma mark - setter getter

-(CGRect)frameOfbtniknown:(NewGuideType)type fromTipsframe:(CGRect)imgtipsframe
{
    CGRect frame;
    CGFloat top = imgtipsframe.origin.y;
    CGFloat bottom = imgtipsframe.origin.y + imgtipsframe.size.height;
    CGFloat left = imgtipsframe.origin.x;
    CGFloat right = imgtipsframe.origin.x + imgtipsframe.size.width;
    switch (type) {
        case NG_FIND:  frame = CGRectMake(right - 115, top + 70, 115, 60);
            break;
        case NG_SQUARE: frame = CGRectMake(right - 115, top + 50, 115, 60);
            break;
        case NG_CAMERA: frame = CGRectMake(right - 115, top + 50,115, 60);
            break;
        case NG_CROWNDFUNDING: frame = CGRectMake(right - 115, top + 50, 115, 60);
            break;
        case NG_PB: frame = CGRectMake(right - 115, top + 95, 115, 60);
            break;
        case NG_COMMENT: frame = CGRectMake(right - 110, top - 70, 115, 60);
            break;
        case NG_ADDFRIENDS: frame = CGRectMake(right - 115, bottom + 5, 115, 60);
            break;
        case NG_ACTIVITY: frame = CGRectMake(right - 115, top - 70. , 115, 60);
            break;
        default:
            break;
    }
    return frame;
}


-(CGRect)tipsFrame:(NewGuideType)type fromviewframe:(CGRect)fromviewframe
{
    CGRect frame;
    switch (type) {
        case NG_FIND:  frame = CGRectMake(10, self.bounds.size.height - 200, 270, 200);
            break;
        case NG_SQUARE: frame = CGRectMake(fromviewframe.origin.x - fromviewframe.size.width + 15, self.bounds.size.height - 200, 270, 200);
            break;
        case NG_CAMERA: frame = CGRectMake(fromviewframe.origin.x - 100., self.bounds.size.height - 200, 270, 200);
            break;
        case NG_CROWNDFUNDING: frame = CGRectMake(self.bounds.size.width - 270., self.bounds.size.height - 200, 270, 200);
            break;
        case NG_PB: frame = CGRectMake(0, fromviewframe.origin.y - 50, 260, 300);
            break;
        case NG_COMMENT: frame = CGRectMake(0, self.bounds.size.height - 150 - fromviewframe.size.height, 280, 150);
            break;
        case NG_ADDFRIENDS: frame = CGRectMake(10, 0, 225, 250);
            break;
        case NG_ACTIVITY: frame = CGRectMake(0, fromviewframe.origin.y - 172. , 300, 172);
            break;
        default:
            break;
    }
    return frame;
}


-(NSString *)tipsImageName:(NewGuideType)type
{
    NSString * imgname;
    switch (type) {
        case NG_FIND:
            imgname = @"newguide_find";
            break;
        case NG_SQUARE:
            imgname = @"newguide_square";
            break;
        case NG_CAMERA:
            imgname = @"newguide_camera";
            break;
        case NG_CROWNDFUNDING:
            imgname = @"newguide_crownfunding";
            break;
        case NG_PB:
            imgname = @"newguide_pb";
            break;
        case NG_COMMENT:
            imgname = @"newguide_comment";
            break;
        case NG_ADDFRIENDS:
            imgname = @"newguide_addfriends";
            break;
        case NG_ACTIVITY:
            imgname = @"newguide_activity";
            break;
        default:
            break;
    }
    return imgname;
}


- (UIImage *)snapshotImageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}


-(UIImageView *)img_tips
{
    if (!_img_tips) {
        UIImageView * img = [UIImageView new];
        img.frame = CGRectMake(0, 0, 250, 250);
        img.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:img];
        _img_tips = img;
    }
    return _img_tips;
}

-(UIButton *)btn_iknown
{
    if (!_btn_iknown) {
        _btn_iknown = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_iknown setImage:[UIImage imageNamed:@"newguide_iknow"] forState:UIControlStateNormal];
        _btn_iknown.frame = CGRectMake(0, 0, 115, 60);
        [self addSubview:_btn_iknown];
        [_btn_iknown addTarget:self action:@selector(imageViewTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_iknown;
}

-(UIImageView *)img_partScreenShot
{
    if (!_img_partScreenShot) {
        _img_partScreenShot = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//        _img_partScreenShot.backgroundColor = [UIColor whiteColor];
        [self addSubview:_img_partScreenShot];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
        [_img_partScreenShot addGestureRecognizer:tap];
        _img_partScreenShot.userInteractionEnabled = YES;
    }
    return _img_partScreenShot;
}

////裁剪图片
//-(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect{
//    CGImageRef sourceImageRef = [image CGImage];
//    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
//    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
//    return newImage;
//}
//
////改变图片的大小
//-(UIImage *)scaleFromImage:(UIImage *)image toSize:(CGSize)size
//{
//    UIGraphicsBeginImageContext(size);
//    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
//}

@end
