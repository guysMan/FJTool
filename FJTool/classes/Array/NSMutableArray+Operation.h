//
//  NSMutableArray+Operation.h
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Operation)

// Mutable Array
- (void)removeFirstObject;
- (void)shuffle;
- (void)reverse;
- (void)mergeObjectsFromArray:(NSArray *)array;
- (void)removeDuplicateObjects;
- (void)subArrayTop:(NSInteger)top;


// Mutable & non-mutable Array
- (NSArray *)arrayByRemovingObject:(id)object;
- (NSArray *)arrayByRemovingObjectAtIndex:(NSUInteger)index;
- (NSArray *)arrayByRemovingLastObject;
- (NSArray *)arrayByRemovingFirstObject;
- (NSArray *)arrayByInsertingObject:(id)object atIndex:(NSUInteger)index;
- (NSArray *)arrayByReplacingObjectAtIndex:(NSUInteger)index withObject:(id)object;
- (NSArray *)shuffledArray;
- (NSArray *)mappedArrayUsingBlock:(id (^)(id object))block;
- (NSArray *)reversedArray;
- (NSArray *)arrayByMergingObjectsFromArray:(NSArray *)array;
- (NSArray *)objectsInCommonWithArray:(NSArray *)array;
- (NSArray *)uniqueObjects;
- (instancetype)objectAtIndexSafe:(NSInteger)index;
- (BOOL)hasObject;

@end
