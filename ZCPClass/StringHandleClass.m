//
//  StringHandleClass.m
//  shanglv51
//
//  Created by iosyf－03 on 2017/9/20.
//  Copyright © 2017年 shanglv. All rights reserved.
//

#import "StringHandleClass.h"

@implementation StringHandleClass
#pragma mark -- 字典转Json字符串
/**
 字典转Json字符串

 @param dictonary 传入字典
 @return json字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dictonary {
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictonary options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
#pragma mark -- 截取两个字符串中间的字符串
/**
 截取两个字符串中间的字符串

 @param originalString 原字符串
 @param startString 起始字符串
 @param toString 结尾字符串
 @return 截取后的字符串
 */
+ (NSString *)originalString:(NSString *)originalString startString:(NSString *)startString toString:(NSString *)toString {
    
    NSRange startRange = [originalString rangeOfString:startString];
    NSRange endRange = [originalString rangeOfString:toString];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    return [originalString substringWithRange:range];
}

#pragma mark -- 保留后X位小数

/**
 保留x位小数

 @param string float
 @param retainPoint 保留几位小数
 @return 结果
 */
+ (NSString *)decimalNumberToString:(CGFloat)string retainPoint:(NSInteger)retainPoint {
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:retainPoint raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:string];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

#pragma mark -- 改变String颜色、大小
/**
 选择改变文本中的区域字体颜色，大小
 
 @param originalString 传入文本
 @param changedString 修改文本
 @param changedFont 修改字体
 @param changedColor 修改颜色
 @param isStrikethrough 是否需要横线
 @return 修改完成后的NSMutableAttributedString
 */
+ (NSMutableAttributedString *)originalString:(NSString *)originalString changedString:(NSString *)changedString changedFont:(UIFont *)changedFont changedColor:(UIColor *)changedColor isStrikethrough:(BOOL)isStrikethrough {
    
    NSMutableAttributedString *returnString = [[NSMutableAttributedString alloc] initWithString:originalString];
    //改变字体大小
    [returnString addAttribute:NSFontAttributeName value:changedFont range:[originalString rangeOfString:changedString]];
    //改变字体颜色
    [returnString addAttribute:NSForegroundColorAttributeName value:changedColor range:[originalString rangeOfString:changedString]];
    //中划线
    if (isStrikethrough) {
        
        [returnString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:[originalString rangeOfString:changedString]];
    }
    
    return returnString;
}

#pragma mark -- 身份证解析性别

/**
 身份证解析性别

 @param idCardNumber 身份证
 @return 性别
 */
+ (NSString *)getIdentityCardSex:(NSString *)idCardNumber
{
    NSInteger sexInt = [[idCardNumber substringWithRange:NSMakeRange(16,1)] intValue];
    
    if(sexInt % 2 != 0) {
        return @"男";
    } else {
        return @"女";
    }
}
#pragma mark -- 计算String宽／高
/**
 计算String宽／高

 @param string 字符串
 @param maxWidth 最大宽度
 @param maxHeight 最大高度
 @param font 字体大小
 @param returnWidth 是否返回宽度
 @return 宽度或高度
 */
+ (CGFloat)returnStringSize:(NSString *)string maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight font:(UIFont *)font returnWidth:(BOOL)returnWidth {
    
    CGRect sizeToFit = [string boundingRectWithSize:CGSizeMake(maxWidth, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{                                                                       NSFontAttributeName:font} context:nil];
    
    if (returnWidth) {
        return sizeToFit.size.width;
    }else {
        return sizeToFit.size.height;
    }
}
/**
 *  设置字符串一个位置的富文本
 *
 *  @param inStr    传入的字符串
 *  @param range    设置富文本位置
 *  @param color    设置成什么颜色
 *  @param fontSize 字体大小
 *  @return 得到的富文本
 *
 */
+ (NSMutableAttributedString *)getReachTextStr:(NSString *)inStr range:(NSRange)range color:(UIColor*)color fontSize:(CGFloat)fontSize {
    
    NSMutableAttributedString *resultStr = [[NSMutableAttributedString alloc]initWithString:inStr];
    //字体大小
    [resultStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:range];
    //颜色
    [resultStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    return resultStr;
}



/**
 转换Html文本

 @param htmlString htmlString description
 @param imageWidth 限定图片宽度
 @param lineSpacing 行距
 @return return value description
 */
+ (NSMutableAttributedString *)htmlString:(NSString *)htmlString imageWidth:(CGFloat)imageWidth lineSpacing:(CGFloat)lineSpacing {
    
    NSString *htmlStr = htmlString;
    
    //如果有图片，限定图片的大小
    NSString *str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@", imageWidth, htmlStr];
    
    NSData *data = [str dataUsingEncoding:NSUnicodeStringEncoding];
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType};
    //设置富文本
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    //设置段落格式
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = lineSpacing;
    [attStr addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, attStr.length)];
    
    return attStr;
}

/**
 文本转富文本后计算高度

 @param string 原文本
 @param space 行距
 @param maxWidth maxWidth description
 @param maxHeight maxHeight description
 @param font font description
 @return return value description
 */
+ (CGSize)returnStringSize:(NSString *)string space:(CGFloat)space maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight font:(UIFont *)font {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = space;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0};
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(maxWidth, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size;
}

/**
 去除emoji表情

 @param string string description
 @return return value description
 */
+ (NSString *)clearnEmoji:(NSString *)string {
    
    //去除表情规则
    
    //  \u0020-\\u007E  标点符号，大小写字母，数字
    //  \u00A0-\\u00BE  特殊标点  (¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾)
    //  \u2E80-\\uA4CF  繁简中文,日文，韩文 彝族文字
    //  \uF900-\\uFAFF  部分汉字
    //  \uFE30-\\uFE4F  特殊标点(︴︵︶︷︸︹)
    //  \uFF00-\\uFFEF  日文  (ｵｶｷｸｹｺｻ)
    //  \u2000-\\u201f  特殊字符(‐‑‒–—―‖‗‘’‚‛“”„‟)
    
    NSRegularExpression* expression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u00A0-\\u00BE\\uF900-\\uFAFF\\uFE30-\\uFE4F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    
    NSString *result = [expression stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, string.length) withTemplate:@"[特殊字符]"];
    
    return result;
}

@end
