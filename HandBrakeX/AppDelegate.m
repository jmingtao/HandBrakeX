//
//  AppDelegate.m
//  HandBrakeX
//
//  Created by JinMingTao on 5/9/14.
//  Copyright (c) 2014 jinmingtao. All rights reserved.
//

#import "AppDelegate.h"
#import "MovieConverter.h"
#import "MovieConversion.h"

@interface AppDelegate() {
    
}

@property(nonatomic, strong) NSArray *files;
@property(nonatomic, strong) MovieConverter *converter;

- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;

@end


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _converter = [[MovieConverter alloc] init];
    _converter.delegate = self;
    
    MovieConversion *aConversion = [[MovieConversion alloc] init];

    aConversion.input = [NSURL fileURLWithPath:@"/Volumes/Data/Job/HandBrake/Test/test.mov"];
    aConversion.output = [NSURL fileURLWithPath:@"/Volumes/Data/Job/HandBrake/Test/output.mov"];
    aConversion.preset = @"AppleTV 3";
    
    _converter.conversions = @[aConversion];
    
    [_converter start];
}

- (void)dealloc
{
    [_converter release];
    [super dealloc];
}

#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return 0;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return nil;
}

- (IBAction)start:(id)sender
{
    MovieConversion *conversion1 = [[[MovieConversion alloc] init] autorelease];
    conversion1.input = [NSURL fileURLWithPath:@"/volumes/data1"];

    MovieConversion *conversion2 = [[[MovieConversion alloc] init] autorelease];
    conversion2.input = [NSURL fileURLWithPath:@"/volumes/data2"];
    
    self.converter.conversions = @[conversion1, conversion2];
}

- (IBAction)stop:(id)sender
{
    
}

#pragma mark - MovieConverterDelegate

- (BOOL)movieConverterShouldBeginConverting:(MovieConverter *)converter
{
    NSLog(@"movieConverterShouldBeginConverting");
    
    return YES;
}

@end
