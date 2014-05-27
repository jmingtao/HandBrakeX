//
//  MovieConverter.m
//  HandBrakeX
//
//  Created by JinMingTao on 5/13/14.
//  Copyright (c) 2014 jinmingtao. All rights reserved.
//

#import "MovieConverter.h"
#import "MovieConversion.h"
#import "MovieConversionOperation.h"

@interface MovieConverter()<MovieConversionOperationDelegate>

@property(strong) NSOperationQueue *queue;

@end

@implementation MovieConverter

- (id)init
{
    self = [super init];
    
    if (self != nil) {
        
        _queue = [[NSOperationQueue alloc] init];
    }
    
    return self;
}

- (void)dealloc
{
    [_queue release];
    [_conversions release];
    [super dealloc];
}

- (void)start
{
    for (MovieConversion *aConversion in self.conversions) {
        
        MovieConversionOperation *op = [[[MovieConversionOperation alloc] initWithMovieConversion:aConversion] autorelease];
        
        [_queue addOperation:op];
    }
}

@end
