//
//  DLNode.h
//  LFUFastCache
//
//  Created by 蓝容 on 2019/6/23.
//  Copyright © 2019 RongLan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DLNode;

@interface DLNode : NSObject
@property (nonatomic, strong) DLNode *pre;
@property (nonatomic, strong) DLNode *next;
@end


