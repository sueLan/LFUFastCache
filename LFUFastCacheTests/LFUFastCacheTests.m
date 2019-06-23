//
//  LFUFastCacheTests.m
//  LFUFastCacheTests
//
//  Created by 蓝容 on 2019/6/23.
//  Copyright © 2019 RongLan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LFUFastCache.h"

@interface LFUFastCacheTests : XCTestCase

@end

@implementation LFUFastCacheTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    [[LFUFastCache cache] clean];
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSArray<NSArray<NSNumber *>*> *testNums = @[@[@10,@13],@[@3,@17],@[@6,@11],@[@10,@5],@[@9,@10],@[@13],@[@2,@19],@[@2],@[@3],@[@5,@25],@[@8],@[@9,@22],@[@5,@5],@[@1,@30],@[@11],@[@9,@12],@[@7],@[@5],@[@8],@[@9],@[@4,@30],@[@9,@3],@[@9],@[@10],@[@10],@[@6,@14],@[@3,@1],@[@3],@[@10,@11],@[@8],@[@2,@14],@[@1],@[@5],@[@4],@[@11,@4],@[@12,@24],@[@5,@18],@[@13],@[@7,@23],@[@8],@[@12],@[@3,@27],@[@2,@12],@[@5],@[@2,@9],@[@13,@4],@[@8,@18],@[@1,@7],@[@6],@[@9,@29],@[@8,@21],@[@5],@[@6,@30],@[@1,@12],@[@10],@[@4,@15],@[@7,@22],@[@11,@26],@[@8,@17],@[@9,@29],@[@5],@[@3,@4],@[@11,@30],@[@12],@[@4,@29],@[@3],@[@9],@[@6],@[@3,@4],@[@1],@[@10],@[@3,@29],@[@10,@28],@[@1,@20],@[@11,@13],@[@3],@[@3,@12],@[@3,@8],@[@10,@9],@[@3,@26],@[@8],@[@7],@[@5],@[@13,@17],@[@2,@27],@[@11,@15],@[@12],@[@9,@19],@[@2,@15],@[@3,@16],@[@1],@[@12,@17],@[@9,@1],@[@6,@19],@[@4],@[@5],@[@5],@[@8,@1],@[@11,@7],@[@5,@2],@[@9,@28],@[@1],@[@2,@2],@[@7,@4],@[@4,@22],@[@7,@24],@[@9,@26],@[@13,@28],@[@11,@26]];
    NSArray<NSNumber *> *ans = @[@0,@0,@0,@0,@0,@-1,@0,@19,@17,@0,@-1,@0,@0,@0,@-1,@0,@-1,@5,@-1,@12,@0,@0,@3,@5,@5,@0,@0,@1,@0,@-1,@0,@30,@5,@30,@0,@0,@0,@-1,@0,@-1,@24,@0,@0,@18,@0,@0,@0,@0,@14,@0,@0,@18,@0,@0,@11,@0,@0,@0,@0,@0,@18,@0,@0,@-1,@0,@4,@29,@30,@0,@12,@11,@0,@0,@0,@0,@29,@0,@0,@0,@0,@17,@-1,@18,@0,@0,@0,@-1,@0,@0,@0,@20,@0,@0,@0,@29,@18,@18,@0,@0,@0,@0,@20,@0,@0,@0,@0,@0,@0,@0];
    [LFUFastCache cache].capacity = 10;
    [testNums enumerateObjectsUsingBlock:^(NSArray* nums, NSUInteger idx, BOOL * _Nonnull stop) {
        if (nums.count == 2) {
            // set
            [[LFUFastCache cache] setObject:nums[1] forKey:nums[0]];
        } else {
            // get
            NSNumber *val = [[LFUFastCache cache] objectForKey:nums[0]];
            XCTAssertEqual(val ? val.integerValue : -1, ans[idx].integerValue, "error idx");
        }
    }];
 }

- (void)testSetPerformanceExample {
    // This is an example of a performance test case.
    [LFUFastCache cache].capacity = 1000;
    NSMutableArray<NSArray *> *nums;
    for (int i = 0; i < 1000000; i++) {
        [nums addObject:@[@(arc4random_uniform(200)+1), @(arc4random_uniform(200)+1)]];
    }
    
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        [nums enumerateObjectsUsingBlock:^(NSArray *num, NSUInteger idx, BOOL *stop) {
            [[LFUFastCache cache] setObject:num[0] forKey:num[1]];
        }];
    }];
}

- (void)testGetPerformanceExample {
    // This is an example of a performance test case.
    NSMutableArray<NSArray *> *nums;
    for (int i = 0; i < 1000000; i++) {
        [nums addObject:@[@(arc4random_uniform(200)+1)]];
    }
    
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        [nums enumerateObjectsUsingBlock:^(NSArray *num, NSUInteger idx, BOOL *stop) {
            [[LFUFastCache cache] objectForKey:num[0]];
        }];
    }];
}

@end
