//
//  ZCPFrame.h
//  jinqiaoliang
//
//  Created by zhangchipeng on 2018/3/27.
//  Copyright © 2018年 JinQIaoLiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/* 基于屏幕宽高比计算得出Frame适配
 
 使用：
 UIView *view = [[UIView alloc] initWithFrame:ZCPCGRectMake(10, 10, 100, 100)];
 
 */
#define ZCPCGRectMake(x, y, width, height) [ZCPFrame suitFrame:CGRectMake(x, y, width, height)]
#define ZCPWidth(width) [ZCPFrame setAWidth:width]
#define ZCPHeight(height) [ZCPFrame setAHeight:height]

@interface ZCPFrame : NSObject

/**
 纯代码自适应坐标

 @param frame 输入Frame坐标体系
 @return 返回根据屏幕宽高比得出的坐标
 */
+ (CGRect)suitFrame:(CGRect)frame;

/**
 纯代码自适应宽度

 @param width 输入宽度
 @return 返回根据屏幕宽高比得出的宽度
 */
+ (CGFloat)setAWidth:(CGFloat)width;

/**
 纯代码自适应高度

 @param height 输入高度
 @return 返回根据屏幕宽高比得出的高度
 */
+ (CGFloat)setAHeight:(CGFloat)height;


/**
 没有使用ceil函数的宽度适配，用于一些怕ceil取整后导致的精度有问题的场景

 @param width width description
 @return return value description
 */
+ (CGFloat)setFloatWidth:(CGFloat)width;

@end
