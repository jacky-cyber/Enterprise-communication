//
//  ReadViewController.m
//  JieXinIphone
//
//  Created by lxrent01 on 14-4-16.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//
#define kdocumentMange_IP @"111.11.28.20"
#define SCREENRECT   [UIScreen mainScreen].bounds 



#import "ReadViewController.h"
#import "SVProgressHUD.h"
#import "ASIHTTPRequest.h"
#import "UIImageView+WebCache.h"

@interface ReadViewController ()<ASIHTTPRequestDelegate,UIScrollViewDelegate>
@property (nonatomic) CGFloat lastScale;
@property (nonatomic) CGSize normalSize;
@property (nonatomic,strong) NSMutableArray *imageViewArray;
@property (nonatomic,strong) UIScrollView *scrollview;
@end

@implementation ReadViewController
@synthesize currentPage;
@synthesize allPage;
@synthesize urlStr;
@synthesize lastScale;
@synthesize normalSize;
@synthesize imgArr;
@synthesize imageViewArray;
@synthesize scrollview;

- (id)init
{
   
    self = [super init];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor whiteColor];
        [super createCustomNavBarWithoutLogo];
        
        [self initNavView];
        
        [self initMainView];
        
        [self initBottomView];
    
        currentPage=1;
        imageViewArray=[[NSMutableArray alloc] initWithCapacity:100];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)setAllPage:(int)allPag{
 
    if(allPag==0){
       _pageLabel.text=[NSString stringWithFormat:@"0/%d",allPag];
    }else{
    allPage=allPag;
    _pageLabel.text=[NSString stringWithFormat:@"1/%d",allPag];

        scrollview.contentSize=CGSizeMake(SCREENRECT.size.width*allPag, scrollview.frame.size.height);
        
        for(int i=0;i<allPag;i++){
            UIImageView *imageView=[[UIImageView alloc] init];
 
            imageView.frame=CGRectMake(SCREENRECT.size.width*i, 0, SCREENRECT.size.width, SCREENRECT.size.height);
            
            [imageViewArray addObject:imageView];
            
            [scrollview addSubview:imageView];
        }
        
    }
}

-(void)setUrlStr:(NSString *)urlString{

    if(urlString==nil || [urlString isEqualToString:@""]){
        [SVProgressHUD showErrorWithStatus:@"当前文档不可阅读"];
        return ;
    }
    urlStr=[[NSString   alloc] initWithFormat:@"http://%@/FileShare%@" ,kdocumentMange_IP,urlString]  ;
    NSString *resultUrl=[NSString stringWithFormat:@"%@/%d.jpg",urlStr,currentPage];
    NSURL *url = [NSURL URLWithString:resultUrl];

   UIImageView *firstView = imageViewArray[0];
    
    [firstView setImageWithURL:url];
    
}

-(void)setImgArr:(NSMutableArray *)imgArrs{
    imgArr=imgArrs;
   
    UIImageView *firstView = imageViewArray[0];
    firstView.image=imgArrs[0];

}

-(void)initMainView{
    
    scrollview=[[UIScrollView alloc] init];
    scrollview.frame=CGRectMake(0, self.iosChangeFloat+44, 320, SCREENRECT.size.height-40-22-_pageLabel.frame.size.height);
    scrollview.pagingEnabled=YES;
    scrollview.delegate=self;
    scrollview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:scrollview];
    
//    _ReadImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 66, 320, SCREENRECT.size.height-40-22-_pageLabel.frame.size.height)];
//    normalSize=_ReadImage.frame.size;
//   UIPinchGestureRecognizer* pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)] ;
//    [_ReadImage addGestureRecognizer:pinchRecognizer];
//    _ReadImage.userInteractionEnabled=YES;
//    [self.view addSubview:_ReadImage];
}

-(void)initBottomView{

    _pageLabel=[[UILabel alloc] initWithFrame:CGRectMake((SCREENRECT.size.width-20)/2, SCREENRECT.size.height-20, 40, 20)];
    _pageLabel.text=@"0/0";
    _pageLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_pageLabel];
    
    
