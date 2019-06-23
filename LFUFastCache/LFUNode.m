//
//  LFUNode.m
//  LFUFastCache
//
//  Created by 蓝容 on 2019/6/23.
//  Copyright © 2019 RongLan. All rights reserved.
//

#import "LFUNode.h"

@implementation LFUNode

- (instancetype)initWithFrequency:(NSUInteger)fre {
    if (self = [super init]) {
        _frequency = fre;
        _items = [DList new];
    }
    
    return self;
}

@end

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

@implementation LFUIndexPair

- (instancetype)initWithFre:(LFUNode *)freNode item:(LFUItem *)itemNode {
    if (self = [super init]) {
        _freNode = freNode;
        _itemNode = itemNode;
    }
    
    return self;
}

@end
