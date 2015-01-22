//
//  OLImageView.m
//  OLImageViewDemo
//
//  Created by Diego Torres on 9/5/12.
//  Copyright (c) 2012 Onda Labs. All rights reserved.
//

#import "OLImageView.h"
#import "OLImage.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/QuartzCore.h>
#import "NSString+MessagesView.h"
#import "UIImage-Extensions.h"
#import "SVProgressHUD.h"
#import "ImageDataHelper.h"
#import "DACircularProgressView.h"

@interface OLImageView ()<ChatImageDownloaderDelegate>


@property (nonatomic, strong) OLImage *animatedImage;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic) NSTimeInterval accumulator;
@property (nonatomic) NSUInteger currentFrameIndex;
@property (nonatomic) NSUInteger loopCountdown;

//@property (nonatomic,strong) MHProgressView *progressView;
@property (nonatomic,strong) DACircularProgressView *progressView;




@end

@implementation OLImageView

const NSTimeInterval kMaxTimeStep = 1; // note: To avoid spiral-o-death

@synthesize runLoopMode = _runLoopMode;
@synthesize displayLink = _displayLink;

- (id)init
{
    self = [super init];
    if (self) {
        self.currentFrameIndex = 0;
    }
    return self;
}

- (void)dealloc
{
    [self.theDownloader cancelDownLoad];
}

- (CADisplayLink *)displayLink
{
    if (self.superview) {
        if (!_displayLink && self.animatedImage) {
            _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeKeyframe:)];
            [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:self.runLoopMode];
        }
    } else {
        [_displayLink invalidate];
        _displayLink = nil;
    }
    return _displayLink;
}

- (NSString *)runLoopMode
{
    return _runLoopMode ?: NSDefaultRunLoopMode;
}

- (void)setRunLoopMode:(NSString *)runLoopMode
{
    if (runLoopMode != _runLoopMode) {
        [self stopAnimating];
        
        NSRunLoop *runloop = [NSRunLoop mainRunLoop];
        [self.displayLink removeFromRunLoop:runloop forMode:_runLoopMode];
        [self.displayLink addToRunLoop:runloop forMode:runLoopMode];
        
        _runLoopMode = runLoopMode;
        
        [self startAnimating];
    }
}

- (void)setImage:(UIImage *)image
{
    if (image == self.image) {
        return;
    }
    
    [self stopAnimating];
    
    self.currentFrameIndex = 0;
    self.loopCountdown = 0;
    self.accumulator = 0;
    
    if ([image isKindOfClass:[OLImage class]] && image.images) {
        [super setImage:nil];
        self.animatedImage = (OLImage *)image;
        self.loopCountdown = self.animatedImage.loopCount ?: NSUIntegerMax;
        [self startAnimating];
    } else {
        self.animatedImage = nil;
        [super setImage:image];
    }
    [self.layer setNeedsDisplay];
}

- (void)setAnimatedImage:(OLImage *)animatedImage
{
    _animatedImage = animatedImage;
    if (animatedImage == nil) {
        self.layer.contents = nil;
    }
}

- (BOOL)isAnimating
{
    return [super isAnimating] || (self.displayLink && !self.displayLink.isPaused);
}

- (void)stopAnimating
{
    if (!self.animatedImage) {
        [super stopAnimating];
        return;
    }
    
    self.loopCountdown = 0;
    
    self.displayLink.paused = YES;
}

- (void)startAnimating
{
    if (!self.animatedImage) {
        [super startAnimating];
        return;
    }
    
    if (self.isAnimating) {
        return;
    }
    
    self.loopCountdown = self.animatedImage.loopCount ?: NSUIntegerMax;
    
    self.displayLink.paused = NO;
}

- (void)changeKeyframe:(CADisplayLink *)displayLink
{
    if (self.currentFrameIndex >= [self.animatedImage.images count] && [self.animatedImage isPartial]) {
        return;
    }
    self.accumulator += fmin(displayLink.duration, kMaxTimeStep);
    
    while (self.accumulator >= self.animatedImage.frameDurations[self.currentFrameIndex]) {
        self.accumulator -= self.animatedImage.frameDurations[self.currentFrameIndex];
        if (++self.currentFrameIndex >= [self.animatedImage.images count] && ![self.animatedImage isPartial]) {
            if (--self.loopCountdown == 0) {
                [self stopAnimating];
                return;
            }
            self.currentFrameIndex = 0;
        }
        self.currentFrameIndex = MIN(self.currentFrameIndex, [self.animatedImage.images count] - 1);
        [self.layer setNeedsDisplay];
    }
}

