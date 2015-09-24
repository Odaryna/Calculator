//
//  CalcSource.m
//  CalculatorOC
//
//  Created by Administrator on 8/26/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain ()

@property NSString* digit1;
@property NSString* digit2;
@property NSString* operation;

@end


@implementation CalculatorBrain

@synthesize digit1;
@synthesize digit2;
@synthesize operation;

static bool typing = false;

- (void)backspace
{
    if (self.digit2.length)
    {
        if ([self.digit2 isEqualToString:@"inf"] || [self.digit2 isEqualToString:@"nan"])
        {
            self.digit2= @"0";
        }
        else
        {
            if(![self.digit2 isEqualToString:@"0"] && self.digit2.length > 1)
            {
                self.digit2 = [self.digit2 substringToIndex:self.digit2.length - 1];
            }
            if(self.digit2.length==1)
            {
                self.digit2=@"0";
            }
        }
    }
    else
    {
        self.digit2 = @")";
    }
    
   
    [self.brainDelegate calculatorBrainDidChangeValue:digit2];
}

- (void)numberTapped:(NSString *)number
{
    if (typing)
    {
        self.digit2 = [self.digit2 stringByAppendingString:number];
    }
    else
    {
        self.digit2 = number;
        typing = true;
    }

    [self.brainDelegate calculatorBrainDidChangeValue:digit2];
    
}
- (void)operationTapped:(NSString *)oper
{
    
    if (self.operation.length && self.digit1.length && typing && self.digit2.length)
    {
       [self calculate];
    }
    
    if (self.digit2.length)
    {
        self.digit1 = self.digit2;
        self.operation = oper;
        typing = false;
        [self.brainDelegate calculatorBrainDidChangeValue:digit2];
    }
    
    self.digit2 = @"";

}

- (void)dotTapped{
    
    if (!self.digit2.length)
    {
        self.digit2 = @"0";
        typing = true;
    }
    if (([[self.digit2 componentsSeparatedByString:@"."] count] <= 1))
    {
        self.digit2 = [self.digit2 stringByAppendingString:@"."];
    }
     [self.brainDelegate calculatorBrainDidChangeValue:digit2];
}

- (void)calculate
{
    int i = [self binaryfunction:self.operation];
    switch (i)
    {
        case 0:
        {
            self.digit2 = [NSString stringWithFormat:@"%f", [self.digit1 doubleValue]+[self.digit2 doubleValue]];
            break;
        }
        case 1:
        {
           self.digit2 = [NSString stringWithFormat:@"%f", [self.digit1 doubleValue]-[self.digit2 doubleValue]];
            break;
        }
        case 2:
        {
           self.digit2 = [NSString stringWithFormat:@"%f", [self.digit1 doubleValue]*[self.digit2 doubleValue]];
            break;
        }
        case 3:
        {
            self.digit2 = [NSString stringWithFormat:@"%f", [self.digit1 doubleValue]/[self.digit2 doubleValue]];
            break;
        }
        default: break;
    }
    //toClear = false;
    typing = false;
    [self.brainDelegate calculatorBrainDidChangeValue:digit2];
    //self.digit1= @"";
}
- (void)clearTapped:(BOOL)all
{
    if (all)
    {
        self.digit1 = @"";
        self.operation = @"";
    }
    
    
    self.digit2 = @"";
    typing = false;
    [self.brainDelegate calculatorBrainDidChangeValue:digit2];
}

- (int)binaryfunction: (NSString *) str
{
    if ([str isEqualToString:@"➕"] )
    {
        return 0;
    }
    else if ([str isEqualToString:@"➖"])
    {
        return 1;
    }
    else if ([str isEqualToString:@"✖️"])
    {
        return 2;
    }
    else if ([str isEqualToString:@"➗"])
    {
        return 3;
    }
    
    return -1;
}

- (void)unaryfunction
{
   self.digit2 = [NSString stringWithFormat:@"%f", sqrt([self.digit2 doubleValue])];
   [self.brainDelegate calculatorBrainDidChangeValue:digit2];
}





@end