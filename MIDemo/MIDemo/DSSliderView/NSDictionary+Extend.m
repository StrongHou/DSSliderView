//
//  NSDictionary+Extend.m
//  MIDemo
//
//  Created by houxq on 2017/6/12.
//  Copyright © 2017年 houxq. All rights reserved.
//

#import "NSDictionary+Extend.h"

@implementation NSDictionary (Extend)

- (NSDictionary *)ds_dictionaryWithReplenishDictionary:(NSDictionary *)dictionary
{
    
    if(!dictionary) return self;
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:self];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        mutableDict[key] = obj;
    }];
    return [mutableDict copy];
}
@end
