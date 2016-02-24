//
//  ViewController.m
//  新手引导Demo
//
//  Created by zeno on 16/2/24.
//  Copyright © 2016年 peng. All rights reserved.
//

#import "ViewController.h"
#import "NewCustomerGuide.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *img_faxian;
@property (weak, nonatomic) IBOutlet UIImageView *img_guangchang;
@property (weak, nonatomic) IBOutlet UIImageView *img_xiangji;
@property (weak, nonatomic) IBOutlet UIImageView *img_zhongchou;
@property (weak, nonatomic) IBOutlet UIImageView *img_mine;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NewCustomerGuide * guide =  [NewCustomerGuide guide];
    [[guide showNewGuideWithView:self.img_faxian type:NG_FIND tapblock:^{
        
        [guide showNewGuideWithView:self.img_guangchang type:NG_SQUARE tapblock:^{
           
            [guide showNewGuideWithView:self.img_xiangji type:NG_CAMERA tapblock:^{
                [guide removeFromSuperview];
            }];
        }];
        
    }] addToAppWindow];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
