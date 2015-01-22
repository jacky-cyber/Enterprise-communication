//
//  ShowBigPicVC.m
//  JieXinIphone
//
//  Created by macOne on 14-4-23.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "ShowBigPicVC.h"
#import "PicInfoVC.h"

@interface ShowBigPicVC ()

@end

@implementation ShowBigPicVC

@synthesize btn_add;

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
    CGRect rect = [[UIScreen mainScreen] bounds];
    if (rect.size.height < 568.0f) {
        CGFloat fwidth = self.view.frame.size.width;
        CGFloat fheight = self.view.frame.size.height - (568.0f - rect.size.height);
        [self.view setFrame:CGRectMake(0, 0, fwidth, fheight)];
    }
    [self initTitleLabel];
    //    [self initImageView];
    [self initAddImageToPhotoAlbum];
    //
    [self initScrollView];
    [self loadingInit];
    // Do any additional setup after loading the view from its nib.
}
-(void)initAddImageToPhotoAlbum
{
    UIView *view_gray = [[[UIView alloc]initWithFrame:CGRectMake(230, self.view_01.frame.size.height-120, 140, 40)]autorelease];
    view_gray.layer.cornerRadius = 20.0f;
    //    view_gray.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
    view_gray.backgroundColor = [UIColor grayColor];
    [view_gray.layer setBorderColor:[[UIColor colorWithRed:204.0f / 255.0f green:204.0f / 255.0f blue:204.0f / 255.0f alpha:1.0] CGColor]];
    [view_gray.layer setBorderWidth:0.9f];
    [self.view_01 addSubview:view_gray];
    
    btn_add = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_add setFrame:CGRectMake(0, 0, 100, view_gray.frame.size.height)];
    [btn_add setBackgroundColor:[UIColor clearColor]];
    [btn_add setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_add.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [btn_add setTitle:@"保存到相册" forState:UIControlStateNormal];
    [btn_add addTarget:self action:@selector(saveToPhotoAlbum) forControlEvents:UIControlEventTouchUpInside];
    [view_gray addSubview:btn_add];
    
}
-(void)saveToPhotoAlbum
{
    MRZoomScrollView *mrZoom = (MRZoomScrollView*)[self.view_01 viewWithTag:self.currentImagePage];
    UIImageWriteToSavedPhotosAlbum(mrZoom.imageView.image, nil, nil, nil);
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"成功保存到相册" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}
-(void)initTitleLabel
{
    if(self.currentImagePage<=1)
    {
        self.currentImagePage=1;
    }
    else if(self.currentImagePage>=[self.dataSourceArray count])
    {
        self.currentImagePage = [self.dataSourceArray count];
    }
    NSString *nickname_str = [[self.dataSourceArray objectAtIndex:(self.currentImagePage-1)]valueForKey:@"nickname"];
    NSString *description_str = [[self.dataSourceArray objectAtIndex:(self.currentImagePage-1)]valueForKey:@"description"];
    NSString *all_str = @"";
    if([description_str isEqualToString:@""])
    {
        all_str = nickname_str;
    }
    else
    {
        all_str = [NSString stringWithFormat:@"%@:%@",nickname_str,description_str];
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%@",all_str];
}
-(void)initImageView
{
    NSString *imagePid = [[self.dataSourceArray objectAtIndex:(self.currentImagePage-1)]valueForKey:@"pid"];
    NSString *sPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *sImagePath = [sPath stringByAppendingPathComponent:@"temp_image"];
    NSString* fullPathToFile = [sImagePath stringByAppendingPathComponent:imagePid];
    UIImage *image_01 = [UIImage imageWithContentsOfFile:fullPathToFile];
    self.imageView_01.image = image_01;
    //添加左右滑动的功能
    self.imageView_01.userInteractionEnabled =YES;
    UISwipeGestureRecognizer *swip_right = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(imageV_Swip:)];
    swip_right.direction = UISwipeGestureRecognizerDirectionRight;
    [self.imageView_01 addGestureRecognizer:swip_right];
    [swip_right release];
    UISwipeGestureRecognizer *swip_left = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(imageV_Swip:)];
    swip_left.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.imageView_01 addGestureRecognizer:swip_left];
    [swip_left release];
    //
}
-(void)initTimer
{
    self.showTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                      target:self
                                                    selector:@selector(loadAgain1)
                                                    userInfo:nil
                                                     repeats:YES];
    [self.showTimer fire];
}
-(void)loadingInit
{
    self.active = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.active setFrame:CGRectMake(140, 200, 40, 40)];
    [self.view_01 addSubview:self.active];
    [self.active release];
}
-(void)loadAgain
{
    NSString *imagePid = [[self.dataSourceArray objectAtIndex:(self.currentImagePage-1)]valueForKey:@"pid"];
    NSString *sPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *sImagePath = [sPath stringByAppendingPathComponent:@"temp_image"];
    NSString* fullPathToFile = [sImagePath stringByAppendingPathComponent:imagePid];
    UIImage *image_01 = [UIImage imageWithContentsOfFile:fullPathToFile];
    self.imageView_01.image = image_01;
    if(image_01)
    {
        [self.showTimer invalidate];
        [self.active stopAnimating];
        btn_add.userInteractionEnabled = YES;
    }
}
-(void)loadAgain1
{
    NSString *imagePid = [[self.dataSourceArray objectAtIndex:(self.currentImagePage-1)]valueForKey:@"pid"];
    NSString *sPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *sImagePath = [sPath stringByAppendingPathComponent:@"temp_image"];
    NSString* fullPathToFile = [sImagePath stringByAppendingPathComponent:imagePid];
    UIImage *image_01 = [UIImage imageWithContentsOfFile:fullPathToFile];
    MRZoomScrollView *mrZoom = (MRZoomScrollView*)[self.view_01 viewWithTag:self.currentImagePage];
    mrZoom.imageView.image = image_01;
    if(image_01)
    {
        [self.showTimer invalidate];
        [self.active stopAnimating];
        btn_add.userInteractionEnabled = YES;
    }
}
#pragma imageV turn left or right
-(void)imageV_Swip:(UISwipeGestureRecognizer *)gesture
{
    btn_add.userInteractionEnabled = YES;
    if([self.active isAnimating]==YES)
    {
        [self.active stopAnimating];
    }
    if(self.showTimer)
    {
        [self.showTimer invalidate];
    }
    if(gesture.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        if(self.currentImagePage<[self.dataSourceArray count])
        {
            [self turnLeft];
        }
    }
    else if (gesture.direction == UISwipeGestureRecognizerDirectionRight)
    {
        if(self.currentImagePage>1)
        {
            [self turnRight];
        }
    }
    NSLog(@"self.currentImagePage=%d",self.currentImagePage);
}

