//
//  MovieConversion.m
//  HandBrakeX
//
//  Created by JinMingTao on 5/13/14.
//  Copyright (c) 2014 jinmingtao. All rights reserved.
//

#import "MovieConversion.h"
#import "MovieConversion+Private.h"

@implementation MovieConversion

- (void)dealloc
{
    [_input release];
    [_output release];
    [_preset release];
    
    [super dealloc];
};

- (void)cancel
{
    [self.conversionOperation cancel];
}

@end
