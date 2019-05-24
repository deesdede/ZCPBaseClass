//
//  Singleton.m
//  xiaojingling
//
//  Created by zhangchipeng on 2018/12/28.
//  Copyright © 2018 yidongwujiang. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

static Singleton *instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (instance == nil) {
            instance = [super allocWithZone:zone];
        }
    });
    return instance;
}

+ (instancetype)shareInstance {
    
    return [[self alloc] init];
}

- (id)copyWithZone:(NSZone *)zone {
    
    return instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    
    return instance;
}

@end