//    UIButton *frontBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    frontBtn.frame=CGRectMake(_pageLabel.frame.origin.x-40, _pageLabel.frame.origin.y, 40, 20);
//    [frontBtn addTarget:self action:@selector(frontPage:) forControlEvents:UIControlEventTouchDown];
//    [frontBtn setTitle:@"上页" forState:UIControlStateNormal];
//    [frontBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.view addSubview:frontBtn];
//    
//    
//    UIButton *nextBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    nextBtn.frame=CGRectMake(_pageLabel.frame.origin.x+_pageLabel.frame.size.width, _pageLabel.frame.origin.y, 40, 20);
//    [nextBtn addTarget:self action:@selector(nextPage:) forControlEvents:UIControlEventTouchDown];
//    [nextBtn setTitle:@"下页" forState:UIControlStateNormal];
//    [nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.view addSubview:nextBtn];

}

- (void)initNavView
{
    
    //创建基视图
    UIView *baseView= [[UIView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat, SCREENRECT.size.width, 44)];
    [self.view addSubview:baseView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,2, 40, 40);
    [backBtn setShowsTouchWhenHighlighted:YES];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"nuiview_button_return.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside ];
    [baseView addSubview:backBtn];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(backBtn.frame.origin.x+backBtn.frame.size.width,2, 120, 40)];
    label.text = @"在线阅读";
    label.font = [UIFont systemFontOfSize:17.0f];
    label.textAlignment = NSTextAlignmentLeft;
    [baseView addSubview:label];

    
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)frontPage:(UIButton *)sender{

    if(currentPage<=1){
        [SVProgressHUD setAnimationDuration:1];
        [SVProgressHUD showErrorWithStatus:@"超过最小页数"];
    }else{
        currentPage--;
        
        UIImageView *currentImage = imageViewArray[currentPage-1];
        if(imgArr != nil && [imgArr count]!=0){
            
              currentImage.image=imgArr[currentPage-1];
        }else{
        
        NSString *resultUrl=[NSString stringWithFormat:@"%@/%d.jpg",urlStr,currentPage];
        NSURL *url = [NSURL URLWithString:resultUrl];
        [currentImage setImageWithURL:url];
        }
         _pageLabel.text=[NSString stringWithFormat:@"%d/%d",currentPage,allPage];
    }
   
}

-(void)nextPage:(UIButton *)sender{
    
    if(currentPage>=allPage){
        [SVProgressHUD setAnimationDuration:1];
        [SVProgressHUD showErrorWithStatus:@"超过最大页数"];
    }else{
        currentPage++;
        UIImageView *currentImage = imageViewArray[currentPage-1];
        if(imgArr != nil && [imgArr count]!=0){
            currentImage.image=imgArr[currentPage-1];
        }else{
        
        NSString *resultUrl=[NSString stringWithFormat:@"%@/%d.jpg",urlStr,currentPage];
        NSURL *url = [NSURL URLWithString:resultUrl];
        [currentImage setImageWithURL:url];
        }
     _pageLabel.text=[NSString stringWithFormat:@"%d/%d",currentPage,allPage];
    }
   

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

  currentPage = scrollview.contentOffset.x/SCREENRECT.size.width+1;
    if(currentPage==0){
        return ;
    }
    UIImageView *currentImage = imageViewArray[currentPage-1];
    if(imgArr != nil && [imgArr count]!=0){
        currentImage.image=imgArr[currentPage-1];
    }else{
        
        NSString *resultUrl=[NSString stringWithFormat:@"%@/%d.jpg",urlStr,currentPage];
        NSURL *url = [NSURL URLWithString:resultUrl];
        [currentImage setImageWithURL:url];
    }
    _pageLabel.text=[NSString stringWithFormat:@"%d/%d",currentPage,allPage];
    
//    NSLog(@"当前的页面%d",currentpage);
}

-(void)scale:(UIPinchGestureRecognizer *) sender  {//对图片进行缩放处理
    
  
    
    UIPinchGestureRecognizer *pinchSender=(UIPinchGestureRecognizer*)sender;
    
    if([pinchSender state] == UIGestureRecognizerStateEnded) {
        
      
        CGSize currSize=[pinchSender view].frame.size;
        CGSize screenSize=self.view.frame.size;
        if(currSize.width<screenSize.width/2){
            
            [UIView animateWithDuration:0.5 animations:^{
                
                CGRect rect=CGRectMake(0, 40+22, normalSize.width, normalSize.height);
                _ReadImage.frame=rect;
                
            }];
        }
        
        lastScale = 1.0;
        
        return;
        
    }
    
    
    CGFloat scale = 1.0 - (lastScale - [pinchSender scale]);
    
    CGAffineTransform currentTransform = [pinchSender view].transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
    [[pinchSender view] setTransform:newTransform];
    _ReadImage.transform = newTransform;
    
    lastScale = [pinchSender scale];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
