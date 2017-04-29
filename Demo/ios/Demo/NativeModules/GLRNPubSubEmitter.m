//
//  GLRNPubSubEmitter.m
//  Lexie
//
//  Created by Allen Hsu on 11/04/2017.
//  Copyright © 2017 Glow, Inc. All rights reserved.
//

#import "GLRNPubSubEmitter.h"

@implementation GLRNPubSubEmitter
{
    NSMutableDictionary *_subscribedEvents;
}

RCT_EXPORT_MODULE(PubSubEmitter)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _subscribedEvents = [NSMutableDictionary dictionary];
    }
    return self;
}

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"newEvent"];
}

- (void)startObserving {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotification:) name:nil object:nil];
}

- (void)stopObserving {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSDictionary *)parseNotification:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    id jsonData = nil;
    @try {
        id json = [NSJSONSerialization dataWithJSONObject:userInfo options:0 error:NULL];
        jsonData = [NSJSONSerialization JSONObjectWithData:json options:0 error:NULL];
    } @catch (NSException *exception) {
    }
    if (!jsonData) {
        jsonData = [NSNull null];
    }
    return @{
        @"name": notification.name ?: @"",
        @"data": jsonData,
    };
}

- (void)didReceiveNotification:(NSNotification *)notification {
    if (!notification.name) {
        return;
    }
    NSNumber *count = _subscribedEvents[notification.name];
    if ([count intValue] > 0) {
        [self sendEventWithName:@"newEvent" body:[self parseNotification:notification]];
    }
}

RCT_EXPORT_METHOD(publishEvent:(NSString *)eventName data:(NSDictionary *)eventData) {
    if (!eventName) {
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:eventName object:self userInfo:eventData];
}

RCT_EXPORT_METHOD(subscribeEvent:(NSString *)eventName) {
    if (!eventName) {
        return;
    }
    NSNumber *count = _subscribedEvents[eventName];
    _subscribedEvents[eventName] = @([count intValue] + 1);
}

RCT_EXPORT_METHOD(unsubscribeEvent:(NSString *)eventName) {
    if (!eventName) {
        return;
    }
    NSNumber *count = _subscribedEvents[eventName];
    if ([count intValue] > 0) {
        _subscribedEvents[eventName] = @([count intValue] - 1);
    }
}

@end
