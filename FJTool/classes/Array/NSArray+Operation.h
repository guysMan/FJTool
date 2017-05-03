//
//  NSArray+Operation.h
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Operation)

// Non-mutable Array
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
- (id)objectAtSafeIndex:(NSInteger)index;
- (BOOL)hasObject;

@end

@interface NSMutableArray (Operation)

// Mutable Array
- (void)removeFirstObject;
- (void)shuffle;
- (void)reverse;
- (void)mergeObjectsFromArray:(NSArray *)array;
- (void)removeDuplicateObjects;
- (void)subArrayTop:(NSInteger)top;
- (void)removeObjectAtSafeIndex:(NSInteger)index;

// Mutable Array
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
- (id)objectAtSafeIndex:(NSInteger)index;
- (BOOL)hasObject;

@end
