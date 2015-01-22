//
//  ImageLibrary.m
//  CMBC_iPad_Project
//
//  Created by Raik on 13-11-2.
//  Copyright (c) 2013年 tony. All rights reserved.
//

#import "PhotoLibrary.h"
#import "RotatePhotoViewController.h"


//参考资料：http://blog.sina.com.cn/s/blog_68edaff101019ppe.html

@interface PhotoLibrary()<PhotoLibraryDelegate>

@property (nonatomic, retain) UIImagePickerController *imagePickerController;

@end
@implementation PhotoLibrary
@synthesize delegate = _delegate;

static PhotoLibrary *sharedInstance= nil;

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if(sharedInstance == nil)
        {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return sharedInstance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (void)dealloc
{
    self.photoLibraryPopover = nil;
    self.imagePickerController = nil;
    self.delegate = nil;
    self.takeCamera = nil;
    [super dealloc];
}

- (void)settingDelegate:(id)theDelegate popAt:(CGRect)frame
{
    self.delegate = (id)theDelegate;
    self.popFrame = frame;
}
#pragma mark - SubmitDataDelegate
- (void)choosePhoto
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从照片库中选择", nil];
    UIViewController *tempObject = [[AppDelegate shareDelegate] rootNavigation];
    
    [actionSheet showInView:[(UIViewController *)tempObject view]];
    
    [actionSheet release];
    
}

#pragma mark - UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%d",buttonIndex);
    switch (buttonIndex) {
        case 0:
            [self takePhotoWithCamera];
            break;
        case 1:
            [self choosePhotoFromLibrary];
            break;
        default:
            break;
    }
}

//拍照
- (void)takePhotoWithCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"设备不支持拍照");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备不支持拍照" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
        return;
    }
    [self performSelector:@selector(take) withObject:nil afterDelay:0];
    
}
- (void)take
{
    //创建图像选取控制器
    UIImagePickerController* imagePickerController = [[[UIImagePickerController alloc] init] autorelease];
   if (IOSVersion >= 7.0) {
        imagePickerController.modalPresentationStyle = UIModalPresentationCustom;
    }
    //设置图像选取控制器的来源模式为相机模式
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    //允许用户进行编辑
    imagePickerController.allowsEditing = YES;
    //设置委托对象
    imagePickerController.delegate = self;
    self.imagePickerController = imagePickerController;
    //以模视图控制器的形式显示
//    UIViewController *tempObject = (UIViewController *)_delegate;
    UIViewController *tempObject = [[AppDelegate shareDelegate] rootNavigation];
    [tempObject presentViewController:_imagePickerController animated:YES completion:nil];
}
//从相册库选取
- (void)choosePhotoFromLibrary
{
    //创建图像选取控制器
    UIImagePickerController *imagePickerController = [[[UIImagePickerController alloc] init] autorelease];
    //设置图像选取控制器的来源模式为相机模式
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //允许用户进行编辑
    //imagePickerController.allowsEditing = YES;
    //设置委托对象
    imagePickerController.delegate = self;
    self.imagePickerController = imagePickerController;

    //以模视图控制器的形式显示
    
    //模拟器必须是UIPopoverController
    //    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:m_imagePicker];
    //    self.popoverController = popover;
    //    //popoverController.delegate = self;
    //
    //    [popoverController presentPopoverFromRect:CGRectMake(0, 0, 300, 300) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    //
    //    //[self presentModalViewController:m_imagePicker animated:YES];
    //    [popover release];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {

        UIPopoverController *popover = [[[UIPopoverController alloc] initWithContentViewController:self.imagePickerController] autorelease];
        UIViewController *tempObject = (UIViewController *)_delegate;
        
        
        [popover presentPopoverFromRect:self.popFrame inView:tempObject.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:NO];
        self.photoLibraryPopover = popover;
        //    [self presentViewController:imagePickerController animated:YES completion:nil];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    }
    else
    {
//        UIViewController *tempObject = (UIViewController *)_delegate;
        
        UIViewController *tempObject = [[AppDelegate shareDelegate] rootNavigation];
        
        [tempObject presentViewController:self.imagePickerController animated:YES completion:nil];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    }
}


#pragma mark -
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *photoImage = nil;
    photoImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    RotatePhotoViewController *rotate = [[RotatePhotoViewController alloc] initWithNibName:nil bundle:nil];
    rotate.delegate = self;
    [rotate fillRotateImageView:photoImage];
    self.imagePickerController.navigationBarHidden = YES;
    [self.imagePickerController pushViewController:rotate animated:NO];
    [rotate release];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.photoLibraryPopover dismissPopoverAnimated:NO];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}
- (void)selectImage:(UIImage *)image withInfo:(id)info
{
    //取出图片发送消息
    [self.photoLibraryPopover dismissPopoverAnimated:NO];
    [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];

    if (image) {

        if(_delegate && [(NSObject *)_delegate respondsToSelector:@selector(selectImage:withInfo:)])
        {
            [_delegate selectImage:image withInfo:nil];
        }
    }
}



@end
