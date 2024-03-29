//
//  AppDelegate.m
//  playstream
//
//  Created by Eric Wing on 1/2/13.
//  Copyright (c) 2013 PlayControl Software LLC. All rights reserved.
//

#import "AppDelegate.h"
#include "ALmixer.h"

@interface AppDelegate ()
@property(nonatomic, assign) ALmixer_Data* musicHandle;
@end


@implementation AppDelegate
@synthesize musicHandle = _musicHandle;

- (void)dealloc
{
	ALmixer_HaltChannel(-1);
	ALmixer_FreeData(_musicHandle);
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
	ALmixer_Init(0, 0, 0);
	NSString* music_file = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"battle_hymn_of_the_republic.mp3"];
	_musicHandle = ALmixer_LoadStream([music_file fileSystemRepresentation], 0, 0, 0, 0, AL_FALSE);
	
	ALmixer_PlayChannel(-1, _musicHandle, 0);

}

@end
