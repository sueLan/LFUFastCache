//
//  DList.m
//  LFUFastCache
//
//  Created by 蓝容 on 2019/6/23.
//  Copyright © 2019 RongLan. All rights reserved.
//

#import "DList.h"

@implementation DList

- (void)remove:(DLNode *)node {
    if (node == _head) _head = node.next;
    if (node == _tail) _tail = node.pre;
    
    node.pre.next = node.next;
    node.next.pre = node.pre;
    node.pre = nil;
    node.next = nil;
    
    _count--;
}

- (DLNode *)insert:(DLNode *)node beforeNode:(DLNode *)position {
    if (!position) {
        // at the end
        if (!_head) _head = node;
        if (!_tail) _tail = _head;
        
        _tail.next = node;
        node.pre = _tail;
        _tail = node;
    } else {
        position.pre.next = node;
        node.pre = position.pre;
        
        node.next = position;
        position.pre = node;
    }
    
    _count++;
    return node;
}

- (DLNode *)appendTailNode:(DLNode *)node {
    return [self insert:node beforeNode:nil];
}

- (DLNode *)insertHeadNode:(DLNode *)node {
    if (_head) {
        node.next = _head;
        node.pre = nil;
        _head.pre = node;
    }
    
    _head = node;
    _count++;
    return node;
}

- (void)clean {
    while (_head) {
        [_head clean];
        _head.pre = nil;
        DLNode *next = _head.next;
        _head.next = nil;
        _head = next;
        _count--;
    }
    _tail = nil;
}

@end
