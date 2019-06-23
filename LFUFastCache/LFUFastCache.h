//
//  LFUFastCache.h
//  LFUFastCache
//
//  Created by 蓝容 on 2019/6/23.
//  Copyright © 2019 RongLan. All rights reserved.
//

#import <UIKit/UIKit.h>
//! Project version number for LFUFastCache.
FOUNDATION_EXPORT double LFUFastCacheVersionNumber;

@interface LFUFastCache : NSObject

@property (nonatomic) NSUInteger capacity;

+ (instancetype)cache;

- (id)objectForKey:(id)key;
- (void)setObject:(id)val forKey:(id)key;

- (void)clean;

@end
//! Project version string for LFUFastCache.
FOUNDATION_EXPORT const unsigned char LFUFastCacheVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <LFUFastCache/PublicHeader.h>


