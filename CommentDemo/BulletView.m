//
//  BulletView.m
//  CommentDemo
//
//  Created by liuwei on 2017/5/9.
//  Copyright © 2017年 liuwei. All rights reserved.
//

#import "BulletView.h"

#define Padding 10
#define PhotoHeight 30

@interface BulletView()

@property (nonatomic,strong) UILabel *lbComment;
@property (nonatomic,strong) UIImageView *photoImageView;

@end

@implementation BulletView

//初始化弹幕
- (instancetype) initWithComment:(NSString*)comment{
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];
        self.layer.cornerRadius = 8;
        
        //计算弹幕的实际宽度
        NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGFloat width = [comment sizeWithAttributes:attr].width;
        self.bounds = CGRectMake(0, 0, width + 2 * Padding + PhotoHeight, 30);
        self.lbComment.text = comment;
        //label 就是集体的宽度
        self.lbComment.frame = CGRectMake(Padding + PhotoHeight, 0, width, 30);
        
        self.photoImageView.frame = CGRectMake(-Padding, -Padding, PhotoHeight + Padding, PhotoHeight + Padding);
        self.photoImageView.layer.cornerRadius = (PhotoHeight + Padding) / 2;
        self.photoImageView.layer.borderColor = [UIColor redColor].CGColor;
        self.photoImageView.layer.borderWidth = 1.0;
        self.photoImageView.image = [UIImage imageNamed:@"哆啦A梦"];
        
    }
    return self;
}

//开始动画
- (void)startAnimation{
    
    //根据弹幕长度执行动画效果
    //根据 v = s/t ,时间相同的情况下,距离越长,速度越快.
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 4.0f;
    CGFloat wholeWidth = screenWidth + CGRectGetWidth(self.bounds);
    
    //弹幕开始
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Start);
    }
    
    //t = s/v
    CGFloat speed = wholeWidth/duration;
    CGFloat enterDuration = CGRectGetWidth(self.bounds)/speed;

    [self performSelector:@selector(enterScreen) withObject:nil afterDelay:enterDuration];
    
//    停止弹幕特效
//    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    //没有办法中止
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(enterDuration *NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (self.moveStatusBlock) {
//            self.moveStatusBlock(Enter);
//        }
//    });
    
    
    __block CGRect frame = self.frame;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        //动画中从最有到最左,在duration时间段内完成
        frame.origin.x -= wholeWidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.moveStatusBlock) {
            self.moveStatusBlock(End);
        }
    }];
}

- (void)enterScreen {
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Enter);
    }
}

//结束动画
- (void)stopAnimation{
    
    //    停止弹幕特效
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

- (UILabel*)lbComment {
    if (!_lbComment) {
        _lbComment = [[UILabel alloc] initWithFrame:CGRectZero];
        _lbComment.font = [UIFont systemFontOfSize:14];
        _lbComment.textColor = [UIColor whiteColor];
        _lbComment.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbComment];
    }
    
    return _lbComment;
}

- (UIImageView *)photoImageView {
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] init];
        _photoImageView.clipsToBounds = YES;
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_photoImageView];
    }
    
    return _photoImageView;
}

@end
