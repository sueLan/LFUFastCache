//
//  LFUNode.h
//  LFUFastCache
//
//  Created by 蓝容 on 2019/6/23.
//  Copyright © 2019 RongLan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLNode.h"
#import "DList.h"

@interface LFUItem : DLNode
@property (nonatomic, strong) id key;
@property (nonatomic, strong) id val;

- (instancetype)initWithKey:(id)key value:(id)value;
@end

@interface LFUNode : DLNode
@property (nonatomic) NSUInteger frequency;
@property (nonatomic, strong) DList *items;

- (instancetype)initWithFrequency:(NSUInteger)fre;
@end

@interface LFUIndexPair : NSObject
@property (nonatomic, strong) LFUNode* freNode;
@property (nonatomic, strong) LFUItem* itemNode;

- (instancetype)initWithFre:(LFUNode *)freNode item:(LFUItem *)itemNode;
@end
