//
//  DList.h
//  LFUFastCache
//
//  Created by 蓝容 on 2019/6/23.
//  Copyright © 2019 RongLan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLNode.h"

@interface DList : NSObject

@property (nonatomic) NSUInteger count;
@property (nonatomic, strong) DLNode *head;
@property (nonatomic, strong) DLNode *tail;

- (DLNode *)insert:(DLNode *)node beforeNode:(DLNode *)position;
- (DLNode *)insertHeadNode:(DLNode *)node;
- (DLNode *)appendTailNode:(DLNode *)node;

- (void)remove:(DLNode *)node;

- (void)clean;

@end

