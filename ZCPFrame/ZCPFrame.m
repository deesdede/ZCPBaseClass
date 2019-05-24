//
//  ZCPFrame.m
//  jinqiaoliang
//
//  Created by zhangchipeng on 2018/3/27.
//  Copyright © 2018年 JinQIaoLiang. All rights reserved.
//

#import "ZCPFrame.h"

@implementation ZCPFrame

+ (CGRect)suitFrame:(CGRect)frame {
    
    CGFloat xHeight = 0.00;
    if (([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)) {
        xHeight = 58;
    }
    
    CGFloat screen_rateW = 375 / [UIScreen mainScreen].bounds.size.width;
    CGFloat screen_rateH = 667 / ([UIScreen mainScreen].bounds.size.height - xHeight);
    
    CGRect newFrame;
    
    newFrame.size.height = ceil(frame.size.height / screen_rateH);
    newFrame.size.width = ceil(frame.size.width / screen_rateW);
    newFrame.origin.x = ceil(frame.origin.x / screen_rateW);
    newFrame.origin.y = ceil(frame.origin.y / screen_rateH);
    
    return newFrame;
}

+ (CGFloat)setAWidth:(CGFloat)width {
    
    CGFloat screem_rateH = 375 / [UIScreen mainScreen].bounds.size.width;
    width /= screem_rateH;
    return ceil(width);
}

+ (CGFloat)setFloatWidth:(CGFloat)width {
    
    CGFloat screem_rateH = 375 / [UIScreen mainScreen].bounds.size.width;
    width /= screem_rateH;
    return width;
}

+ (CGFloat)setAHeight:(CGFloat)height {
    
    CGFloat xHeight = 0.00;
    if (([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)) {
        xHeight = 58;
    }
    
    CGFloat screem_rateH = 667 / ([UIScreen mainScreen].bounds.size.height - xHeight);
    height /= screem_rateH;
    return ceil(height);
}

@end
