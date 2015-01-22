//
//  ChatScanImageView.m
//  JieXinIphone
//
//  Created by liqiang on 14-6-17.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "ChatScanImageView.h"
#import "OLImage.h"
#import "CustomMethod.h"
#import "ImageDataHelper.h"
#import  "OLImageView.h"
#import "SVProgressHUD.h"

#define kBaseImageViewTag  1000

@interface ChatScanImageView()<UIActionSheetDelegate,UIScrollViewDelegate,DownLoadImageFinishedDelegate>
{
    NSInteger _nowSelectIndex;
}

@property (nonatomic,retain) NSMutableArray *imagesArr;
@property (nonatomic, retain) UILabel *numLb;
@property (nonatomic,retain) UIScrollView *mainScrollView;

@end

@implementation ChatScanImageView

- (void)dealloc
{
    self.imagesArr = nil;
    self.numLb = nil;
    self.mainScrollView = nil;
    self.delegate = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
    }
    return self;
}

- (void)setcontentImagesArr:(NSMutableArray *)imageArr  withNowIndex:(NSInteger)index
{
    self.imagesArr = imageArr;
    _nowSelectIndex = index;
    [self initSubViews];
}

- (void)initSubViews
{
    self.backgroundColor = [UIColor whiteColor];
    
    
    UIScrollView *aScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, kScreen_Width, CGRectGetHeight(self.bounds)-30-60)];
    aScrollView.delegate = self;
    aScrollView.pagingEnabled=YES;
    aScrollView.backgroundColor = [UIColor clearColor];
    aScrollView.showsHorizontalScrollIndicator=NO;
    aScrollView.showsVerticalScrollIndicator=NO;
    aScrollView.scrollsToTop=NO;
    aScrollView.clipsToBounds = YES;
    aScrollView.bounces = NO;
    aScrollView.contentSize = CGSizeMake(kScreen_Width*[_imagesArr count], CGRectGetHeight(aScrollView.frame));
    self.mainScrollView = aScrollView;
    [aScrollView release];
    [self addSubview:_mainScrollView];
    [_mainScrollView setContentOffset:CGPointMake(kScreen_Width*_nowSelectIndex, 0)];


    for (int i = 0; i < [_imagesArr count]; i++) {
        NSDictionary *dic = [_imagesArr objectAtIndex:i];
        NSString *imageStr = [dic objectForKey:@"image"];
        NSString *smallImageKey = [[imageStr componentsSeparatedByString:@";"] objectAtIndex:1];
        NSString *bigImageKey = [[imageStr componentsSeparatedByString:@";"] objectAtIndex:0];

        UIImage *smallImage = [[ImageDataHelper sharedService] getImageWithName:smallImageKey];
        OLImage *bigImage = [[ImageDataHelper sharedService] getYLGifImage:bigImageKey];
        

        OLImageView *imageView = [[OLImageView alloc] initWithFrame:CGRectMake(i*kScreen_Width, 0, kScreen_Width, CGRectGetHeight(_mainScrollView.frame))];
        imageView.delegate = self;
        imageView.msgid = [dic objectForKey:@"msgid"];
        imageView.smallImageKey = smallImageKey;
        imageView.bigImageKey = bigImageKey;
        imageView.userInteractionEnabled = YES;
        imageView.tag = kBaseImageViewTag + i;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_mainScrollView addSubview:imageView];
        [imageView release];
        
        if (bigImage) {
            imageView.image =bigImage;
        }
        else
        {
            if (smallImage)
            {
                imageView.image = smallImage;
            }
        }

        
        UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        imageBtn.frame = imageView.bounds;
        [imageBtn addTarget:self action:@selector(imageBtnTap) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:imageBtn];
    }
    
    
    UIImage *popMenuImage = [UIImage imageNamed:@"popMenuBtn.png"];
    UIButton *popMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    popMenuBtn.frame = CGRectMake(CGRectGetWidth(self.frame)-65, CGRectGetHeight(self.frame)-60, 65, 60);
    [popMenuBtn addTarget:self action:@selector(popMenuBtnTap) forControlEvents:UIControlEventTouchUpInside];
    [popMenuBtn setImage:popMenuImage forState:UIControlStateNormal];
    [popMenuBtn setImageEdgeInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    [self addSubview:popMenuBtn];
    
    self.numLb = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)] autorelease];
    _numLb.textAlignment = NSTextAlignmentCenter;
    _numLb.backgroundColor = [UIColor clearColor];
    _numLb.text = [NSString stringWithFormat:@"%d/%d",_nowSelectIndex+1,[_imagesArr count]];
    _numLb.textColor = [UIColor grayColor];
    _numLb.center = CGPointMake(kScreen_Width/2, kScreen_Height-25);
    [self addSubview:_numLb];
    
    [self loadScrollViewWithPage:_nowSelectIndex];

}

- (void)popMenuBtnTap
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"转发" otherButtonTitles:@"保存到相册", nil];
    [actionSheet showInView:self];
    [actionSheet release];

}

- (void)imageBtnTap
{
    [self removeFromSuperview];
}
#pragma mark - UIscrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == _mainScrollView)
    {
        CGFloat pageWidth = CGRectGetWidth(_mainScrollView.frame);
        int page = floor((_mainScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        [self loadScrollViewWithPage:page];
    }
}

- (void)loadScrollViewWithPage:(int)page
{
    if(page < 0)
        return;
    _nowSelectIndex = page;
    _numLb.text = [NSString stringWithFormat:@"%d/%d",_nowSelectIndex+1,(unsigned long)[_imagesArr count]];
    
    OLImageView *imageView = (OLImageView*)[_mainScrollView viewWithTag:(kBaseImageViewTag+page)];

    OLImage *bigImage = [[ImageDataHelper sharedService] getYLGifImage:imageView.bigImageKey];

    if (!bigImage && !imageView.theDownloader) {
        [imageView startDownLoad];
    }
}

#pragma mark - UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self sendImageToOther];
            break;
        case 1:
            [self saveImageToAlbum];
            break;
        default:
            break;
    }
}
- (void)sendImageToOther
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendOtherImage:)]) {
        NSString *image = [[_imagesArr objectAtIndex:_nowSelectIndex] objectForKey:@"image"];
        NSString *sendStr = [NSString stringWithFormat:@"%@%@%@",StartImageContent,image,EndImageContent];
        [self.delegate sendOtherImage:sendStr];
        [self removeFromSuperview];
    }
}

- (void)saveImageToAlbum
{
    NSString *imageStr = [[_imagesArr objectAtIndex:_nowSelectIndex] objectForKey:@"image"];
    NSArray *arr = [imageStr componentsSeparatedByString:@";"];

    UIImage *image = [[ImageDataHelper sharedService] getImageWithName:[arr objectAtIndex:0]];
    if (image) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    else
    {
        [SVProgressHUD  setAnimationDuration:1.0f];
        [SVProgressHUD showErrorWithStatus:@"图片未下载"];
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    if (error != NULL) {
        NSLog(@"保存图片出错:%@",error);
        [SVProgressHUD  setAnimationDuration:1.0f];
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }
    else{
        NSLog(@"保存图片成功");
        [SVProgressHUD  setAnimationDuration:1.0f];
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}


#pragma mark - 下载大图成功
- (void)getSmallImageBack:(UIImage *)smallImage witMsgId:(NSString *)msgId
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(getSmallImageBack:witMsgId:)]) {
        [self.delegate getSmallImageBack:smallImage witMsgId:msgId];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
