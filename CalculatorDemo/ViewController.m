//
//  ViewController.m
//  CalculatorDemo
//
//  Created by BoTingDing on 2018/11/8.
//  Copyright © 2018年 btding. All rights reserved.
//

#import "ViewController.h"
#import "InfixCalculator.h"
#import "NSString+ReversedString.h"
@interface ViewController ()

@end

@implementation ViewController
    NSString *lastOperator;
    NSString *current = @"0";
    NSString *lastOperand;
    NSString *inFixCurrent = @"0";
    NSString *mr = @"0";
    BOOL isMultipleClickedOpeartor = false;
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)reversedAction:(id)sender {
    self.reversedText.text = self.inputTextField.text.reversedString;
    [self.inputTextField resignFirstResponder];
}

- (IBAction)buttonAction:(UIButton *)sender {
    isMultipleClickedOpeartor = false;
    if ([current length] == 9) {
        return;
    }
    if ([sender.titleLabel.text isEqualToString:@"."] && !([current rangeOfString:@"."].location == NSNotFound)) {
        return;
    }
    if ([current isEqualToString:@"0"]) {
        if ([sender.titleLabel.text isEqualToString:@"0"]) {
            return;
        }
        if (![sender.titleLabel.text isEqualToString:@"."]) {
            current = @"";
        }
    }
    if ([sender.titleLabel.text isEqualToString:@"+-"]) {
        if ([self.inputLabel.text rangeOfString:@"-"].location ==NSNotFound) {
            current = [@"-" stringByAppendingString:self.inputLabel.text];
        } else {
            current = [self.inputLabel.text substringFromIndex:1];
        }
        
    } else {
    current = [current stringByAppendingString:sender.titleLabel.text];
    }
    self.inputLabel.text = current;
    NSLog(@"postfix current: %@", inFixCurrent);
}

- (IBAction)truncateAction:(UIButton *)sender {
    NSString *str = self.inputLabel.text;
    if ([str isEqualToString:@"NaN"]) {
        str = @"0";
        inFixCurrent = @"0";
    }
    else if ([str length] > 1) {
        str = [str substringToIndex:[str length] -1];
    } else {
        str = @"0";
        inFixCurrent = @"0";
    }
    self.inputLabel.text = str;
    current = str;
}

- (IBAction)operatorAction:(UIButton *)sender {
    if ([inFixCurrent isEqualToString:@"0"] && [sender.titleLabel.text isEqualToString:@"="]) {
        return;
    }
    if ([sender.titleLabel.text isEqualToString:@"="]) {
        inFixCurrent = [inFixCurrent stringByAppendingString:self.inputLabel.text];
        InfixCalculator *calculator = [[InfixCalculator alloc] init];
        NSDecimalNumber *postfixNumber = [calculator computeExpression:inFixCurrent];
        current = [NSString stringWithFormat:@"%@", postfixNumber];
        if (![current isEqualToString:@"(null)"]) {
            self.inputLabel.text = current;
        }
        current = @"";
        inFixCurrent = @"0";
        return;
    }
    if (isMultipleClickedOpeartor == YES) {
        NSString *lastChar = [inFixCurrent substringFromIndex:[inFixCurrent length] - 1];
            if ([self isKindOfOperator:lastChar]) {
                inFixCurrent = [inFixCurrent substringToIndex:[inFixCurrent length] -1];
            }
            inFixCurrent = [inFixCurrent stringByAppendingString:sender.titleLabel.text];
        return;
    } else {
        inFixCurrent = [inFixCurrent stringByAppendingString:self.inputLabel.text];
        isMultipleClickedOpeartor = YES;
    }
        inFixCurrent = [inFixCurrent stringByAppendingString:sender.titleLabel.text];

    InfixCalculator *calculator = [[InfixCalculator alloc] init];
    NSDecimalNumber *postfixNumber = [calculator computeExpression:inFixCurrent];
    current = [NSString stringWithFormat:@"%@", postfixNumber];
    if (![current isEqualToString:@"(null)"]) {
        self.inputLabel.text = current;
    }
    current = @"";
    if ([sender.titleLabel.text isEqualToString:@"="]) {
        inFixCurrent = @"0";
        return;
    }
    NSLog(@"postfix current: %@", inFixCurrent);
}

- (BOOL)isKindOfOperator:(NSString*)sender {
    NSString *list = @"+-/*";
    return !([list rangeOfString:sender].location == NSNotFound);
}

- (IBAction)mOperationAction:(UIButton *)sender {
    NSString *senderText = sender.titleLabel.text;
    current = @"";
    if ([senderText isEqualToString:@"MC"]) {
        mr = @"0";
    } else if ([senderText isEqualToString:@"M+"]) {
        NSDecimalNumber *mrNumber = [NSDecimalNumber decimalNumberWithString:mr];
        NSDecimalNumber *currentNumber = [NSDecimalNumber decimalNumberWithString:self.inputLabel.text];
        mr = [NSString stringWithFormat:@"%@",[mrNumber decimalNumberByAdding:currentNumber]];
        
    } else if ([senderText isEqualToString:@"M-"]) {
        NSDecimalNumber *mrNumber = [NSDecimalNumber decimalNumberWithString:mr];
        NSDecimalNumber *currentNumber = [NSDecimalNumber decimalNumberWithString:self.inputLabel.text];
        mr = [NSString stringWithFormat:@"%@",[mrNumber decimalNumberBySubtracting:currentNumber]];
    } else {
        self.inputLabel.text = mr;
    }
}


@end
