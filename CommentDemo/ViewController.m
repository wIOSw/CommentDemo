//
//  ViewController.m
//  CommentDemo
//
//  Created by liuwei on 2017/5/9.
//  Copyright © 2017年 liuwei. All rights reserved.
//

#import "ViewController.h"
#import "BulletView.h"
#import "BulletManager.h"

@interface ViewController ()

@property (nonatomic, strong) BulletManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.manager = [[BulletManager alloc] init];
    
    __weak typeof (self) mySelf = self;
    self.manager.generateViewBlock = ^(BulletView *view) {
        [mySelf addBulletView:view];
    };
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"start" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 40);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn1 setTitle:@"stop" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(250, 100, 100, 40);
    [btn1 addTarget:self action:@selector(clickStopBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
}

- (void)btnClick {
    [self.manager start];
}

-(void)clickStopBtn {
    [self.manager stop];
}

- (void)addBulletView: (BulletView*) view {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    view.frame = CGRectMake(width, 300 + view.trajectory * 40, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    [self.view addSubview:view];
    
    [view startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
