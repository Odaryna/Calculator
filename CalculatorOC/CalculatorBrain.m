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

- (NSString*) validateResult;
- (int) binaryfunction: (NSString *)str;

@end


@implementation CalculatorBrain

@synthesize digit1;
@synthesize digit2;
@synthesize operation;

static bool typing = false;

- (NSString*) validateResult
{
    NSRange range = [self.digit2 rangeOfString:@"."];
    if (range.location != NSNotFound)
    {
        NSString *part2 = [self.digit2 substringFromIndex:range.location];
        
        if ([part2 length] >= 1)
        {
            NSInteger last = [part2 length] - 1;
        
            while (true)
            {
                NSString* digit = [part2 substringWithRange:NSMakeRange(last, 1)];
                if ([digit isEqualToString:@"0"])
                {
                   [self backspace];
                }
                else
                {
                  break;
                }
                last--;
                if (last == 0) break;
            }
            
            
        }
        
        
        if ([[self.digit2 substringFromIndex:[self.digit2 length] - 1] isEqualToString:@"."])
        {
            [self backspace];
        }
    }
    
    return self.digit2;
}



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
            if (self.digit2.length == 1)
            {
                self.digit2=@"0";
            }
            
            if ( ![self.digit2 isEqualToString:@"0"] && self.digit2.length > 1)
            {
                self.digit2 = [self.digit2 substringToIndex:self.digit2.length - 1];
            }

        }
    }
    else
    {
        self.digit2 = @"0";
    }
    
   
    [self.brainDelegate calculatorBrainDidChangeValue:self.digit2];
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

    [self.brainDelegate calculatorBrainDidChangeValue:self.digit2];
    
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
        [self.brainDelegate calculatorBrainDidChangeValue:self.digit2];
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
     [self.brainDelegate calculatorBrainDidChangeValue:self.digit2];
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

    typing = false;
    [self.brainDelegate calculatorBrainDidChangeValue:[self validateResult]];

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
    [self.brainDelegate calculatorBrainDidChangeValue:@"0"];
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
   [self.brainDelegate calculatorBrainDidChangeValue:[self validateResult]];
}





@end