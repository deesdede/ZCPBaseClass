//
//  FileHandleClass.m
//  shanglv51
//
//  Created by iosyf－03 on 2017/9/20.
//  Copyright © 2017年 shanglv. All rights reserved.
//

#import "FileHandleClass.h"

@implementation FileHandleClass

#pragma mark -- 在沙盒下创建Plist文件
/**
 在沙盒下创建Plist文件

 @param dic 数据源
 @param plistName Plist文件名字
 @return 是否创建成功
 */
+ (BOOL)savePlistData:(NSMutableDictionary *)dic plistName:(NSString *)plistName {
    
    BOOL isSuccess = [dic writeToFile:[self applicationDocumentFilePath:[NSString stringWithFormat:@"%@.plist", plistName]] atomically:YES];
    
    return isSuccess;
}

#pragma mark -- Plist文件读取
/**
 读取plist文件

 @param plistName plistName description
 @return return value description
 */
+ (NSMutableDictionary *)readPlistFile:(NSString *)plistName {
    
    NSString *plistPath = [self applicationDocumentFilePath:[NSString stringWithFormat:@"%@.plist", plistName]];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    return data;
}

#pragma mark -- 获取文件路径
/**
 获取文件路径

 @param plistName 文件名
 @return 文件路径
 */
+ (NSString *)applicationDocumentFilePath:(NSString *)plistName {
    
    //获取文件路径
    NSString *library = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return [library stringByAppendingPathComponent:plistName];
}

#pragma mark -- 删除文件
/**
 删除文件

 @return 是否删除成功
 */
+ (BOOL)isDeleteUserInfo {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //要删除的Plist文件
    NSString *uniquePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"CityListHistory.plist"];
    
    //文件是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:uniquePath]) {
        
        //删除文件
        BOOL blDelete = [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDelete) { //如果删除成功
            return YES;
        }else {
            return NO;
        }
    }else {
        //文件不存在
        return YES;
    }
}

#pragma mark -- Plist文件是否存在

/**
 plist文件是否存在

 @param name 文件名
 @return return value description
 */
+ (BOOL)isExistFile:(NSString *)name {
    
    NSString *plistPath = [self applicationDocumentFilePath:[NSString stringWithFormat:@"%@.plist", name]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:plistPath] == NO) {
        return NO;
    } else {
        return YES;
    }
}


/**
 读取Txt文件

 @param fileName 文件名
 @return 字典
 */
+ (NSDictionary *)readTxtField:(NSString *)fileName {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *JSONData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = nil;
    if (JSONData) {
        responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
    }
    
    return responseJSON;
}

+ (NSString *)cheakCachesSize {
    
    //获取Library/Caches路径
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    CGFloat librarySize = [self cacheWithFilePath:libraryPath];
    
    NSString *tmpPath = NSTemporaryDirectory();
    CGFloat tmpSize = [self cacheWithFilePath:tmpPath];
    
    CGFloat total = librarySize + tmpSize;
    
    return [NSString stringWithFormat:@"%.2fM", total];
}

+ (void)clearnCachesResult:(void (^)(void))result {
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *tmpPath = NSTemporaryDirectory();
    [self clearnCacheWithFilePath:libraryPath];
    [self clearnCacheWithFilePath:tmpPath];
    
    result();
}

+ (CGFloat)cacheWithFilePath:(NSString *)filePath {
    
    //计算结果
    CGFloat totalSize = 0.0;
    // 1.获得文件夹管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 2.检测路径的合理性
    BOOL dir = NO;
    BOOL exits = [mgr fileExistsAtPath:filePath isDirectory:&dir];
    if (!exits) {
        return 0;
    }
    // 3.判断是否为文件夹
    if (dir) { //文件夹, 遍历文件夹里面的所有文件
        //这个方法能获得这个文件夹下面的所有子路径(直接\间接子路径),包括子文件夹下面的所有文件及文件夹
        NSArray *subPaths = [mgr subpathsAtPath:filePath];
        
        //遍历所有子路径
        for (NSString *subPath in subPaths) {
            //拼成全路径
            NSString *fullSubPath = [filePath stringByAppendingPathComponent:subPath];
            
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubPath isDirectory:&dir];
            if (!dir) { //子路径是个文件
                NSDictionary *attrs = [mgr attributesOfItemAtPath:fullSubPath error:nil];
                totalSize += [attrs[NSFileSize] floatValue];
            }
        }
        totalSize = totalSize / (1024.0 * 1024.0);//单位M
    }
    else { //文件
        NSDictionary *attrs = [mgr attributesOfItemAtPath:filePath error:nil];
        totalSize = [attrs[NSFileSize] floatValue] / (1024.0 * 1024.0);//单位M
    }
    
    return totalSize;
}

+ (void)clearnCacheWithFilePath:(NSString *)path {
    
    NSError *error = nil;//错误信息
    //拿到path路径的下一级目录的子文件夹
    NSArray *subPathArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString *subPath in subPathArray) {
        
        NSString *filePath = [path stringByAppendingPathComponent:subPath];
        //删除子文件夹
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            NSLog(@"删除失败");
        }
        else
        {
            NSLog(@"删除成功!");
        }
    }
}

@end
