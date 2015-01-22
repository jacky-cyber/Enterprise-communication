//
//  myLib.m
//  chatView
//
//  Created by lxrent02 on 14-3-20.
//  Copyright (c) 2014年 miaoLiZhuang. All rights reserved.
//

#import "myLib.h"

@interface myLib ()

@end

@implementation myLib

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
	// Do any additional setup after loading the view.
}
+(void)mSetStatesBar:(UINavigationController*)nav{
    CGRect rect = CGRectMake(0.0f, 0.0f, 320, 44.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor colorWithWhite: 1.0 alpha:0.5f] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [nav.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
   }
+(UITabBarController*)CreatTabbarViewArray:(NSArray*)viewArray andTitleArray:(NSArray*)titleArray andImageArray:(NSArray*)imageArray andselectedImageArray:(NSArray*)selectedImageArray andItemsCount:(NSInteger)count{

    NSMutableArray * navArray = [[NSMutableArray alloc]init];
    for(int i=0;i<count;i++){
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:[viewArray objectAtIndex:i]];
        
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[imageArray objectAtIndex:i]]];
        image=[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage * selectImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[selectedImageArray objectAtIndex:i]]];
        selectImage=[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarItem * item = [[UITabBarItem alloc]initWithTitle:[titleArray objectAtIndex:i] image:image selectedImage:selectImage];
        nav.tabBarItem = item;
        item.tag=i;
        [navArray addObject:nav];
        
    }
    UITabBarController * tabbar = [[UITabBarController alloc]init];
    [tabbar setViewControllers:navArray];
    return tabbar;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
