//
//  LFUItem.h
//  LFUFastCache
//
//  Created by 蓝容 on 2019/6/23.
//  Copyright © 2019 RongLan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DList.h"

NS_ASSUME_NONNULL_BEGIN

@interface LFUItem : NSObject

@property (nonatomic, strong) id key;
@property (nonatomic, strong) id val;

@end

NS_ASSUME_NONNULL_END
