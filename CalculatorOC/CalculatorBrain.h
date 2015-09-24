//
//  Calculator.h
//  CalculatorOC
//
//  Created by Administrator on 8/26/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CalculatorBrainProtocol <NSObject>

- (void)calculatorBrainDidChangeValue:(NSString *)value;

@end

@interface CalculatorBrain : NSObject

- (void)numberTapped:(NSString *)number;
- (void)operationTapped:(NSString*)oper;
- (void)dotTapped;
- (void)calculate; // When = tapped
- (void)clearTapped:(BOOL)all;
- (void)backspace;

- (void) unaryfunction;

@property (nonatomic, weak) NSObject <CalculatorBrainProtocol> *brainDelegate;

@end
