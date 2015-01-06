//
//  BNRItemStore.h
//  Homepwner
//
//  Created by qingpei on 1/5/15.
//  Copyright (c) 2015 qingpei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject

@property(nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;
- (BNRItem *)createItem;

@end
