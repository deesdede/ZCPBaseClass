//
//  DataHandleClass.h
//  jinqiaoliang
//
//  Created by zhangchipeng on 2018/3/28.
//  Copyright © 2018年 JinQIaoLiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataHandleClass : NSObject

/**
 返回一个数据字典

 @param iconString Icon图片
 @param titleString 标题
 @param detailString 详情描述
 @return 字典
 */
+ (NSDictionary *)dictionaryWithIcon:(NSString *)iconString andTitle:(NSString *)titleString andDetailString:(NSString *)detailString andUrlString:(NSString *)urlString;

+ (NSMutableDictionary *)dictionaryWithTitle:(NSString *)title andPlaceholder:(NSString *)placeholder andText:(NSString *)text detail:(NSString *)detail isClick:(BOOL)isClick;

//获取当前控制器
+ (UIViewController *)currentViewController;

/**
 压缩图片
 
 @param image 需要压缩的图片
 @param newImageWidth 缩放后图片宽度，像素为单位
 @return image
 */
+ (UIImage *)compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth;

/**
 字典是否为空
 
 @param dictionary 判断字典
 @return 结果
 */
+ (NSDictionary *)dictionaryIsNil:(NSDictionary *)dictionary;

/**
 数组字典key值排序
 
 @param AscendingSort 是否降序
 @param array 需要排序的数组
 @return return value description
 */
+ (NSArray *)arrayContentDicAscendingSort:(BOOL)AscendingSort array:(NSArray *)array;

/**
 判断对象是否为空
 
 @param object id
 @return bool
 */
+ (BOOL)isObjectNull:(id)object;

/**
 获取设备ip地址
 
 @return return value description
 */
+ (NSString *)getIPAddress;

/**
 获取手机版本
 
 @return return value description
 */
+ (NSString *)getCurrentDeviceModel;
/**
 获取手机名称
 
 @return return value description
 */
+ (NSString *)getDeviceName;


/**
 获取手机系统号
 
 @return return value description
 */
+ (NSString *)getPhoneSysVersion;


/**
 获取设备UUID
 
 @return return value description
 */
+ (NSString *)getDeviceUUID;


/**
 获取手机版本
 
 @return return value description
 */
+ (NSString *)getDeviceModel;

@end
