//
//  MovieConverter.h
//  HandBrakeX
//
//  Created by JinMingTao on 5/13/14.
//  Copyright (c) 2014 jinmingtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MovieConverter;
@protocol MovieConverterDelegate<NSObject>

@optional

//- (BOOL)movieConverterShouldBeginConverting:(MovieConverter*)converter;
//- (void)movieConverterDidBeginConverting:(MovieConverter*)converter;
//- (void)movieConverterWasCancelled:(MovieConverter*)converter;
//- (BOOL)movieConverterShouldContinueProcessing:(MovieConverter*)converter;
- (void)movieConverter:(MovieConverter*)converter didProgressToPercent:(NSNumber*)percent;
- (void)movieConverter:(MovieConverter*)converter didFailWithError:(NSError*)error;
- (void)movieConverterDidFinishConvert:(MovieConverter*)converter;

@end

@interface MovieConverter : NSObject

@property(nonatomic, retain) NSArray *conversions;
@property(nonatomic, assign) id<MovieConverterDelegate> delegate;

- (void)start;

@end
