//
//  DataHandleClass.m
//  jinqiaoliang
//
//  Created by zhangchipeng on 2018/3/28.
//  Copyright © 2018年 JinQIaoLiang. All rights reserved.
//

#import "DataHandleClass.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/utsname.h>
#import "AppDelegate.h"

//字符串是否为空
#define isNull(a)  ((a==nil) || ((NSNull*)a==[NSNull null]) )
#define isNotNull(a)  (!isNull(a))
#define avoidNullStr(a) isNull(a) ? @"" : a
#define avoid(a) isNull(a) ? @"" : a

@implementation DataHandleClass

+ (NSDictionary *)dictionaryWithIcon:(NSString *)iconString andTitle:(NSString *)titleString andDetailString:(NSString *)detailString andUrlString:(NSString *)urlString {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:iconString, @"Icon", titleString, @"Title", detailString, @"Detail", urlString, @"Url", nil];
    
    return dic;
}

+ (NSMutableDictionary *)dictionaryWithTitle:(NSString *)title andPlaceholder:(NSString *)placeholder andText:(NSString *)text detail:(NSString *)detail isClick:(BOOL)isClick {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"Title"] = title;
    dic[@"Place"] = placeholder;
    dic[@"Text"] = text;
    dic[@"Detail"] = detail;
    dic[@"Click"] = [NSNumber numberWithBool:isClick];
    
    return dic;
}

//获取当前控制器
+ (UIViewController *)currentViewController {
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *vc = appdelegate.window.rootViewController;
    
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
        
    }
    
    return vc;
}


/**
 压缩图片

 @param image 需要压缩的图片
 @param newImageWidth 缩放后图片宽度，像素为单位
 @return image
 */
+ (UIImage *)compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth
{
    if (!image) return nil;
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = newImageWidth;
    float height = image.size.height/(image.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


/**
 字典是否为空

 @param dictionary 判断字典
 @return 结果
 */
+ (NSDictionary *)dictionaryIsNil:(NSDictionary *)dictionary {
    
    if (isNull(dictionary)) {
        return [NSDictionary dictionary];
    }else {
        return dictionary;
    }
}


/**
 数组字典key值排序

 @param AscendingSort 是否降序
 @param array 需要排序的数组
 @return return value description
 */
+ (NSArray *)arrayContentDicAscendingSort:(BOOL)AscendingSort array:(NSArray *)array {
    
    NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSNumber *number1 = [[obj1 allKeys] objectAtIndex:0];
        NSNumber *number2 = [[obj2 allKeys] objectAtIndex:0];
        NSComparisonResult result = [number1 compare:number2];
        
        return result == NSOrderedAscending;  // 降序
    }];
    
    return resultArray;
}

/**
 判断对象是否为空
 
 @param object id
 @return bool
 */
+ (BOOL)isObjectNull:(id)object {
    
    if ([object isKindOfClass:[NSString class]]) {
        NSString * str = (NSString*)object;
        if ([str isEqualToString:@"(null)"]) {
            return YES;
        }
        if ([str isEqual:[NSNull null]]) {
            return YES;
        }
        if (str == nil || str == NULL) {
            return YES;
        }
        if ([str isKindOfClass:[NSNull class]]) {
            return YES;
        }
        if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
            return YES;
        }
        return NO;
    }else if ([object isKindOfClass:[NSArray class]]) {
        NSArray * arr = (NSArray*)object;
        if ([arr isKindOfClass:[NSArray class]] && arr!=NULL && arr !=[NSNull class] && arr!=nil && (NSNull *)arr!=[NSNull null] && arr.count!=0) {
            return NO;
        }else{
            return YES;
        }
        return YES;
    }else if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary * dic = (NSDictionary*)object;
        if (dic!=NULL && dic !=[NSNull class] && dic!=nil && (NSNull *)dic!=[NSNull null]) {
            return NO;
        }else{
            return YES;
        }
        return YES;
    }else {
        return YES;
    }
}


/**
 获取设备ip地址

 @return return value description
 */
+ (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // 检索当前接口,在成功时,返回0
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // 循环链表的接口
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // 检查接口是否en0 wifi连接在iPhone上
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // 得到NSString从C字符串
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // 释放内存
    freeifaddrs(interfaces);
    return address;
}


/**
 获取手机版本

 @return return value description
 */
+ (NSString *)getCurrentDeviceModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa方案而不是苹果
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceModel isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceModel isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceModel isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceModel isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    return deviceModel;
}


/**
 获取手机名称

 @return return value description
 */
+ (NSString *)getDeviceName {
    
    NSString *deviceName = [[UIDevice currentDevice] name];
    return deviceName;
}


/**
 获取手机系统号

 @return return value description
 */
+ (NSString *)getPhoneSysVersion {
    
    NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
    
    return sysVersion;
}


/**
 获取设备UUID

 @return return value description
 */
+ (NSString *)getDeviceUUID {
    
    NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return deviceUUID;
}


/**
 获取手机版本

 @return return value description
 */
+ (NSString *)getDeviceModel {
    
    NSString *deviceModel = [[UIDevice currentDevice] model];
    return deviceModel;
}

@end
