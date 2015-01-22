//
//  PlaySound.m
//  JieXinIphone
//
//  Created by liqiang on 14-2-25.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "PlaySound.h"

@implementation PlaySound


+ (id) sharedService
{
	static PlaySound *_sharedInst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInst=[[PlaySound alloc] init];
    });
    return _sharedInst;
}

- (void)dealloc
{
    self.soundPath = nil;
    [super dealloc];
}

- (id) init
{
	if (self = [super init])
	{
        self.isNowCanPlaySound = YES;
	}
	return self;
}


- (void)playSoundWithName:(NSString *)name type:(NSString *)type
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSURL *url = [NSURL fileURLWithPath:path];
        SystemSoundID sound;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &sound);
        AudioServicesPlaySystemSound(sound);
    }
    else {
        NSLog(@"**** Sound Error: file not found: %@", path);
    }
}

- (void)playMessageReceivedSound
{
    if (self.isNowCanPlaySound)
    {
        self.isNowCanPlaySound = NO;
        if ([[NSUserDefaults standardUserDefaults] boolForKey:kIsPalySound])
        {
            if (self.soundPath) {
                [self playSoundWithName:self.soundPath type:@"mp3"];
            }
            else
            {
                AudioServicesPlayAlertSound(1007);
            }
            //震动
            //        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
        if ([[NSUserDefaults standardUserDefaults] boolForKey:kIsCanShake])
        {
            //震动
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
        [self performSelector:@selector(setCanPlaySound) withObject:nil afterDelay:3.0f];
    }
    else
        return;
}

- (void)setCanPlaySound
{
    self.isNowCanPlaySound = YES;
}

- (void)playMessageSentSound
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kIsPalySound])
    {
        [self playSoundWithName:@"messageReceived" type:@"aiff"];
    }

}


@end
