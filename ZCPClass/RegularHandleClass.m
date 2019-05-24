//
//  RegularHandleClass.m
//  JinYinHua
//
//  Created by zhangchipeng on 2018/10/31.
//  Copyright © 2018 yidongwujiang. All rights reserved.
//

#import "RegularHandleClass.h"

@implementation RegularHandleClass

+ (BOOL)isMobile:(NSString *)mobileNumbel {
    
    /**
     * 手机号码
     * 移动：134 135 136 137 138 139 147 150 151 152 157 158 159 178 182 183 184 187 188 198
     * 联通：130 131 132 145 155 156 166 171 175 176 185 186
     * 电信：133 149 153 173 177 180 181 189 199
     * 虚拟运营商: 170
     */
    
    NSString *target = @"^(0|86|17951)?(13[0-9]|15[012356789]|16[6]|19[89]]|17[01345678]|18[0-9]|14[579])[0-9]{8}$";
    NSPredicate *targetPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", target];
    if ([targetPredicate evaluateWithObject:mobileNumbel]) {
        return YES;
    }
    
    return NO;
}

+ (NSString *)getZZwithString:(NSString *)string {
    
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n" options:0 error:nil];
    
    string = [regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    
    return string;
}

@end
