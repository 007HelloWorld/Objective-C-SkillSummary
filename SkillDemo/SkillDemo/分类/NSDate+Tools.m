//
//  NSDate+Tools.m
//  SkillDemo
//
//  Created by pjw on 2020/10/11.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "NSDate+Tools.h"

@implementation NSDate (Tools)

- (void)formatDateToEquation:(TimeZoneEquation) equation Year:(NSString **)year Month:(NSString **) month Day:(NSString **)day WeekDay:(NSString **)weekDay Hour:(NSString **) hour Minutes:(NSString **) minutes Second:(NSString **)second maxDaysInMonth:(NSString **)maxDays
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy"];
    NSInteger _year = [[dateFormatter stringFromDate:self] integerValue];
    
    [dateFormatter setDateFormat:@"MM"];
    NSInteger _month = [[dateFormatter stringFromDate:self] integerValue];
    
    [dateFormatter setDateFormat:@"dd"];
    NSInteger _day = [[dateFormatter stringFromDate:self] integerValue];
    
    [dateFormatter setDateFormat:@"HH"];
    NSInteger _hour = [[dateFormatter stringFromDate:self] integerValue];
    
    [dateFormatter setDateFormat:@"mm"];
    NSInteger _minutes = [[dateFormatter stringFromDate:self] integerValue];
    
    [dateFormatter setDateFormat:@"ss"];
    NSInteger _second = [[dateFormatter stringFromDate:self] integerValue];
    
    [dateFormatter setDateFormat:@"zzz"];
    
    NSLocale *cnLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setLocale:cnLocale];
    
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    [dateFormatter setCalendar:calendar];
    
    NSString *zzz1 = [[dateFormatter stringFromDate:self] stringByReplacingOccurrencesOfString:@"GMT" withString:@""];
    
    NSString *sign = ({
        NSString *sign;
        if(zzz1.length){
            sign = [zzz1 substringWithRange:NSMakeRange(0,1)];
        }
        else{
            sign = @"";
        }
        sign;
    });
    
    NSString *num = [[zzz1 stringByReplacingOccurrencesOfString:@"+" withString:@""] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSInteger fixHour;
    NSInteger fixMinutes;
    
    
    [dateFormatter setDateFormat:@"eee"];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    
    NSString *_week = [dateFormatter stringFromDate:self];
    NSInteger _weekFixValue = 0;
    
    NSInteger _maxDays = 0;
    
    if([num containsString:@":"]){
        NSArray *fixArray = [num componentsSeparatedByString:@":"];
        
        if([sign isEqualToString:@"+"]){
            fixHour = [fixArray[0] integerValue];
            fixMinutes = [fixArray[1] integerValue];
        }
        else if([sign isEqualToString:@"-"]){
            fixHour = - [fixArray[0] integerValue];
            fixMinutes = - [fixArray[1] integerValue];
        }
        else{
            fixHour = [fixArray[0] integerValue];
            fixMinutes = [fixArray[1] integerValue];
        }
    }
    else{
        if([sign isEqualToString:@"+"]){
            fixHour = num.integerValue;
        }
        else if([sign isEqualToString:@"-"]){
            fixHour = - num.integerValue;
        }
        else {
            fixHour = num.integerValue;
        }
        
        fixMinutes = 0;
    }
    
    CGFloat timeZoneFixValue = fixHour + fixMinutes / 60.0f;
    
    timeZoneFixValue = equation - timeZoneFixValue;
    
    if(fabs(timeZoneFixValue) > floor(fabs(timeZoneFixValue))){
        fixHour = floor(timeZoneFixValue);
        fixMinutes = (timeZoneFixValue - floor(timeZoneFixValue)) * 60;
    }
    else{
        fixHour = timeZoneFixValue;
        fixMinutes = 0;
    }
    
    _hour += fixHour;
    _minutes += fixMinutes;
    
    if(_minutes > 59){
        _minutes -= 60;
        _hour ++;
    }
    else if(_minutes < 0){
        _minutes += 60;
        _hour --;
    }
    
    if(_hour < 0){
        _day --;
        _weekFixValue --;
        _hour += 24;
    }
    else if(_hour > 23){
        _day ++;
        _weekFixValue ++;
        _hour -= 24;
    }
    
    BOOL leap = NO;
    
    if(_year % 100 == 0){
        if(_year % 400 == 0){
            leap = YES;
        }
    }
    else{
        if((_year % 4 == 0) && (_year % 100 != 0)){
            leap = YES;
        }
    }
    
    switch (_month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            if(_day > 31){
                _day = 1;
                _month = _month + 1 < 13 ? _month + 1 : 1;
                
                if(_month == 1){
                    _year ++;
                }
            }
            else if(_day < 1){
                _month = _month - 1 < 1 ? 12 : _month - 1;
                
                if(_month == 12){
                    _year --;
                }
                
                if(_month == 1 && _month == 3 && _month == 5 && _month == 7 && _month == 8 && _month == 10 && _month == 12){
                    _day = 31;
                }
                else if(_month == 4 && _month == 6 && _month == 9 && _month == 11){
                    _day = 30;
                }
                else if(_month == 2){
                    if(leap){
                        _day = 29;
                    }
                    else{
                        _day = 28;
                    }
                }
            }
            _maxDays = 31;
            break;
            
        case 4:
        case 6:
        case 9:
        case 11:
            if(_day == 31){
                _day = 1;
                _month ++;
            }
            else if(_day < 1){
                _day = 31;
                _month --;
            }
            _maxDays = 30;
            break;
            
        case 2:
        {
            if(leap){
                if(_day > 29){
                    _day = 1;
                    _month = 3;
                }
                else if(_day < 1){
                    _day = 31;
                    _month = 1;
                }
                _maxDays = 29;
            }
            else{
                if(_day > 28){
                    _day = 1;
                    _month = 3;
                }
                else if(_day < 1){
                    _day = 31;
                    _month = 1;
                }
                _maxDays = 28;
            }
        }
            break;
            
        default:
            break;
    }
    
    if(year){
        *year = [NSString stringWithFormat:@"%ld",_year];
    }
    
    if(month){
        if(_month < 10){
            *month = [NSString stringWithFormat:@"0%ld",_month];
        }
        else{
            *month = [NSString stringWithFormat:@"%ld",_month];
        }
    }
    
    if(day){
        if(_day < 10){
            *day = [NSString stringWithFormat:@"0%ld",_day];
        }
        else{
            *day = [NSString stringWithFormat:@"%ld",_day];
        }
    }
    
    if(hour){
        if(_hour < 10){
            *hour = [NSString stringWithFormat:@"0%ld",_hour];
        }
        else{
            *hour = [NSString stringWithFormat:@"%ld",_hour];
        }
    }
    
    if(minutes){
        if(_minutes < 10){
            *minutes = [NSString stringWithFormat:@"0%ld",_minutes];
        }
        else{
            *minutes = [NSString stringWithFormat:@"%ld",_minutes];
        }
    }
    
    if(second){
        if(_second < 10){
            *second = [NSString stringWithFormat:@"0%ld",_second];
        }
        else{
            *second = [NSString stringWithFormat:@"%ld",_second];
        }
    }
    
    if(weekDay){
        NSArray *weekdayAry = @[@"Sun",@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat"];
        NSInteger weekValue = [weekdayAry indexOfObject:_week] + _weekFixValue;
        weekValue = weekValue == 7 ? 0 : weekValue == -1 ? 6 : weekValue;
        *weekDay = [NSString stringWithFormat:@"%ld",weekValue];
    }
    
    if(maxDays){
        *maxDays = [NSString stringWithFormat:@"%ld",_maxDays];
    }
    
}

- (NSString *)stringWithFormatter:(NSString *)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    
    return [dateFormatter stringFromDate:self];
}

@end
