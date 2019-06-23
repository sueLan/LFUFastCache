//
//  LFUItem.m
//  LFUFastCache
//
//  Created by 蓝容 on 2019/6/23.
//  Copyright © 2019 RongLan. All rights reserved.
//

#import "LFUItem.h"

@implementation LFUItem

- (instancetype)initWithKey:(id)key value:(id)value
{
    if (self = [super init]) {
        _key = key;
        _val = value;
    }
    
    return self;
}

@end
