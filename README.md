# LFUFastCache
A iOS framework that implements an O(1) LFU (least frequently used) cache  algorithm.
## Basic 

The basic ideas comes from this [papar](http://dhruvbird.com/lfu.pdf). This algorithm has a runtime complexity of O(1) for each of the
operations (insertion, lookup and deletion) . This is achieved by maintaining 2 linked lists; one on the access frequency and one for all 
elements that have the same access frequency. A hash table is used to access elements by key.

## API

### Get method

```Objective-c
- (id)objectForKey:(id)key;
```

### Set method 

```Objective-c
- (void)setObject:(id)val forKey:(id)key;
```

### Release all cached object 
```Objective-c
// Must use this func to clean all cached objects before you release the cache object
- (void)clean;
```

## Example 
In the `LFUFastCacheTests.m`

```Objective-c
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
```    
