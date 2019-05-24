//
//  StringHandleClass.h
//  shanglv51
//
//  Created by iosyf－03 on 2017/9/20.
//  Copyright © 2017年 shanglv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StringHandleClass : NSObject

/**
 字典转Json字符串
 
 @param dictonary 传入字典
 @return json字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dictonary;
/**
 截取两个字符串中间的字符串
 
 @param originalString 原字符串
 @param startString 起始字符串
 @param toString 结尾字符串
 @return 截取后的字符串
 */
+ (NSString *)originalString:(NSString *)originalString startString:(NSString *)startString toString:(NSString *)toString;


/**
 保留x位小数

 @param string 输入字符串
 @param retainPoint 需要保留几位小数
 @return 返回保留小数点后的字符串
 */
+ (NSString *)decimalNumberToString:(CGFloat)string retainPoint:(NSInteger)retainPoint;



/**
 选择改变文本中的区域字体颜色，大小

 @param originalString 传入文本
 @param changedString 修改文本
 @param changedFont 修改字体
 @param changedColor 修改颜色
 @param isStrikethrough 是否需要横线
 @return 修改完成后的NSMutableAttributedString
 */
+ (NSMutableAttributedString *)originalString:(NSString *)originalString changedString:(NSString *)changedString changedFont:(UIFont *)changedFont changedColor:(UIColor *)changedColor isStrikethrough:(BOOL)isStrikethrough;

/**
 计算String宽／高
 
 @param string 字符串
 @param maxWidth 最大宽度
 @param maxHeight 最大高度
 @param font 字体大小
 @param returnWidth 是否返回宽度
 @return 宽度或高度
 */
+ (CGFloat)returnStringSize:(NSString *)string maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight font:(UIFont *)font returnWidth:(BOOL)returnWidth;

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
+ (NSMutableAttributedString *) getReachTextStr:(NSString *)inStr range:(NSRange)range color:(UIColor*)color fontSize:(CGFloat)fontSize;

/**
 转换Html文本
 
 @param htmlString htmlString description
 @param imageWidth 限定图片宽度
 @param lineSpacing 行距
 @return return value description
 */
+ (NSMutableAttributedString *)htmlString:(NSString *)htmlString imageWidth:(CGFloat)imageWidth lineSpacing:(CGFloat)lineSpacing;

/**
 文本转富文本后计算高度
 
 @param string 原文本
 @param space 行距
 @param maxWidth maxWidth description
 @param maxHeight maxHeight description
 @param font font description
 @return return value description
 */
+ (CGSize)returnStringSize:(NSString *)string space:(CGFloat)space maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight font:(UIFont *)font;

/**
 去除emoji表情
 
 @param string string description
 @return return value description
 */
+ (NSString *)clearnEmoji:(NSString *)string;

@end
