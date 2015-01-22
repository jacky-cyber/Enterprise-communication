//
//  TakeCameraViewController.m
//  JieXinIphone
//
//  Created by liqiang on 14-3-21.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "TakeCameraViewController.h"

@interface TakeCameraViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation TakeCameraViewController

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
    self.view.backgroundColor =[UIColor blackColor];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self performSelector:@selector(take) withObject:nil];
}

- (void)take
{
    //创建图像选取控制器
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    //    UIModalPresentationCurrentContext,
    //#endif
    //#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    //    UIModalPresentationCustom,
    //    UIModalPresentationNone = -1,
    if (IOSVersion >= 7.0) {
        imagePickerController.modalPresentationStyle = UIModalPresentationCustom;
    }
    //设置图像选取控制器的来源模式为相机模式
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //允许用户进行编辑
    //imagePickerController.allowsEditing = YES;
    //设置委托对象
    imagePickerController.delegate = self;
    //以模视图控制器的形式显示
    
    //
//    UIViewController *tempObject = (UIViewController *)_delegate;
//    UIViewController *tempObject = [[AppDelegate shareDelegate] rootNavigation];
    [self presentViewController:imagePickerController animated:NO completion:nil];
    [imagePickerController release];
}


#pragma mark -
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //取出图片发送消息
    [picker dismissViewControllerAnimated:NO completion:nil];
    UIImage *photoImage = nil;
    photoImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    if(_delegate && [(NSObject *)_delegate respondsToSelector:@selector(selectImage:withInfo:)])
    {
        [_delegate selectImage:photoImage withInfo:nil];
    }
    [self dismissViewControllerAnimated:NO completion:nil];

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:NO completion:nil];
    if(_delegate && [(NSObject *)_delegate respondsToSelector:@selector(selectImage:withInfo:)])
    {
        [_delegate selectImage:nil withInfo:nil];
    }
    [self dismissViewControllerAnimated:NO completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
