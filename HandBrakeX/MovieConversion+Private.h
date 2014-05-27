//
//  MovieConversion+Extension.h
//  HandBrakeX
//
//  Created by JinMingTao on 5/14/14.
//  Copyright (c) 2014 jinmingtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieConversionOperation.h"

@interface MovieConversion()

@property(nonatomic, readwrite) float progress;
@property(nonatomic, assign) MovieConversionOperation *conversionOperation;

@end
