//
//  Singleton.h
//  xiaojingling
//
//  Created by zhangchipeng on 2018/12/28.
//  Copyright © 2018 yidongwujiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Singleton : NSObject

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