- (void)displayLayer:(CALayer *)layer
{
    if (!self.animatedImage || [self.animatedImage.images count] == 0) {
        return;
    }
    layer.contents = (__bridge id)([[self.animatedImage.images objectAtIndex:self.currentFrameIndex] CGImage]);
}

- (void)didMoveToWindow
{
    [super didMoveToWindow];
    if (self.window) {
        [self startAnimating];
    } else {
       dispatch_async(dispatch_get_main_queue(), ^{
           if (!self.window) {
               [self stopAnimating];
           }
       });
    }
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    if (self.superview) {
        //Has a superview, make sure it has a displayLink
        [self displayLink];
    } else {
        //Doesn't have superview, let's check later if we need to remove the displayLink
        dispatch_async(dispatch_get_main_queue(), ^{
            [self displayLink];
        });
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (!self.animatedImage) {
        [super setHighlighted:highlighted];
    }
}

- (UIImage *)image
{
    return self.animatedImage ?: [super image];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return self.image.size;
}

- (void)startDownLoad
{
    self.progressView = [[DACircularProgressView alloc] initWithFrame:CGRectMake(kScreen_Width/2-20, kScreen_Height/2-20, 40, 40)];
    _progressView.trackTintColor = [UIColor lightGrayColor];
    _progressView.progressTintColor =RGBCOLOR(41, 175, 208);
//    _progressView.backgroundColor = [UIColor redColor];
    [self addSubview:_progressView];
    
    
    NSString *urlStr = nil;
    NSString *mainDomain = [[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain];
    if ([mainDomain hasPrefix:@"http"]) {
        
        urlStr = [NSString stringWithFormat:@"%@/webimadmin/%@",mainDomain,[NSString encodeChineseToUTF8:[self.bigImageKey trimWhitespace]]];
    }
    else
    {
        
        urlStr = [NSString stringWithFormat:@"http://%@/webimadmin/%@",mainDomain,[NSString encodeChineseToUTF8:[self.bigImageKey trimWhitespace]]];
    }
    
    //这里得用id 值
    self.theDownloader = [[ISTChatImageDowmLoad alloc] init];
    _theDownloader.delegate = self;
    [_theDownloader startDownLoadImageData:urlStr];
}

- (void)imageDownloaderFailWithError:(NSError *)error withDownLoader:(ISTChatImageDowmLoad *)downLoader
{
    [_progressView removeFromSuperview];
    [SVProgressHUD setAnimationDuration:1.0f];
    if ([_bigImageKey hasSuffix:@".gif"]) {
        [SVProgressHUD showErrorWithStatus:@"下载GIF图失败"];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"下载高清图失败"];
    }
    [_progressView removeFromSuperview];
    [self.theDownloader cancelDownLoad];
    self.theDownloader = nil;
    
}
- (void)setProgress:(CGFloat)progress
{
    [_progressView setProgress:progress];
}
- (void)imageDownloaderFinishWithImageData:(NSData *)imageDate withDownLoader:(ISTChatImageDowmLoad *)downLoader
{
    [_progressView removeFromSuperview];
    [self.theDownloader cancelDownLoad];
    self.theDownloader = nil;
    self.image = [OLImage imageWithData:imageDate];
    //然后将大图和小图都存起来  小图要处理以下 以免太大放到运行内存是出问题
    //如果是gif图 就存放nsdata  和静态图分开处理的
    if ([self.bigImageKey hasSuffix:@".gif"]) {
        [[ImageDataHelper sharedService] storeWithGIFImageData:imageDate imageName:self.bigImageKey];
    }
    else
    {
        [[ImageDataHelper sharedService] storeWithImage:self.image imageName:self.bigImageKey];
     }
    //小图处理存放
    UIImage *smallImage = [[ImageDataHelper sharedService] getImageWithName:self.smallImageKey];
    if (!smallImage)
    {
        UIImage *image = [UIImage imageWithData:imageDate];
        smallImage = [UIImage getSmallImage:image];
        [[ImageDataHelper sharedService] storeWithImage:smallImage imageName:self.smallImageKey];
        if(self.delegate && [self.delegate respondsToSelector:@selector(getSmallImageBack:witMsgId:)])
        {
            [self.delegate getSmallImageBack:smallImage witMsgId:self.msgid];
        }
    }
    
}

@end
