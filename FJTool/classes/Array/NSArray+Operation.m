//
//  NSArray+Operation.m
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "NSArray+Operation.h"

@implementation NSArray (Operation)

// Mutable Array
- (void)removeFirstObject {
    if ([self count]) {
        [(NSMutableArray*)self removeObjectAtIndex:0];
    }
}

- (void)shuffle {
    for (NSInteger i = (NSInteger)[self count] - 1; i > 0; i--) {
        NSUInteger j = (NSUInteger)arc4random_uniform((uint32_t)i + 1);
        [(NSMutableArray*)self exchangeObjectAtIndex:j withObjectAtIndex:(NSUInteger)i];
    }
}

- (void)reverse {
    [(NSMutableArray*)self setArray:[self reversedArray]];
}

- (void)mergeObjectsFromArray:(NSArray *)array {
    NSSet *set = [NSSet setWithArray:self];
    for (id object in array) {
        if (![set containsObject:object]) [(NSMutableArray*)self addObject:object];
    }
}

- (void)removeDuplicateObjects {
    [(NSMutableArray*)self setArray:[self uniqueObjects]];
}

- (void)subArrayTop:(NSInteger)top {
    if ([self count] <= top) {
        return;
    }
    
    for (int i = (int)[self count] - 1; i >= top; i--) {
        [(NSMutableArray*)self removeLastObject];
    }
}

// Mutable & non-mutable Array
- (NSArray *)arrayByRemovingObject:(id)object {
    NSMutableArray *copy = [NSMutableArray arrayWithArray:self];
    [copy removeObject:object];
    return copy;
}

- (NSArray *)arrayByRemovingObjectAtIndex:(NSUInteger)index {
    NSMutableArray *copy = [NSMutableArray arrayWithArray:self];
    [copy removeObjectAtIndex:index];
    return copy;
}

- (NSArray *)arrayByRemovingLastObject {
    if ([self count]) {
        NSMutableArray *copy = [NSMutableArray arrayWithArray:self];
        [copy removeObjectAtIndex:[self count] - 1];
        return copy;
    }
    return [NSArray arrayWithArray:self];
}

- (NSArray *)arrayByRemovingFirstObject {
    if ([self count]) {
        NSMutableArray *copy = [NSMutableArray arrayWithArray:self];
        [copy removeObjectAtIndex:0];
        return copy;
    }
    return [NSArray arrayWithArray:self];
}

- (NSArray *)arrayByInsertingObject:(id)object atIndex:(NSUInteger)index {
    NSMutableArray *copy = [NSMutableArray arrayWithArray:self];
    [copy insertObject:object atIndex:index];
    return copy;
}

- (NSArray *)arrayByReplacingObjectAtIndex:(NSUInteger)index withObject:(id)object {
    NSMutableArray *copy = [NSMutableArray arrayWithArray:self];
    copy[index] = object;
    return copy;
}

- (NSArray *)shuffledArray {
    NSMutableArray *copy = [NSMutableArray arrayWithArray:self];
    [copy shuffle];
    return copy;
}

- (NSArray *)mappedArrayUsingBlock:(id (^)(id object))block {
    if (block) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
        for (id object in self) {
            id replacement = block(object);
            if (replacement) [array addObject:replacement];
        }
        return array;
    }
    return [NSArray arrayWithArray:self];
}

- (NSArray *)reversedArray {
    return [[self reverseObjectEnumerator] allObjects];
}

- (NSArray *)arrayByMergingObjectsFromArray:(NSArray *)array {
    NSMutableArray *copy = [NSMutableArray arrayWithArray:self];
    [copy mergeObjectsFromArray:array];
    return copy;
}

- (NSArray *)objectsInCommonWithArray:(NSArray *)array {
    NSMutableOrderedSet *set = [NSMutableOrderedSet orderedSetWithArray:self];
    [set intersectSet:[NSSet setWithArray:array]];
    return [set array];
}

- (NSArray *)uniqueObjects {
    return [[NSOrderedSet orderedSetWithArray:self] array];
}

- (instancetype)objectAtIndexSafe:(NSInteger)index {
    
    if (self == nil || [self count] == 0 || [self count] <= index) {
        return nil;
    }else{
        return [self objectAtIndex:index];
    }
}

- (BOOL)hasObject {
    if (self == nil || [self count] == 0) {
        return NO;
    }
    return YES;
}

@end
