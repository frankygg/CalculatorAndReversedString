//
//  NSString+ReversedString.m
//  CalculatorDemo
//
//  Created by BoTingDing on 2018/11/12.
//  Copyright © 2018年 btding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+ReversedString.h"

@implementation NSString(ReversedString)
    -(NSString *)reversedString{
        
        NSString *result = @"";
        
        NSInteger charIndex = [self length];
        while (charIndex > 0) {
            charIndex--;
            NSRange subStrRange = NSMakeRange(charIndex, 1);
            result = [result stringByAppendingString:[self substringWithRange:subStrRange]];
        }
        return result;
    }

@end
