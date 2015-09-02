//
//  ViewController.m
//  CalculatorOC
//
//  Created by Administrator on 8/25/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController () <CalculatorBrainProtocol>


@property (weak, nonatomic) IBOutlet UILabel *display;
@property CalculatorBrain* calc;
- (IBAction)performDigit:(UIButton *)sender;
- (IBAction)performOp:(UIButton *)sender;
- (IBAction)Equal;
- (IBAction)point;
- (IBAction)BS;
- (IBAction)allClear;
- (IBAction)Clear;
- (IBAction)unaryF;


@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.calc = [[CalculatorBrain alloc] init];
    self.calc.brainDelegate = self;
}

- (IBAction)performDigit:(UIButton *)sender{
    [self.calc numberTapped:sender.currentTitle];
    
}

- (IBAction)performOp:(UIButton *)sender
{
    [self.calc operationTapped:sender.currentTitle];
}

- (IBAction)Equal
{
    [self.calc calculate];
}


- (IBAction)point
{
    [self.calc dotTapped];
}

- (IBAction)BS
{
    [self.calc backspace];
}


- (IBAction)allClear
{
    [self.calc clearTapped:true];
}

- (IBAction)Clear
{
    [self.calc clearTapped:false];
}

- (IBAction)unaryF
{
    [self.calc unaryfunction];
}

#pragma mark - CalculatorBrainProtocol

- (void)calculatorBrainDidChangeValue:(NSString *)value
{
    self.display.text = value;
}

@end
