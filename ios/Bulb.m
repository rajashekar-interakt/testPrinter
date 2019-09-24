//
//  ding.m
//  Dprint
//
//  Created by lappy on 20/09/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(Bulb, NSObject)

RCT_EXTERN_METHOD(turnOn: (NSString *)value)

RCT_EXTERN_METHOD(turnOff)

RCT_EXTERN_METHOD(getPrinters);

RCT_EXTERN_METHOD(connectPrinter);

@end
