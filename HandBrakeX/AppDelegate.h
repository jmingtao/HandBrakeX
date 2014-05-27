//
//  AppDelegate.h
//  HandBrakeX
//
//  Created by JinMingTao on 5/9/14.
//  Copyright (c) 2014 jinmingtao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MovieConverter.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate, MovieConverterDelegate>

@property (assign) IBOutlet NSWindow *window;

@end