-(void)turnLeft
{
    NSLog(@"左滑");
    self.currentImagePage++;
    NSString *imagePid = [[self.dataSourceArray objectAtIndex:(self.currentImagePage-1)]valueForKey:@"pid"];
    NSString *sPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *sImagePath = [sPath stringByAppendingPathComponent:@"temp_image"];
    NSString* fullPathToFile = [sImagePath stringByAppendingPathComponent:imagePid];
    UIImage *image_01 = [UIImage imageWithContentsOfFile:fullPathToFile];
    self.imageView_01.image = image_01;
    if(!image_01)
    {
        NSLog(@"图片是空");
        [self.active startAnimating];
        btn_add.userInteractionEnabled = NO;
        [self initTimer];
    }
    [self initTitleLabel];
}
-(void)turnRight
{
    NSLog(@"右滑");
    self.currentImagePage--;
    NSString *imagePid = [[self.dataSourceArray objectAtIndex:(self.currentImagePage-1)]valueForKey:@"pid"];
    NSString *sPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *sImagePath = [sPath stringByAppendingPathComponent:@"temp_image"];
    NSString* fullPathToFile = [sImagePath stringByAppendingPathComponent:imagePid];
    UIImage *image_01 = [UIImage imageWithContentsOfFile:fullPathToFile];
    self.imageView_01.image = image_01;
    if(!image_01)
    {
        NSLog(@"图片是空");
        [self.active startAnimating];
        btn_add.userInteractionEnabled = NO;
        [self initTimer];
    }
    [self initTitleLabel];
    
}
#pragma label -
#pragma label UIScrollViewDelegate Methods
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//    for (id subview in scrollView.subviews) {
//        if ([subview isKindOfClass:[UIImageView class]]) {
//            return subview;
//        }
//    }
//    return nil;
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [_titleLabel release];
    [_view_01 release];
    [_view_02 release];
    [_imageView_01 release];
    [_scrollView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setView_01:nil];
    [self setView_02:nil];
    [self setImageView_01:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
}
- (IBAction)goToInfo:(id)sender {
    
    PicInfoVC *infoVC = [[PicInfoVC alloc]initWithNibName:@"PicInfoVC" bundle:nil];
    infoVC.dataSourceArray_picInfo = self.dataSourceArray;
    infoVC.currentImagePage_picInfo = self.currentImagePage;
    [self.navigationController pushViewController:infoVC animated:YES];
    [infoVC release];
    
}
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//新添加的方法
-(void)initScrollView
{
    self.scrollView.delegate = self;
    if([self.dataSourceArray count]!=0)
    {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*[self.dataSourceArray count],0);
        for (int i = 0; i < [self.dataSourceArray count]; i++) {
            _zoomScrollView = [[MRZoomScrollView alloc]init];
            _zoomScrollView.tag = i+1;
            _zoomScrollView.showsVerticalScrollIndicator=NO;
            _zoomScrollView.contentSize = CGSizeMake(_zoomScrollView.contentSize.width, self.scrollView.frame.size.height);
            _zoomScrollView.frame = CGRectMake(i*self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
            NSString *imagePid = [[self.dataSourceArray objectAtIndex:i]valueForKey:@"pid"];
            NSString *sPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *sImagePath = [sPath stringByAppendingPathComponent:@"temp_image"];
            NSString* fullPathToFile = [sImagePath stringByAppendingPathComponent:imagePid];
            UIImage *image_01 = [UIImage imageWithContentsOfFile:fullPathToFile];
            _zoomScrollView.imageView.frame = CGRectMake(0, 0, _zoomScrollView.frame.size.width, _zoomScrollView.frame.size.height);
            _zoomScrollView.imageView.image = image_01;
            [self.scrollView addSubview:_zoomScrollView];
            [_zoomScrollView release];
            //            NSLog(@"hei = %f",_zoomScrollView.frame.size.height);
            //            NSLog(@"hei2 = %f",_zoomScrollView.imageView.frame.size.height);
        }
        [self.scrollView setContentOffset:CGPointMake((self.currentImagePage-1)*self.scrollView.frame.size.width, 0)];
    }
    else
    {
        NSLog(@"参数没有传送过来");
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    btn_add.userInteractionEnabled = YES;
    if([self.active isAnimating]==YES)
    {
        [self.active stopAnimating];
    }
    if(self.showTimer)
    {
        [self.showTimer invalidate];
    }
    //
    self.currentImagePage = (int)(scrollView.contentOffset.x/320.0+1);
    [self initTitleLabel];
    MRZoomScrollView *mrZoom = (MRZoomScrollView*)[self.view_01 viewWithTag:self.currentImagePage];
    if(!mrZoom.imageView.image)
    {
        NSLog(@"currentImagePage=图片%d是空",self.currentImagePage);
        [self.active startAnimating];
        btn_add.userInteractionEnabled = NO;
        [self initTimer];
    }
}

@end
