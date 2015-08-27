//
//  RNTDeviceMotion.m
//  RNTDeviceMotion
//
//  Created by Param Aggarwal on 27/08/15.
//  Copyright © 2015 Facebook. All rights reserved.
//

#import "RNTDeviceMotion.h"
#import "RCTEventDispatcher.h"
@import CoreMotion;

@implementation RNTDeviceMotion
{
  CMMotionManager *_motionManager;
}

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE()

- (id)init {
  self = [super init];
  if (self) {
    _motionManager = [[CMMotionManager alloc] init];
  }
  return self;
}

RCT_EXPORT_METHOD(startDeviceMotionUpdatesWithUpdateInterval:(NSTimeInterval)updateInterval)
{
  _motionManager.deviceMotionUpdateInterval = updateInterval;
  [_motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical
                                                      toQueue:[NSOperationQueue mainQueue]
                                                  withHandler:^(CMDeviceMotion *motion, NSError *error) {
                                                    
                                                    if (error) {
                                                      [self.bridge.eventDispatcher sendDeviceEventWithName:@"onDeviceMotionError"
                                                                                                      body:@{
                                                                                                             @"error": @{
                                                                                                                 @"description" : error.description ?: @"",
                                                                                                                 },
                                                                                                             }];
                                                    }
                                                    
                                                    [self.bridge.eventDispatcher sendDeviceEventWithName:@"onDeviceMotionUpdate"
                                                                                                    body:@{
                                                                                                           @"attitude": @{
                                                                                                               @"roll" : @(motion.attitude.roll),
                                                                                                               @"pitch" : @(motion.attitude.pitch),
                                                                                                               @"yaw" : @(motion.attitude.yaw),
                                                                                                               },
                                                                                                           @"rotationRate": @{
                                                                                                               @"x" : @(motion.rotationRate.x),
                                                                                                               @"y" : @(motion.rotationRate.y),
                                                                                                               @"z" : @(motion.rotationRate.z),
                                                                                                               },
                                                                                                           @"gravity": @{
                                                                                                               @"x" : @(motion.gravity.x),
                                                                                                               @"y" : @(motion.gravity.y),
                                                                                                               @"z" : @(motion.gravity.z),
                                                                                                               },
                                                                                                           @"userAcceleration": @{
                                                                                                               @"x" : @(motion.userAcceleration.x),
                                                                                                               @"y" : @(motion.userAcceleration.y),
                                                                                                               @"z" : @(motion.userAcceleration.z),
                                                                                                               },
                                                                                                           @"magneticField": @{
                                                                                                               @"accuracy": @(motion.magneticField.accuracy),
                                                                                                               @"field": @{
                                                                                                                   @"x" : @(motion.magneticField.field.x),
                                                                                                                   @"y" : @(motion.magneticField.field.y),
                                                                                                                   @"z" : @(motion.magneticField.field.z),
                                                                                                                   },
                                                                                                               },
                                                                                                           }];
                                                  }];
  
}

RCT_EXPORT_METHOD(stopDeviceMotionUpdates)
{
  [_motionManager stopDeviceMotionUpdates];
}

@end
