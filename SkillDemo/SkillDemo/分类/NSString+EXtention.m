//
//  NSString+EXtention.m
//  SkillDemo
//
//  Created by pjw on 2020/10/11.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "NSString+EXtention.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSString+EXtention.h"

#define ImageWithName(name)     [UIImage imageNamed:name]


@implementation NSString (EXtention)

-(NSMutableAttributedString *)getPriceAttributeOfString:(NSString *)string onRange:(NSRange)pointRange WithColor:(UIColor *)targetColor withTextFont:(CGFloat)fontSize{
    
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc]initWithString:string];
    //目的是想改变 ‘/’前面的字体的属性，所以找到目标的range
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = targetColor;
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:fontSize];
    //赋值
    [attribut addAttributes:dic range:pointRange];
    return attribut;
}

- (NSMutableAttributedString *)addImageToString:(NSString *)targetStringName WithImageName:(NSString *)imageName imageFrame:(CGRect)imageFrme toIndex:(NSInteger)index
{
    //测试一下
    //创建富文本
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:targetStringName];
    //NSTextAttachment可以将要插入的图片作为特殊字符处理
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    //定义图片内容及位置和大小
    attch.image = ImageWithName(imageName);
    attch.bounds = imageFrme;
    //创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
    [attri insertAttributedString:string atIndex:index];
  
    return attri;
}

- (NSMutableAttributedString *)addImageArrays:(NSArray *)imagesArray withImageFrame:(UIView *)targetView ToTargetString:(NSString *)targetString inIndex:(NSInteger)index
{
    NSMutableAttributedString *abs = [[NSMutableAttributedString alloc]initWithString:@""];
   
    for (int i = 0; i < imagesArray.count; i++) {

        UIImage *image = ImageWithName(imagesArray[i]);
        
        NSTextAttachment *attach = [[NSTextAttachment alloc]init];
        attach.image = image;
        CGRect OutPutFrame;
        if (i == 0) {
            OutPutFrame = CGRectMake(0, 0, 15, 15);
        }else{
            OutPutFrame = CGRectMake(5, 2, 13, 13);
        }
        attach.bounds = OutPutFrame;

        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attach];
        [abs appendAttributedString:imageStr];

    }
    
  
    
    return abs;
}

+ (NSString *) md5:(NSString *) str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)getTimeString:(NSString *)timeString format:(NSString *)format {
    
    if (!timeString) {
        return @"";
    }
    
    if ([timeString isEqualToString:@"0"]) {
        return @"";
    }
    
    if (timeString.length < 10) {
        return timeString;
    }
    
    timeString = [timeString substringWithRange:NSMakeRange(0, 10)];
    
    NSString *year,*month,*day, *hour, *min, *second;
    [[NSDate dateWithTimeIntervalSince1970:[timeString longLongValue]] formatDateToEquation:TimeZone_UTC_Plus_8 Year:&year Month:&month Day:&day WeekDay:nil Hour:&hour Minutes:&min Second:&second maxDaysInMonth:nil];
    
    NSString *rtn = format;
    
    rtn = [rtn stringByReplacingOccurrencesOfString:@"yyyy" withString:year];
    rtn = [rtn stringByReplacingOccurrencesOfString:@"MM" withString:month];
    rtn = [rtn stringByReplacingOccurrencesOfString:@"dd" withString:day];
    rtn = [rtn stringByReplacingOccurrencesOfString:@"HH" withString:hour];
    rtn = [rtn stringByReplacingOccurrencesOfString:@"mm" withString:min];
    rtn = [rtn stringByReplacingOccurrencesOfString:@"ss" withString:second];
    
    return rtn;
}

+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

//为空转空串
+ (NSString *)isNullString:(NSString *)string{
    
    if ([string isEqual:[NSNull null]]) {
        return @"";
    }else if (string == nil || string == NULL) {
        return @"";
    }else if ([string isKindOfClass:[NSNull class]]) {
        return @"";
    }else if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return @"";
    }
    
    return string;
}

//移除后面的0
+(NSString *)removeZero:(double )dataDouble{
    NSString *tempString = [NSString stringWithFormat:@"%.2lf",dataDouble];
    return [self removeFloatAllZeroByString:tempString];
}

//显示千分位
+(NSString *)thousandsString:(NSString *)String{
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    numberFormatter.locale = [NSLocale currentLocale];// this ensure the right separator behavior
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    numberFormatter.usesGroupingSeparator = YES;
    NSNumber *numberFromString = [numberFormatter  numberFromString:String];
    NSString *desStr = [numberFormatter stringForObjectValue:numberFromString];
    
    if (![desStr containsString:@"."]) {
        desStr = [NSString stringWithFormat:@"%@.00",desStr];
    }
    
    return [self removeFloatAllZeroByString:desStr];
}


+(NSString*)removeFloatAllZeroByString:(NSString *)testNumber{
    NSString *Str = @"";
    NSInteger offset = testNumber.length - 1;
    while (offset){
        Str = [testNumber substringWithRange:NSMakeRange(offset, 1)];
        if ([Str isEqualToString:@"0"]){
            offset--;
        }else if ([Str isEqualToString:@"."]){
            offset--;
            break;
        }else{
            break;
        }
    }
    NSString *outNumber = [testNumber substringToIndex:offset+1];
    return outNumber;
}

extern BOOL isNull(id value)
{
    if (!value||[value isKindOfClass:[NSNull class]]) return YES;
    
    return NO;
}

@end
