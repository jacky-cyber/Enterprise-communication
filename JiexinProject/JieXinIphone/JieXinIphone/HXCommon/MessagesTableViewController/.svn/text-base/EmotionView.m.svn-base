//
//  EmotionView.m
//  JieXinIphone
//
//  Created by liqiang on 14-2-26.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "EmotionView.h"
#import "SelectCategoryBtn.h"

@interface EmotionView()<UIScrollViewDelegate>

@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableDictionary  *faceMeaningsDic;
@property (nonatomic, retain) NSMutableArray *bottomBtnsArr;
@property (nonatomic, retain) SelectCategoryBtn *currentEmojiBtn;

@end

@implementation EmotionView
- (void)dealloc
{
    self.imagesNameArr = nil;
    self.bgScrollView = nil;
    self.pageControl = nil;
    self.faceMeaningsDic = nil;
    self.bottomBtnsArr = nil;
    self.currentEmojiBtn = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDefaultDatas];
        self.backgroundColor = RGBCOLOR(240.0f, 240.0f, 240.0f);
        [self initSubViews];
        // Initialization code
    }
    return self;
}

- (void)initDefaultDatas
{
    self.imagesNameArr = [NSMutableArray arrayWithObjects:@"000",@"001",@"002",@"003",@"004",@"005",@"006",@"007",@"008",@"009",@"010",@"011",@"012",@"013",@"014",@"015",@"016",@"017",@"018",@"019",@"020",@"021",@"022",@"023",@"024",@"025",@"026",@"027",@"028",@"029",@"030",@"031",@"032",@"033",@"034",@"035",@"036",@"037",@"038",@"039",@"040",@"041",@"042",@"043",@"044",@"045",@"046",@"047",@"048",@"049",@"050",@"051",@"052",@"053",@"054",@"055",@"056",@"057",@"058",@"059", nil];
    NSDictionary *fangDic = @{@"NormalImage": @"emoji_fang_000.png",@"style":[NSNumber numberWithInt:FangEmojiStyle]};
    NSDictionary *yuanDic = @{@"NormalImage": @"emoji_yuan_000.png",@"style":[NSNumber numberWithInt:YuanEmojiStyle]};
    NSDictionary *bianDic = @{@"NormalImage": @"emoji_bian_000.png",@"style":[NSNumber numberWithInt:BianEmojiStyle]};
    NSDictionary *lingDic = @{@"NormalImage": @"emoji_000.png",@"style":[NSNumber numberWithInt:LingEmojiStyle]};
    self.bottomBtnsArr = [NSMutableArray arrayWithObjects:fangDic,yuanDic,bianDic,lingDic, nil];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"faceList" ofType:@"plist"];
    self.faceMeaningsDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
}

-(void)initSubViews
{
    float btnWidth = kScreen_Width/[_bottomBtnsArr count];
    float btnHeight = 40;
    for (int i = 0; i < [_bottomBtnsArr count]; i++) {
        NSDictionary *dic = [_bottomBtnsArr objectAtIndex:i];
        SelectCategoryBtn *btn = [SelectCategoryBtn buttonWithType:UIButtonTypeCustom];
        btn.style = (BottomEmojiBtnStyle)[[dic objectForKey:@"style"] intValue];
        btn.frame = CGRectMake(i*btnWidth, CGRectGetHeight(self.frame)-40, btnWidth, btnHeight);
        [btn addTarget:self action:@selector(selectWhichEmoji:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"emjoBg1.png"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"emjoBg2.png"] forState:UIControlStateSelected];

        UIImage *normalImage = [UIImage imageNamed:[dic objectForKey:@"NormalImage"]];
        [btn setImage:normalImage forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake((btnHeight-normalImage.size.height)/2, (btnWidth-normalImage.size.width)/2, (btnHeight-normalImage.size.height)/2, (btnWidth-normalImage.size.width)/2)];
        [self addSubview:btn];
        if (i == 0) {
            self.currentEmojiBtn = btn;
            _currentEmojiBtn.selected = YES;
        }
    }
    [self initContentView:_currentEmojiBtn.style];
}


