//
//  FileHandleClass.h
//  shanglv51
//
//  Created by iosyf－03 on 2017/9/20.
//  Copyright © 2017年 shanglv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FileHandleClass : NSObject

/**
 在沙盒下创建Plist文件
 
 @param dic 数据源
 @param plistName Plist文件名字
 @return 是否创建成功
 */
+ (BOOL)savePlistData:(NSMutableDictionary *)dic plistName:(NSString *)plistName;

/**
 读取plist文件
 
 @param plistName plistName description
 @return return value description
 */
+ (NSMutableDictionary *)readPlistFile:(NSString *)plistName;

/**
 获取文件路径
 
 @param plistName 文件名
 @return 文件路径
 */
+ (NSString *)applicationDocumentFilePath:(NSString *)plistName;
/**
 删除文件
 
 @return 是否删除成功
 */
+ (BOOL)isDeleteUserInfo;

/**
 读取Txt文件
 
 @param fileName 文件名
 @return 字典
 */
+ (NSDictionary *)readTxtField:(NSString *)fileName;


/**
 检查缓存大小

 @return return value description
 */
+ (NSString *)cheakCachesSize;


/**
 删除缓存

 @param result result description
 */
+ (void)clearnCachesResult:(void (^)(void))result;
@end
