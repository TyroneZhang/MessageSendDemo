//
//  Person.m
//  MessageSendDemo
//
//  Created by Tyrone Zhang on 6/24/15.
//  Copyright (c) 2015 augmentum. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import "Car.h"

@implementation Person

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    
    return self;
}

//================== for all
void handleAllMehod(id self,SEL _cmd)
{
    NSLog(@"%@   %s",self, sel_getName(_cmd));
}

/* =================== solution one
 *
 * + (BOOL)resolveInstanceMethod:(SEL)sel
 *
 * + (BOOL)resolveClassMethod:(SEL)sel
 *
 */

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
#if USE_SOLUTION_ONE
    
    if (sel == @selector(instanceMethod_run)) {
        class_addMethod(self, sel, (IMP)handleAllMehod, "v@:");
        return YES;
    }
    
#endif
    
    return [super resolveInstanceMethod:sel];
}

+ (BOOL)resolveClassMethod:(SEL)sel
{
    return [super resolveClassMethod:sel];
}


/* =================== solution two
 *
 * - (id)forwardingTargetForSelector:(SEL)aSelector
 *
 */

#if USE_SOLUTION_TWO

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return [[Car alloc] init];
}

#endif


/* =================== solution three
 *
 * - (NSMethodSignature)methodSignatureForSelector:(SEL)aSelector
 *
 * - (void)forwardInvocaiton:(NSInvocation *)anInvocation
 *
 */

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSString *selString = NSStringFromSelector(aSelector);
    if ([selString isEqualToString:@"instanceMethod_run"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return  [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL selector = [anInvocation selector];
    Car *car = [[Car alloc] init];
    if ([car respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:car];
    }
}

@end