- (void)initContentView:(BottomEmojiBtnStyle)style
{
    [self.bgScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 5, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-50)];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.delegate = self;
    scrollView.clipsToBounds = YES;
    self.bgScrollView = scrollView;
    [scrollView release];
    [self addSubview:_bgScrollView];
    
    
    self.pageControl=[[[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-60, CGRectGetWidth(_bgScrollView.frame), 20)] autorelease];
    _pageControl.backgroundColor=[UIColor clearColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    _pageControl.currentPage = 0;
    [self addSubview:_pageControl];
    
    
    int numberOfCols = 7;
    int numberOfRows =3;
    
    CGFloat itemHeight = 30;
    CGFloat itemWidth = 30;
    
    CGFloat verticalTopSideMargin = 10;
    CGFloat verticalBottomSideMargin = 20;
    
    NSString *imagePrefix = nil;
    switch (style) {
        case LingEmojiStyle:
            imagePrefix = @"emoji_";
            break;
        case FangEmojiStyle:
            imagePrefix = @"emoji_fang_";
            break;
        case YuanEmojiStyle:
            imagePrefix = @"emoji_yuan_";
            break;
        case BianEmojiStyle:
            imagePrefix = @"emoji_bian_";
            break;
        default:
            break;
    }
    //算页码：
    int pageCount = [_imagesNameArr count]/(numberOfRows*numberOfCols);
    //修正 不能整除的话就加1
    int fix = ([_imagesNameArr count]%(numberOfRows*numberOfCols))==0?0:1;
    pageCount = pageCount + fix;
    _pageControl.numberOfPages = pageCount;
    
    _bgScrollView.contentSize = CGSizeMake(CGRectGetWidth(_bgScrollView.frame)*pageCount, CGRectGetHeight(_bgScrollView.frame));
    
    int itemIndex = 0;
    
    for(int p = 0; p  < pageCount; p++)
    {
        UIScrollView *aScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(_bgScrollView.bounds.size.width*p+10, 0, _bgScrollView.bounds.size.width-20, _bgScrollView.bounds.size.height)];
        aScrollView.showsHorizontalScrollIndicator = NO;
        aScrollView.showsVerticalScrollIndicator = NO;
        aScrollView.backgroundColor = [UIColor clearColor];
        [aScrollView setScrollEnabled:NO];
        [_bgScrollView addSubview:aScrollView];
        [aScrollView release];
        
        CGFloat horizontalBetween = (aScrollView.bounds.size.width - itemWidth*numberOfCols)/(numberOfCols-1);
        CGFloat verticalBetween = (aScrollView.bounds.size.height- 2*verticalTopSideMargin-verticalBottomSideMargin - itemHeight*numberOfRows)/(numberOfRows-1);
        for (int i = 0; i<numberOfRows; i++)
        {
            for (int j=0; j<numberOfCols; j++)
            {
                if(itemIndex >= [_imagesNameArr count])
                    break;
                NSString *name = [_imagesNameArr objectAtIndex:(numberOfCols*i + j +p*numberOfCols*numberOfRows)];
                
                CGFloat centerX =  itemWidth*(0.5+j)+horizontalBetween*j;
                CGFloat centerY =  verticalTopSideMargin+ itemHeight*(0.5+i) + verticalBetween*i;
                CGPoint itemCenter = CGPointMake(centerX,centerY);
                
                
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",imagePrefix,name]];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                imageView.frame =CGRectMake(0, 0, itemWidth, itemHeight);
                imageView.center = itemCenter;
                imageView.userInteractionEnabled = YES;
                [aScrollView addSubview:imageView];
                [imageView release];
                
                SelectCategoryBtn *imageBt = [SelectCategoryBtn buttonWithType:UIButtonTypeCustom];
                imageBt.style = style;
                [imageBt addTarget:self action:@selector(imageBtnTap:) forControlEvents:UIControlEventTouchUpInside];
                imageBt.tag = numberOfCols*i + j +p*numberOfCols*numberOfRows;
                imageBt.frame =  CGRectMake(-3, -3, itemWidth+6, itemHeight+6);
                imageBt.center = itemCenter;
                [aScrollView addSubview:imageBt];
                
                itemIndex++;
            }
        }
    }
}


- (void)changePage:(id)sender
{
    int page = _pageControl.currentPage;
    [self loadScrollViewWithPage:page];
    
    CGRect frame = _bgScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [_bgScrollView scrollRectToVisible:frame animated:YES];

}

//scroller加载页面
- (void)loadScrollViewWithPage:(int)page
{
    if(page < 0)
        return;
    
    self.pageControl.currentPage = page;
}


- (void)imageBtnTap:(SelectCategoryBtn *)sender
{
    NSString *name = [_imagesNameArr objectAtIndex:sender.tag];
    
    NSString *imagePrefix = nil;
    switch (sender.style) {
        case LingEmojiStyle:
            imagePrefix = @"emoji_";
            break;
        case FangEmojiStyle:
            imagePrefix = @"emoji_fang_";
            break;
        case YuanEmojiStyle:
            imagePrefix = @"emoji_yuan_";
            break;
        case BianEmojiStyle:
            imagePrefix = @"emoji_bian_";
            break;
        default:
            break;
    }
    NSString *imageName = [NSString stringWithFormat:@"%@%@.png",imagePrefix,name];
    NSString *showName = [_faceMeaningsDic objectForKey:imageName];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectEmotionFinish:)] ) {
        [self.delegate selectEmotionFinish:[NSDictionary dictionaryWithObjectsAndKeys:showName,@"image", nil] ];
    }
}

#pragma mark - 下面选中那种表情
- (void)selectWhichEmoji:(SelectCategoryBtn *)sender
{
    if (sender == _currentEmojiBtn) {
        return;
    }
    _currentEmojiBtn.selected = !_currentEmojiBtn.selected;
    sender.selected = !sender.selected;
    BottomEmojiBtnStyle style = sender.style;
    self.currentEmojiBtn = sender;
    [self initContentView:style];
}

#pragma mark -
#pragma scrollview delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = _bgScrollView.frame.size.width;
    int page = floor((_bgScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self loadScrollViewWithPage:page];
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
