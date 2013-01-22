/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "NetPlaycontrolAlmixerswigModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#include "ALmixer.h"


extern bool ALmixer_initialize(TiGlobalContextRef context);


void YourALmixerSwig_CPlaybackFinishedCallback(ALint which_channel, ALuint al_source, ALmixer_Data* almixer_data, ALboolean finished_naturally, void* user_data)
{
	// Remember that ALmixer does callbacks on a different thread when it is compiled with threads.
	fprintf(stderr, "Channel %d finished\n", which_channel);

	TiModule* proxy_object = (TiModule*)user_data;

	dispatch_async(dispatch_get_main_queue(),
	^{
		NSDictionary* the_event =
			@{
				@"name": @"ALmixerSoundPlaybackFinished",
//				@"handle": [NSValue valueWithPointer:almixer_data],
				@"channel": [NSNumber numberWithInt:which_channel],
				@"source": [NSNumber numberWithUnsignedInt:al_source],
				@"completed": [NSNumber numberWithBool:finished_naturally]
			};

		[proxy_object fireEvent:@"ALmixerSoundPlaybackFinished" withObject:the_event];
	}
	);
}
void YourALmixerSwig_CPlaybackDataCallback(ALint which_channel, ALuint al_source, ALbyte* pcm_data, ALuint num_bytes, ALuint frequency, ALubyte num_channels_in_sample, ALubyte bit_depth, ALboolean is_unsigned, ALboolean decode_mode_is_predecoded, ALuint length_in_msec, void* user_data)
{
	// Remember that ALmixer does callbacks on a different thread when it is compiled with threads.
	fprintf(stderr, "YourALmixerSwig_CPlaybackDataCallback Channel %d\n", which_channel);

}


@implementation NetPlaycontrolAlmixerswigModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"0cbbe481-86cc-4a26-a1cc-a2a351e755c3";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"net.playcontrol.almixerswig";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
//	KrollContext* kroll_context = [self->pageKrollObject context];
//	TiGlobalContextRef js_global_context = [kroll_context context];

	TiGlobalContextRef js_global_context = [[[self executionContext] krollContext] context];
	
	ALmixer_initialize(js_global_context);
	// TODO: Either this should get pushed to the script or we need an XML way of passing parameters to the script
	// This also impacts the sound finished callback because it is not supposed to be set until after Init.
	ALmixer_Init(0, 0, 0);
	ALmixer_SetPlaybackFinishedCallback(YourALmixerSwig_CPlaybackFinishedCallback, self);

	
	NSLog(@"[INFO] %@ loaded",self);
	
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"ALmixerSoundPlaybackFinished"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"ALmixerSoundPlaybackFinished"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(id)example:(id)args
{
	// example method
	return @"hello world";
}

-(id)exampleProp
{
	// example property getter
	return @"hello world";
}

-(void)setExampleProp:(id)value
{
	// example property setter
}

@end
