//
//  NSArray+Operation.m
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "NSArray+Operation.h"

@implementation NSObject (Operation)

- (NSArray *)common_arrayByRemovingObject:(id)object {
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    NSMutableArray *copy = [NSMutableArray arrayWithArray:(NSArray *)self];
    [copy removeObject:object];
    return copy;
}

- (NSArray *)common_arrayByRemovingObjectAtIndex:(NSUInteger)index {
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    NSMutableArray *copy = [NSMutableArray arrayWithArray:(NSArray *)self];
    [copy removeObjectAtIndex:index];
    return copy;
}

- (NSArray *)common_arrayByRemovingLastObject {
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    if ([(NSArray *)self count]) {
        NSMutableArray *copy = [NSMutableArray arrayWithArray:(NSArray *)self];
        [copy removeObjectAtIndex:[(NSArray *)self count] - 1];
        return copy;
    }
    return [NSArray arrayWithArray:(NSArray *)self];
}

- (NSArray *)common_arrayByRemovingFirstObject {
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    if ([(NSArray *)self count]) {
        NSMutableArray *copy = [NSMutableArray arrayWithArray:(NSArray *)self];
        [copy removeObjectAtIndex:0];
        return copy;
    }
    return [NSArray arrayWithArray:(NSArray *)self];
}

- (NSArray *)common_arrayByInsertingObject:(id)object atIndex:(NSUInteger)index {
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    NSMutableArray *copy = [NSMutableArray arrayWithArray:(NSArray *)self];
    [copy insertObject:object atIndex:index];
    return copy;
}

- (NSArray *)common_arrayByReplacingObjectAtIndex:(NSUInteger)index withObject:(id)object {
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    NSMutableArray *copy = [NSMutableArray arrayWithArray:(NSArray *)self];
    copy[index] = object;
    return copy;
}

- (NSArray *)common_shuffledArray {
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    NSMutableArray *copy = [NSMutableArray arrayWithArray:(NSArray *)self];
    [copy shuffle];
    return copy;
}

- (NSArray *)common_mappedArrayUsingBlock:(id (^)(id object))block {
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    if (block) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[(NSArray *)self count]];
        for (id object in (NSArray *)self) {
            id replacement = block(object);
            if (replacement) [array addObject:replacement];
        }
        return array;
    }
    return [NSArray arrayWithArray:(NSArray *)self];
}

- (NSArray *)common_reversedArray {
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    return [[(NSArray *)self reverseObjectEnumerator] allObjects];
}

- (NSArray *)common_arrayByMergingObjectsFromArray:(NSArray *)array {
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    NSMutableArray *copy = [NSMutableArray arrayWithArray:(NSArray *)self];
    [copy mergeObjectsFromArray:array];
    return copy;
}

- (NSArray *)common_objectsInCommonWithArray:(NSArray *)array {
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    NSMutableOrderedSet *set = [NSMutableOrderedSet orderedSetWithArray:(NSArray *)self];
    [set intersectSet:[NSSet setWithArray:array]];
    return [set array];
}

- (NSArray *)common_uniqueObjects {
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    return [[NSOrderedSet orderedSetWithArray:(NSArray *)self] array];
}

- (id)common_objectAtSafeIndex:(NSInteger)index {
    if ((NSArray *)self == nil || [(NSArray *)self count] == 0 || [(NSArray *)self count] <= index) {
        return nil;
    }else{
        return [(NSArray *)self objectAtIndex:index];
    }
}

- (BOOL)common_hasObject {
    if (![self isKindOfClass:[NSArray class]]) {
        return NO;
    }
    if ((NSArray *)self == nil || [(NSArray *)self count] == 0) {
        return NO;
    }
    return YES;
}

@end

@implementation NSArray (Operation)

// Non-mutable Array (Common)
- (NSArray *)arrayByRemovingObject:(id)object {
    return [self common_arrayByRemovingObject:object];
}

- (NSArray *)arrayByRemovingObjectAtIndex:(NSUInteger)index {
    return [self common_arrayByRemovingObjectAtIndex:index];
}

- (NSArray *)arrayByRemovingLastObject {
    return [self common_arrayByRemovingLastObject];
}

- (NSArray *)arrayByRemovingFirstObject {
    return [self common_arrayByRemovingFirstObject];
}

- (NSArray *)arrayByInsertingObject:(id)object atIndex:(NSUInteger)index {
    return [self common_arrayByInsertingObject:object atIndex:index];
}

- (NSArray *)arrayByReplacingObjectAtIndex:(NSUInteger)index withObject:(id)object {
    return [self common_arrayByReplacingObjectAtIndex:index withObject:object];
}

- (NSArray *)shuffledArray {
    return [self common_shuffledArray];
}

- (NSArray *)mappedArrayUsingBlock:(id (^)(id object))block {
    return [self common_mappedArrayUsingBlock:block];
}

- (NSArray *)reversedArray {
    return [self common_reversedArray];
}

- (NSArray *)arrayByMergingObjectsFromArray:(NSArray *)array {
    return [self common_arrayByMergingObjectsFromArray:array];
}

- (NSArray *)objectsInCommonWithArray:(NSArray *)array {
    return [self common_objectsInCommonWithArray:array];
}

- (NSArray *)uniqueObjects {
    return [self common_uniqueObjects];
}

- (id)objectAtSafeIndex:(NSInteger)index {
    return [self common_objectAtSafeIndex:index];
}

- (BOOL)hasObject {
    return [self common_hasObject];
}

@end

@implementation NSMutableArray (Operation)

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

- (void)removeObjectAtSafeIndex:(NSInteger)index {
    if (![self isKindOfClass:[NSMutableArray class]]) {
        return;
    }
    if (index < 0 || index >= self.count) {
        return;
    }
    [self removeObjectAtIndex:index];
}

// Mutable Array (Common)
- (NSArray *)arrayByRemovingObject:(id)object {
    return [self common_arrayByRemovingObject:object];
}

- (NSArray *)arrayByRemovingObjectAtIndex:(NSUInteger)index {
    return [self common_arrayByRemovingObjectAtIndex:index];
}

- (NSArray *)arrayByRemovingLastObject {
    return [self common_arrayByRemovingLastObject];
}

- (NSArray *)arrayByRemovingFirstObject {
    return [self common_arrayByRemovingFirstObject];
}

- (NSArray *)arrayByInsertingObject:(id)object atIndex:(NSUInteger)index {
    return [self common_arrayByInsertingObject:object atIndex:index];
}

- (NSArray *)arrayByReplacingObjectAtIndex:(NSUInteger)index withObject:(id)object {
    return [self common_arrayByReplacingObjectAtIndex:index withObject:object];
}

- (NSArray *)shuffledArray {
    return [self common_shuffledArray];
}

- (NSArray *)mappedArrayUsingBlock:(id (^)(id object))block {
    return [self common_mappedArrayUsingBlock:block];
}

- (NSArray *)reversedArray {
    return [self common_reversedArray];
}

- (NSArray *)arrayByMergingObjectsFromArray:(NSArray *)array {
    return [self common_arrayByMergingObjectsFromArray:array];
}

- (NSArray *)objectsInCommonWithArray:(NSArray *)array {
    return [self common_objectsInCommonWithArray:array];
}

- (NSArray *)uniqueObjects {
    return [self common_uniqueObjects];
}

- (id)objectAtSafeIndex:(NSInteger)index {
    return [self common_objectAtSafeIndex:index];
}

- (BOOL)hasObject {
    return [self common_hasObject];
}

@end


