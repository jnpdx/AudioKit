//
//  AKLineTests.m
//  iOSObjectiveCAudioKit
//
//  Created by Aurelius Prochazka on 5/22/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

#import "AKTestCase.h"

#define testDuration 10.0

@interface TestLineInstrument : AKInstrument
@end

@implementation TestLineInstrument

- (instancetype)init
{
    self = [super init];
    if (self) {


        AKLine *line = [[AKLine alloc] init];
        line.secondPoint = akp(100);

        AKOscillator *oscillator = [AKOscillator oscillator];
        oscillator.frequency = line;

        [self setAudioOutput:oscillator];
    }
    return self;
}

@end

@interface AKLineTests : AKTestCase
@end

@implementation AKLineTests

- (void)testLine
{
    // Set up performance
    TestLineInstrument *testInstrument = [[TestLineInstrument alloc] init];
    [AKOrchestra addInstrument:testInstrument];
    [testInstrument playForDuration:testDuration];

    // Check output
    NSArray *validMD5s = @[@"4db5ab4d614c0d674ea27e02cf1479fc",
                           @"bb6c59ff9937cf4b0af5b110493aabc6"];
    XCTAssertTrue([validMD5s containsObject:[self md5ForOutputWithDuration:testDuration]]);
}

@end
