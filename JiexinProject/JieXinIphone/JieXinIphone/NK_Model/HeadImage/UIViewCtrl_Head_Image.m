//
//  UIViewCtrl_Head_Image.m
//  JieXinIphone
//
//  Created by gabriella on 14-3-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "UIViewCtrl_Head_Image.h"
#import "SynUserIcon.h"

@interface UIViewCtrl_Head_Image ()

@end

@implementation UIViewCtrl_Head_Image

@synthesize imageview_01 = _imageview_01;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect rect = [[UIScreen mainScreen] bounds];
    if (rect.size.height < 568.0f) {
        CGFloat fwidth = self.view.frame.size.width;
        CGFloat fheight = self.view.frame.size.height - (568.0f - rect.size.height);
        [self.view setFrame:CGRectMake(0, 0, fwidth, fheight)];
    }
    
    NSString *bigmimage_path = [NSString stringWithString:[NSString stringWithFormat:@"%@/%@.jpg",[[SynUserIcon sharedManager] getCurrentUserBigIconPath],[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]]];
                                                                                                                                                           
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if ([filemanager fileExistsAtPath:bigmimage_path] == YES) {
        UIImage *image_01 = [UIImage imageWithContentsOfFile:bigmimage_path];
        [[self imageview_01] setImage:image_01];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma label -
#pragma label Custom Methods

- (IBAction)onBtnReturn_Click:(id)sender
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

@end
