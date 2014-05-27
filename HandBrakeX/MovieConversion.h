//
//  MovieConversion.h
//  HandBrakeX
//
//  Created by JinMingTao on 5/13/14.
//  Copyright (c) 2014 jinmingtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieConversion : NSObject

@property(nonatomic, strong) NSURL *input;
@property(nonatomic, strong) NSString *preset;
@property(nonatomic, strong) NSURL *output;
@property(nonatomic, readonly) float progress;

- (void)cancel;

@end
