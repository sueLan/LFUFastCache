//
//  LFUFastCache.m
//  LFUFastCache
//
//  Created by 蓝容 on 2019/6/23.
//  Copyright © 2019 RongLan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFUFastCache.h"
#import "DList.h"
#import "LFUNode.h"

static const NSUInteger kDefaultCapacity = 2;

@interface LFUFastCache ()

@property (nonatomic, strong) DList *freList;
@property (nonatomic, strong) NSMutableDictionary<id, LFUIndexPair*> *byKey;

@end

@implementation LFUFastCache

+ (instancetype)cache {
    static dispatch_once_t onceToken;
    static LFUFastCache *shareInstance;
    dispatch_once(&onceToken, ^{
        shareInstance = [[LFUFastCache alloc] initWithCapacity:kDefaultCapacity];
    });
    
    return shareInstance;
}

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    if (self = [super init]) {
        _capacity = capacity;
        _freList = [DList new];
        _byKey = [NSMutableDictionary new];
    }
    return self;
}

- (void)setCapacity:(NSUInteger)capacity {
    [self clean];
    _capacity = capacity;
}

- (id)objectForKey:(id)key {
    if (!_byKey[key]) return nil;
    
    id val = _byKey[key].itemNode.val;
    // update the frequency
    [self updateFrequncy:key value:val];
    return val;
}

- (void)setObject:(id)val forKey:(id)key {
    // invalid capacity
    if (_capacity <= 0) return;
    
    if (!_byKey[key]) {
        // remove least used item
        if (_byKey.count >= _capacity) [self remove];
        // add a new item
        [self insertNewItem:val forKey:key];
    } else {
        [self updateFrequncy:key value:val];
    }
    
}

- (void)updateFrequncy:(id)key value:(id)val {
    LFUNode *node = _byKey[key].freNode;
    LFUItem *item = _byKey[key].itemNode;
    NSUInteger fre = node.frequency + 1;
    LFUNode *nextNode = (LFUNode *)node.next;
    
    // remove item from the old item list
    [node.items remove:item];
    // remove frequency node from the list if it contains no items
    if (node.items.count == 0) [_freList remove:node];
    
    // insert a new frequency node into the freList if the current next node is not the right one
    if (!nextNode || nextNode.frequency != fre) {
        nextNode = (LFUNode *)[_freList insert:[[LFUNode alloc] initWithFrequency:fre] beforeNode:nextNode];
    }
    
    item = (LFUItem *)[nextNode.items appendTailNode:[[LFUItem alloc] initWithKey:key value:val]];
    _byKey[key] = [[LFUIndexPair alloc] initWithFre:nextNode item:item];
}

- (void)insertNewItem:(id)val forKey:(id)key {
    // add the new fre node at the front of the fre queue
    LFUNode* head = (LFUNode *)_freList.head;
    if (!head || head.frequency != 1) {
        head = (LFUNode *)[_freList insertHeadNode:[[LFUNode alloc] initWithFrequency:1]];
    }
    LFUItem* item = (LFUItem *)[head.items appendTailNode:[[LFUItem alloc] initWithKey:key value:val]];
    _byKey[key] = [[LFUIndexPair alloc] initWithFre:head item:item];
}

- (void)remove {
    // find the least userd item
    LFUNode *node = (LFUNode *)_freList.head;
    LFUItem *item = (LFUItem *)node.items.head;
    // remove item from list
    id key = item.key;
    [node.items remove:item];
    [_byKey removeObjectForKey:key];
    
    if (node.items.count == 0) {
        // remove list node by the key
        [_freList remove:node];
    }
}

- (void)clean {
    [_freList clean];
    [_byKey removeAllObjects];
}

@end
