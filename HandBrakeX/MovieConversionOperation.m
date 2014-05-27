//
//  MovieConversionOperation.m
//  HandBrakeX
//
//  Created by JinMingTao on 5/14/14.
//  Copyright (c) 2014 jinmingtao. All rights reserved.
//

#import "MovieConversionOperation.h"
#import "MovieConversion.h"
#import "MovieConversion+Private.h"
#import "RegexKitLite-4.0/RegexKitLite.h"

@interface MovieConversionOperation()

@property(readwrite, retain) MovieConversion *movieCoversion;

- (void)parseOutputForFileHandle:(NSFileHandle*)fileHandle;

@end

@implementation MovieConversionOperation

- (instancetype)initWithMovieConversion:(MovieConversion*)conversion
{
    self = [super init];
    
    if (self != nil) {
        
        _movieConversion = [conversion retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_movieConversion release];
    [super dealloc];
}

- (void)main
{
    NSLog(@"input = %@", self.movieConversion.input);
    
	NSPipe *pipe = [NSPipe pipe];
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *handBrakeCLIPath = [mainBundle pathForResource:@"HandBrakeCLI"
                                                      ofType:nil];
    
    
    // HandBrakeCLI [options] -i <device> -o <file>
    NSArray *arguments = @[@"--preset",
                           self.movieConversion.preset,
                           @"-i",
                           self.movieConversion.input.path,
                           @"-o",
                           self.movieConversion.output.path];
    
    NSTask *task = [[[NSTask alloc] init] autorelease];
    [task setLaunchPath:handBrakeCLIPath];
    NSFileHandle *nullFileHandle = [NSFileHandle fileHandleWithNullDevice];
    [task setStandardInput:nullFileHandle]; //stdin is directed to /dev/null
    [task setStandardOutput:pipe];
    [task setStandardError:nullFileHandle];
    [task setArguments:arguments];
    [task launch];

    NSNumber *percent = nil;
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_queue_t currentQueue = dispatch_get_current_queue();
    
    while ([task isRunning]) {
        
        if ([self isCancelled]) {
            
            [task terminate];
            return;
        }
        
        [NSThread sleepForTimeInterval:0.1];
        
        [self parseOutputForFileHandle:pipe.fileHandleForReading];
        continue;
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(movieConversionOperationProcessing:)]) {
            
            if (currentQueue != mainQueue) {
                
                dispatch_sync(mainQueue, ^{
                    
                    [self.delegate movieConversionOperationProcessing:self];
                });
            }
            else {
                
                [self.delegate movieConversionOperationProcessing:self];
            }
        }
    }
}

- (void)parseOutputForFileHandle:(NSFileHandle*)fileHandle
{
    NSData *data = [fileHandle availableData];

    if (data == nil)
        return;
    
    if ([data length] == 0)
        return;
    
    NSLog(@"data length = %ld", [data length]);
    
    NSString *content = [[[NSString alloc] initWithData:data
                                               encoding:NSUTF8StringEncoding] autorelease];
    
    NSLog(@"length = %ld, content = %@###", [content length], content);
    // Encoding: task 1 of 1, 0.00 %
    
    content = [content stringByMatching:@"\\d+\\.{1}\\d+"];

    if ([content length] == 0)
        return;
    
    float percent = [content floatValue];

    NSLog(@"percent = %f", percent);
}

@end
