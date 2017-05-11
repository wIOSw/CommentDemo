//
//  BulletManager.h
//  CommentDemo
//
//  Created by liuwei on 2017/5/9.
//  Copyright © 2017年 liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  BulletView;
@interface BulletManager : NSObject

@property (nonatomic,copy) void (^generateViewBlock)(BulletView *view);

//弹幕开始执行
- (void)start;

//弹幕停止执行
- (void)stop;

@end
