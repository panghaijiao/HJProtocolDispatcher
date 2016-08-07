//
//  ProtocolDispatcher.m
//  Demo
//
//  Created by haijiao on 16/7/26.
//  Copyright © 2016年 olinone. All rights reserved.
//

#import "ProtocolDispatcher.h"
#import <objc/runtime.h>

struct objc_method_description MethodDescriptionForSELInProtocol(Protocol *protocol, SEL sel) {
    struct objc_method_description description = protocol_getMethodDescription(protocol, sel, YES, YES);
    if (description.types) {
        return description;
    }
    description = protocol_getMethodDescription(protocol, sel, NO, YES);
    if (description.types) {
        return description;
    }
    return (struct objc_method_description){NULL, NULL};
}

BOOL ProtocolContainSel(Protocol *protocol, SEL sel) {
    return MethodDescriptionForSELInProtocol(protocol, sel).types ? YES: NO;
}


@interface ImplemertorContext : NSObject

@property (nonatomic, weak) id implemertor;

@end

@implementation ImplemertorContext

@end


@interface ProtocolDispatcher ()

@property (nonatomic, strong) Protocol *prococol;
@property (nonatomic, strong) NSArray *implemertors;

@end

@implementation ProtocolDispatcher

+ (id)dispatcherProtocol:(Protocol *)protocol toImplemertors:(NSArray *)implemertors {
    return [[ProtocolDispatcher alloc] initWithProtocol:protocol toImplemertors:implemertors];
}

- (instancetype)initWithProtocol:(Protocol *)protocol toImplemertors:(NSArray *)implemertors {
    if (self = [super init]) {
        self.prococol = protocol;
        NSMutableArray *implemertorContexts = [NSMutableArray arrayWithCapacity:implemertors.count];
        [implemertors enumerateObjectsUsingBlock:^(id implemertor, NSUInteger idx, BOOL * _Nonnull stop) {
            ImplemertorContext *implemertorContext = [ImplemertorContext new];
            implemertorContext.implemertor = implemertor;
            [implemertorContexts addObject:implemertorContext];
            objc_setAssociatedObject(implemertor, _cmd, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }];
        self.implemertors = implemertorContexts;
    }
    return self;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if (!ProtocolContainSel(self.prococol, aSelector)) {
        return [super respondsToSelector:aSelector];
    }
    
    for (ImplemertorContext *implemertorContext in self.implemertors) {
        if ([implemertorContext.implemertor respondsToSelector:aSelector]) {
            return YES;
        }
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (!ProtocolContainSel(self.prococol, aSelector)) {
        return [super methodSignatureForSelector:aSelector];
    }
    
    struct objc_method_description methodDescription = MethodDescriptionForSELInProtocol(self.prococol, aSelector);
    return [NSMethodSignature signatureWithObjCTypes:methodDescription.types];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL aSelector = anInvocation.selector;
    if (!ProtocolContainSel(self.prococol, aSelector)) {
        [super forwardInvocation:anInvocation];
        return;
    }
    
    for (ImplemertorContext *implemertorContext in self.implemertors) {
        if ([implemertorContext.implemertor respondsToSelector:aSelector]) {
            [anInvocation invokeWithTarget:implemertorContext.implemertor];
        }
    }
}

@end
