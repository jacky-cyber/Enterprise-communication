//
//  ScanImageView.m
//  JieXinIphone
//
//  Created by liqiang on 14-3-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//


#import "ScanImageView.h"
#import "NSString+MessagesView.h"
#import "ImageDataHelper.h"
#import "UIImage-Extensions.h"

@interface ScanImageView()<ImageDownloaderDelegate>

@property (nonatomic, retain) UIImageView *originalImageView;
@property (nonatomic, retain) ImageDownloader *theDownloader;
@property (nonatomic, copy) NSString *smallImageKey;
@property (nonatomic, copy) NSString *bigImageKey;


@end


@implementation ScanImageView

- (void)dealloc
{
    self.originalImageView = nil;
    self.theDownloader = nil;
    self.smallImageKey = nil;
    self.bigImageKey = nil;
    self.msgid = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubViews];
        // Initialization code
    }
    return self;
}


- (void)initSubViews
{
    self.backgroundColor = [UIColor blackColor];
    self.originalImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)] autorelease];
    _originalImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_originalImageView];
}

- (void)setOriginalImageWithUrl:(NSString *)url withSmallImageUrl:(NSString *)smallImageUrl
{
    self.bigImageKey = url;
    self.smallImageKey = smallImageUrl;
    UIImage *smallImage = [[ImageDataHelper sharedService] getImageWithName:smallImageUrl];
    //设置开始下载
    if (smallImage)
    {
        _originalImageView.image = smallImage;
    }
    else
    {
        _originalImageView.image = UIImageWithName(@"messageloading.png");
    }
    
    UIImage *originalImage = [[ImageDataHelper sharedService] getImageWithName:url];
    if (originalImage)
    {
        _originalImageView.image = originalImage;
        return;
    }
    [[STHUDManager sharedManager] showHUDInView:self];
    NSString *urlStr = nil;
    NSString *mainDomain = [[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain];
    if ([mainDomain hasPrefix:@"http"]) {
        
        urlStr = [NSString stringWithFormat:@"%@/webimadmin/%@",mainDomain,[NSString encodeChineseToUTF8:[url trimWhitespace]]];
    }
    else
    {
        
        urlStr = [NSString stringWithFormat:@"http://%@/webimadmin/%@",mainDomain,[NSString encodeChineseToUTF8:[url trimWhitespace]]];
    }
    
    NSURL *imageUrl = [NSURL URLWithString:urlStr];
    //这里得用id 值
    self.theDownloader = [[[ImageDownloader alloc] init] autorelease];
    _theDownloader.msgid = self.msgid;
    _theDownloader.imageKey = url;
    _theDownloader.delegate = self;
    [_theDownloader setImageWithURL:imageUrl];

}


- (void)getImageBack:(UIImage *)image withImageDownloader:(ImageDownloader *)imageDownloader
{
    [[STHUDManager sharedManager] hideHUDInView:self];
    _originalImageView.image = image;
    //然后将大图和小图都存起来  小图要处理以下 以免太大放到运行内存是出问题
    [[ImageDataHelper sharedService] storeWithImage:image imageName:self.bigImageKey];
    //小图处理存放
    UIImage *smallImage = [[ImageDataHelper sharedService] getImageWithName:self.smallImageKey];
    if (!smallImage)
    {
        smallImage = [UIImage getSmallImage:image];
        [[ImageDataHelper sharedService] storeWithImage:smallImage imageName:self.smallImageKey];
        if(self.delegate && [self.delegate respondsToSelector:@selector(getImageBack:withImageDownloader:)])
        {
            [self.delegate getImageBack:smallImage withImageDownloader:_theDownloader];
        }
    }
}

- (void)imageDownloader:(ImageDownloader *)imageDownloader didFailWithError:(NSError *)error;
{
    [[STHUDManager sharedManager] hideHUDInView:self];
    [[STHUDManager sharedManager] hideHUDWithLabel:@"下载失败" afterDelay:0.6f];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.theDownloader cancelCurrentImageLoad];
    self.theDownloader = nil;
    [self removeFromSuperview];
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
