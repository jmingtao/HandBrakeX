//
//  MovieConversionOperation.h
//  HandBrakeX
//
//  Created by JinMingTao on 5/14/14.
//  Copyright (c) 2014 jinmingtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MovieConversion;
@class MovieConversionOperation;

@protocol MovieConversionOperationDelegate<NSObject>

@optional

- (void)movieConversionOperationRunning:(MovieConversionOperation*)conversion;
- (void)movieConversionOperation:(MovieConversionOperation*)conversion didFailWithError:(NSError*)error;
- (void)movieConversionDidFinish:(MovieConversionOperation*)conversion;

@end

@interface MovieConversionOperation : NSOperation

- (instancetype)initWithMovieConversion:(MovieConversion*)conversion;

@property(readonly) MovieConversion *movieConversion;
@property(nonatomic, assign) id<MovieConversionOperationDelegate> delegate;

@end
