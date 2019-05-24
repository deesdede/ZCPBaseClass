//
//  RegularHandleClass.h
//  JinYinHua
//
//  Created by zhangchipeng on 2018/10/31.
//  Copyright © 2018 yidongwujiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegularHandleClass : NSObject

/**
 判断是否是手机号

 @param mobileNumbel 字符串
 @return Bool
 */
+ (BOOL)isMobile:(NSString *)mobileNumbel;


/**
 去除Html标签，保存纯文本

 @param string html
 @return return value description
 */
+ (NSString *)getZZwithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
