//
//  ProtocolDispatcher.h
//  Demo
//
//  Created by haijiao on 16/7/26.
//  Copyright © 2016年 olinone. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AOProtocolDispatcher(__protocol__, ...)  \
    [ProtocolDispatcher dispatcherProtocol:@protocol(__protocol__)  \
                            toImplemertors:[NSArray arrayWithObjects:__VA_ARGS__, nil]]

@interface ProtocolDispatcher : NSObject

+ (id)dispatcherProtocol:(Protocol *)protocol toImplemertors:(NSArray *)implemertors;

@end
