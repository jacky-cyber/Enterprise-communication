//
//  PullSelfPicVC.m
//  JieXinIphone
//
//  Created by macOne on 14-3-17.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "PullSelfPicVC.h"
#import "PicWallCell.h"
#import "ConstantValue.h"
#import "ASIFormDataRequest.h"
#import "UIImage-Extensions.h"

@interface PullSelfPicVC ()

@property (nonatomic, retain) PullTableView *rootTblewView;


@end

@implementation PullSelfPicVC


#define ZONGSHU [dataSourceArray count]
#define HEI  100
#define UPLOAD_IMAGENAME @"image_up.png"
#define ADDIMAGEALERT_TAG 9001
#define LONGPRESS_TAG 9002
#define MOVEDISTINCE 215

@synthesize dic_cell;

@synthesize dataSourceArray;
@synthesize normalImage;
@synthesize xuanzhuancount;

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
    self.rootTblewView.delegate = self;
    self.rootTblewView.dataSource = self;
    self.rootTblewView.separatorStyle = UITableViewCellAccessoryNone;
       self.dic_cell = [NSMutableDictionary dictionary];
    CGRect rect = [[UIScreen mainScreen] bounds];
    if (rect.size.height < 568.0f) {
        CGFloat fwidth = self.view.frame.size.width;
        CGFloat fheight = self.view.frame.size.height - (568.0f - rect.size.height);
        [self.view setFrame:CGRectMake(0, 0, fwidth, fheight)];
    }
    [[STHUDManager sharedManager] showHUDInView:self.view_01];
    NSThread *thread_01 = [[[NSThread alloc] initWithTarget:self selector:@selector(kaiPi) object:nil] autorelease];
    [thread_01 start];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ON_NOTIFICATION:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ON_NOTIFICATION:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //Cancel以后将ImagePicker删除
    [self dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
-(void)kaiPi
{
    [self performSelectorOnMainThread:@selector(initDateSource) withObject:self waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(initRefresh) withObject:self waitUntilDone:YES];
    [[STHUDManager sharedManager] hideHUDInView:self.view_01];
}
-(void)initRefresh
{
    PullTableView *aTableView = [[PullTableView alloc] initWithFrame:CGRectMake(0, 0, self.view_01.layer.frame.size.width, self.view_01.layer.frame.size.height) style:UITableViewStylePlain];
    aTableView.pullTableIsLoadingMore = NO;
    [aTableView configRefreshType:BothRefresh];
    aTableView.dataSource =self;
    aTableView.delegate = self;
    aTableView.pullDelegate= self;
    aTableView.layer.borderWidth = 1;
    aTableView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rootTblewView = aTableView;
    [aTableView release];
    [self.view_01 addSubview:self.rootTblewView];
}
-(NSString *)getDomaiId
{
    NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    NSString *companyPackageid = @"0";
    if([headStr isEqualToString:@"111.11.28.29"])
    {
        companyPackageid=@"0";
    }
    else if
        ([headStr isEqualToString:@"111.11.28.30"])
    {
        companyPackageid=@"3";
    }
    else if
        ([headStr isEqualToString:@"111.11.28.41"])
    {
        companyPackageid=@"1";
    }
    else if
        ([headStr isEqualToString:@"10.120.148.84"])
    {
        companyPackageid=@"4";
    }
    else if([headStr isEqualToString:@"111.11.28.57"])
    {
        companyPackageid = @"5";
    }
    else if([headStr isEqualToString:@"111.11.28.58"])
    {
        companyPackageid = @"6";
    }
    else if([headStr isEqualToString:@"111.11.29.65"])
    {
        companyPackageid = @"7";
    }
    else if([headStr isEqualToString:@"111.11.28.53"])
    {
        companyPackageid = @"8";
    }
    else if([headStr isEqualToString:@"111.11.28.1"])
    {
        companyPackageid = @"9";
    }
    return companyPackageid;
}

-(void)initDateSource
{
    NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    [[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain];
    
    NSDate *tomorrow = [NSDate dateWithTimeIntervalSinceNow: +(24*60*60) ];
//    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:tomorrow];
    [dateFormatter release];
    NSLog(@"init  tomorrow=%@",destDateString);
    NSString *dizhi = [NSString stringWithFormat:@"http://%@/webimadmin/api/image/person_photo_wall?domainid=%@&userid=%@&current_time=%@",headStr,[self getDomaiId],[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId],destDateString];
    NSURL *url = [NSURL URLWithString:dizhi];
    NSLog(@"init url =%@",url);
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    [request release];
    self.dataSourceArray = [NSMutableArray array];
    if(received!=nil)//有数据
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
        if([[dic valueForKey:@"status"]integerValue]==1)
        {
            if([[dic valueForKey:@"info"] isEqual:[NSNull null]])
            {
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"您目前没有上传的图片" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
//                [alert show];
//                [alert release];
            }
            else
            {
                NSLog(@"init [self.dataSourceArray count]＝%d",[self.dataSourceArray count]);
                if([self.dataSourceArray count]!=0)
                {
                    NSLog(@"init 清除数据");
                    [self.dataSourceArray removeAllObjects];
                }
                for (int i = 0; i < [[dic valueForKey:@"info"] count]; i++) {
                    NSDictionary *dicOne = [[dic valueForKey:@"info"]objectAtIndex:i];
                    for(int j=0;j< [[dicOne valueForKey:@"list"]count];j++)
                    {
                        [self.dataSourceArray addObject:[[dicOne valueForKey:@"list"]objectAtIndex:j]];
                    }
                }
            }

            
        }
        else if([[dic valueForKey:@"status"]integerValue]==0)
        {
//            [self alertViewLoadMoreResult:2];
        }
        else
        {
//            [self alertViewLoadMoreResult:2];
        }
    }
    else //没数据
    {
//        [self alertViewLoadMoreResult:2];
    }
    [self initCache];

}
-(void)initCache
{
    NSString *sPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *sImagePath = [sPath stringByAppendingPathComponent:@"temp_image"];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:sImagePath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:sImagePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEI;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"总数=%d",ZONGSHU);
    int t = 0;
    if(ZONGSHU==0)
    {
        t=0;
    }
    else
    {
        if(ZONGSHU%3==0)
        {
            t=(int)ZONGSHU/3;
        }
        else
        {
            t=(int)ZONGSHU/3+1;
        }
    }
    return t;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str_indentify =@"";
//    NSString *str_indentify11 = @"";
    if(ZONGSHU!=0)
    {
        if(ZONGSHU/3>=(indexPath.section+1))//这一行够3个
        {
            int number_m = (int)indexPath.section*3+0;
//            str_indentify=[[dataSourceArray objectAtIndex:number_m]valueForKey:@"pid"];
            str_indentify = [NSString stringWithFormat:@"%@_%@_%@",[[dataSourceArray objectAtIndex:number_m]valueForKey:@"pid"],[[dataSourceArray objectAtIndex:(number_m+1)]valueForKey:@"pid"],[[dataSourceArray objectAtIndex:(number_m+2)]valueForKey:@"pid"]];
        }
        else//这一行不够3个
        {
            if(ZONGSHU%3>0)
            {
                int number_n = (int)ZONGSHU/3*3;
//                str_indentify = [[dataSourceArray objectAtIndex:number_n]valueForKey:@"pid"];
                if(ZONGSHU-number_n==1)
                {
                    str_indentify = [NSString stringWithFormat:@"%@",[[dataSourceArray objectAtIndex:number_n]valueForKey:@"pid"]];
                }
                else if(ZONGSHU-number_n==2)
                {
                    str_indentify = [NSString stringWithFormat:@"%@_%@",[[dataSourceArray objectAtIndex:number_n]valueForKey:@"pid"],[[dataSourceArray objectAtIndex:(number_n+1)]valueForKey:@"pid"]];
                }
            }
        }
    }
    NSString *str_ID = [NSString stringWithFormat:@"%d_%@",indexPath.section,str_indentify];
    NSString *kCustomCellID = [NSString stringWithFormat:@"%@",str_ID];
//    NSLog(@"kCustomCellID=%@",kCustomCellID);
    NSString *delete_cellIdentify =@"";
    if([self.dic_cell valueForKey:[NSString stringWithFormat:@"%d",indexPath.section]]!=nil)
    {
        delete_cellIdentify = [self.dic_cell valueForKey:[NSString stringWithFormat:@"%d",indexPath.section]];
    }
    //    NSString *kCustomCellID = [NSString stringWithFormat:@"PicWallCell"];
    
	PicWallCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellID];
	if (cell == nil)
	{
//        NSLog(@"%@ 创建",kCustomCellID);
        [self.dic_cell setObject:kCustomCellID forKey:[NSString stringWithFormat:@"%d",indexPath.section]];
		cell = [[PicWallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID];
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if(ZONGSHU!=0)
        {
            if(ZONGSHU/3>=(indexPath.section+1))//这一行够3个
            {
                int number_01 = (int)indexPath.section*3+0;
                int number_02 = number_01+1;
                int number_03 = number_02+1;
                cell.image_01.tag = number_01+1;
                cell.image_02.tag = number_02+1;
                cell.image_03.tag = number_03+1;
                [cell.image_01 setBackgroundImage:[UIImage imageNamed:@"photo_none.png"] forState:UIControlStateNormal];
                [cell.image_02 setBackgroundImage:[UIImage imageNamed:@"photo_none.png"] forState:UIControlStateNormal];
                [cell.image_03 setBackgroundImage:[UIImage imageNamed:@"photo_none.png"] forState:UIControlStateNormal];
                
                
                [self imageWithPath:[[dataSourceArray objectAtIndex:number_01]valueForKey:@"path"] andTag:number_01];
                [self imageWithPath:[[dataSourceArray objectAtIndex:number_02]valueForKey:@"path"] andTag:number_02];
                [self imageWithPath:[[dataSourceArray objectAtIndex:number_03]valueForKey:@"path"] andTag:number_03];
                
            }
            else//这一行不够3个
            {
                if(ZONGSHU%3>0)
                {
                    int number_01 = (int)ZONGSHU/3*3;
                    cell.image_01.tag =number_01+1;
                    [cell.image_01 setBackgroundImage:[UIImage imageNamed:@"photo_none.png"] forState:UIControlStateNormal];
                    
                    [self imageWithPath:[[dataSourceArray objectAtIndex:number_01]valueForKey:@"path"] andTag:number_01];
                    if(ZONGSHU%3>1)
                    {
                        int number_02 = (int)ZONGSHU/3*3+1;
                        cell.image_02.tag = number_02+1;
                        [cell.image_02 setBackgroundImage:[UIImage imageNamed:@"photo_none.png"] forState:UIControlStateNormal];
                        
                        [self imageWithPath:[[dataSourceArray objectAtIndex:number_02]valueForKey:@"path"] andTag:number_02];
                    }
                }
                
            }
            
        }
        if(![delete_cellIdentify isEqualToString:@""])
        {
            
            PicWallCell *cell = [tableView dequeueReusableCellWithIdentifier:delete_cellIdentify];
            if(cell!=nil)
            {
//                NSLog(@"删除%@",delete_cellIdentify);
                [cell release];
            }
            else
            {
//                NSLog(@"%@是空",delete_cellIdentify);
            }
        }
    }
    return cell;
}

-(void)imageWithPath:(NSString *)path andTag:(int)Tag
{
    //判断图片本地是否存在（存在用本地 不存在加载）
    NSString *imagePid = [[dataSourceArray objectAtIndex:Tag]valueForKey:@"pid"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *sPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *sImagePath = [sPath stringByAppendingPathComponent:@"temp_image"];
    
    
    if(![fileManager fileExistsAtPath:[sImagePath stringByAppendingPathComponent:imagePid]]) //如果不存在
    {
//        NSLog(@"图片%@网络加载",imagePid);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
            NSString *dizhi = [NSString stringWithFormat:@"http://%@/webimadmin/%@",headStr,path];
            NSURL *url = [NSURL URLWithString:dizhi];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image_01 = [UIImage imageWithData:data];
            if(data !=nil)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self addActionWithPic:Tag andimage:image_01];
                    //图片写入本地
                    [self saveImage:image_01 WithName:imagePid];
                });
            }
        });
        //
    }
    else
    {
//        NSLog(@"图片%d本地加载",Tag);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *sPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *sImagePath = [sPath stringByAppendingPathComponent:@"temp_image"];
            NSString* fullPathToFile = [sImagePath stringByAppendingPathComponent:imagePid];
            UIImage *image_01 = [UIImage imageWithContentsOfFile:fullPathToFile];
            if(image_01 !=nil)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self addActionWithPic:Tag andimage:image_01];
                });
            }
        });
        //
    }
}
-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer{
    
    UIButton *btn = (UIButton*)gestureRecognizer.view;
    self.currentImagePage = (int)btn.tag;
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提醒" message:@"确定要删除该图片吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = LONGPRESS_TAG;
        [alert show];
    }
}
-(void)addActionWithPic:(int)Tag andimage:(UIImage *)image
{
//    UIImage *resultImage = [UIImage image:image fitInSize:CGSizeMake(image.size.width/2, image.size.height/2)];
//    NSData * imageData = UIImageJPEGRepresentation(resultImage, 0.5f);
    UIButton *button = (UIButton *)[self.view viewWithTag:(Tag+1)];
//    [button setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showPic:) forControlEvents:UIControlEventTouchUpInside];

    //加长按方法
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress.minimumPressDuration = 0.5; //定义按的时间
    [button addGestureRecognizer:longPress];
    [longPress release];
}
-(void)showPic:(UIButton *)button
{
    UIView *view_back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view_01.frame.size.height)];
    view_back.backgroundColor = [UIColor whiteColor];
    [self.view_01 addSubview:view_back];
    [view_back release];

    
    UIImageView *imagev = [[UIImageView alloc]init];
    imagev.userInteractionEnabled = YES;
    imagev.image = button.currentBackgroundImage;
    imagev.contentMode = UIViewContentModeScaleAspectFit;
    imagev.tag = button.tag;
    self.currentImagePage = imagev.tag;
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removePic:)];
    [imagev addGestureRecognizer:singleTap];
    [singleTap release];
    
    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipFrom:)];
    [swipRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [imagev addGestureRecognizer:swipRight];
    [swipRight release];
    
    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipFrom:)];
    [swipLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [imagev addGestureRecognizer:swipLeft];
    [swipLeft release];
    
    [imagev setFrame:CGRectMake(10, 10, 300, view_back.frame.size.height-10-40-30-10)];
    [view_back addSubview:imagev];
    [imagev release];
    
}

-(void)swipFrom:(UISwipeGestureRecognizer *)swipRecognizer
{
    if(self.currentImagePage<=1&&swipRecognizer.direction==UISwipeGestureRecognizerDirectionRight)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已经到边界不能再滑动了" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if((self.currentImagePage>=[self.dataSourceArray count])&&(swipRecognizer.direction==UISwipeGestureRecognizerDirectionLeft))
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已经到边界不能再滑动了" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else
    {
        UIImageView *img_swip = (UIImageView*)swipRecognizer.view;
        if(swipRecognizer.direction==UISwipeGestureRecognizerDirectionRight)
        {
            self.currentImagePage--;
        }
        else if(swipRecognizer.direction==UISwipeGestureRecognizerDirectionLeft)
        {
            self.currentImagePage++;
        }
        
        NSString *imagePid = [[dataSourceArray objectAtIndex:(self.currentImagePage-1)]valueForKey:@"pid"];
        NSString *sPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *sImagePath = [sPath stringByAppendingPathComponent:@"temp_image"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if(![fileManager fileExistsAtPath:[sImagePath stringByAppendingPathComponent:imagePid]]) //如果不存在
        {
            img_swip.image = [UIImage imageNamed:@"photo_none.png"];
        }
        else
        {
            img_swip.image = [UIImage imageWithContentsOfFile:[sImagePath stringByAppendingPathComponent:imagePid]];
        }
        
    }
}
-(void)removePic:(UITapGestureRecognizer *)gestureRecognizer
{
    UIImageView *img_remove = (UIImageView*)gestureRecognizer.view;
    UIView *view_remove = (UIView *)[img_remove superview];
    [view_remove removeFromSuperview];
}

#pragma mark -
#pragma mark Add Images methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==ADDIMAGEALERT_TAG)
    {
        switch (buttonIndex)
        {
            case 0:
            {
                break;
            }
            case 1:
            {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.delegate = self;
                [self presentViewController:picker animated:YES completion:nil];
                [picker release];
                break;
            }
            case 2:
            {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                picker.delegate = self;
                [self presentViewController:picker animated:YES completion:nil];
                [picker release];
                break;
            }
            default:
                break;
        }
        
    }
    else if(alertView.tag==LONGPRESS_TAG)
    {
        switch (buttonIndex) {
            case 0:
            {
               break;
            }
            case 1:
            {
                [self deleteImage];
                break;
            }
            default:
                break;
        }
    }
    
}

#pragma mark -
#pragma mark Refresh and load more methods

- (void)refreshTable
{
    //刷新代码
    self.rootTblewView.pullLastRefreshDate = [NSDate date];
    self.rootTblewView.pullTableIsRefreshing = NO;
    //再调用一次初始化
    [self initDateSource];
    [self.rootTblewView reloadData];
  
}
- (void)loadMoreDataToTable
{
    //加载代码
    self.rootTblewView.pullTableIsLoadingMore = NO;
    NSLog(@"加载更多");
//    NSLog(@"最后的%@",[self.dataSourceArray objectAtIndex:([self.dataSourceArray count]-1)]);
    [self loadMoreImages];
    [self.rootTblewView reloadData];
}
-(void)loadMoreImages
{
    NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    [[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain];
    
    NSDictionary *lastImageDictionary = [self.dataSourceArray objectAtIndex:([self.dataSourceArray count]-1)];
    NSString *ssss = [lastImageDictionary valueForKey:@"add_time"];
    NSArray *arr = [ssss componentsSeparatedByString:@" "];
    NSString *destDateString = [arr objectAtIndex:0];
    NSLog(@"loadMore  destDateString===%@",destDateString);
    
    //    NSLog(@"tomorrow=%@",destDateString);
    NSString *dizhi = [NSString stringWithFormat:@"http://%@/webimadmin/api/image/person_photo_wall?domainid=%@&userid=%@&current_time=%@",headStr,[self getDomaiId],[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId],destDateString];
    NSURL *url = [NSURL URLWithString:dizhi];
    NSLog(@"loadmore url =%@",url);
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    [request release];
    if(received!=nil)//有数据
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
        if([[dic valueForKey:@"status"]integerValue]==1)
        {
            if([[dic valueForKey:@"info"] isEqual:[NSNull null]])
            {
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"您目前没有上传的图片" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
//                [alert show];
//                [alert release];
            }
            else
            {
                NSLog(@"loadmore [self.dataSourceArray count]＝%d",[self.dataSourceArray count]);
                for (int i = 0; i < [[dic valueForKey:@"info"] count]; i++) {
                    NSDictionary *dicOne = [[dic valueForKey:@"info"]objectAtIndex:i];
                    for(int j=0;j< [[dicOne valueForKey:@"list"]count];j++)
                    {
                        [self.dataSourceArray addObject:[[dicOne valueForKey:@"list"]objectAtIndex:j]];
                    }
                }
            }
        }
        else if([[dic valueForKey:@"status"]integerValue]==0)
        {
            //            [self alertViewLoadMoreResult:2];
        }
        else
        {
            //            [self alertViewLoadMoreResult:2];
        }
    }
    else //没数据
    {
        NSLog(@"LoadMore 没数据");
//        [self alertViewLoadMoreResult:2];
    }
    [self initCache];

}

- (void)dealloc {
    [_rootTblewView release];
    [_view_01 release];
    [_addImagesBtn release];
    [super dealloc];
}
#pragma mark -
#pragma mark PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
}
#pragma mark -
#pragma mark guan yu image
#pragma mark 保存图片
-(NSString *)getPicName
{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *destDateString = [[dateFormatter stringFromDate:now] stringByAppendingString:@"_tem_pic.png"];
    [dateFormatter release];
    return destDateString;
}
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    UIImage *resultImage = [UIImage image:tempImage fitInSize:tempImage.size];
    NSData * imageData = UIImageJPEGRepresentation(resultImage, 0.5f);
    NSString *sPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *sImagePath = [sPath stringByAppendingPathComponent:@"temp_image"];
    NSString* fullPathToFile = [sImagePath stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPathToFile atomically:NO];
}

#pragma mark 从文档目录下获取Documents路径
#pragma mark imagePicker delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])  {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.field_content== textField)  {
        if ([toBeString length] > 100)  {
            textField.text = [toBeString substringToIndex:100];
            return NO;
        }
    }
    return YES;
}
-(void)comment:(UIButton*)button_comment
{
    UIView *view_remove = (UIView *)[[button_comment superview]superview];
    [view_remove removeFromSuperview];
    self.addImagesBtn.hidden = NO;
    self.rightCorner_second.hidden = YES;
    [self saveImage:self.prepare_image WithName:UPLOAD_IMAGENAME];
    [[STHUDManager sharedManager] showHUDInView:self.view_01];
    [self UPloadFiles];
}
-(void)addCommentToPic:(UIImage*)aImage
{
    self.addImagesBtn.hidden = YES;
    UIView *view_back = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view_01.frame.size.height)]autorelease];
    view_back.backgroundColor = [UIColor whiteColor];
    [self.view_01 addSubview:view_back];
    //
    self.imageView_xuanze = [[[UIImageView alloc]init]autorelease];
    self.imageView_xuanze.userInteractionEnabled = YES;
    self.imageView_xuanze.contentMode = UIViewContentModeScaleAspectFit;
//    [imagev setFrame:CGRectMake(10, 10, 300, view_back.frame.size.height-70)];
    [self.imageView_xuanze setFrame:view_back.frame];
    self.imageView_xuanze.image = aImage;
    xuanzhuancount=0;
    self.normalImage=aImage;
    self.prepare_image = aImage;
    [view_back addSubview:self.imageView_xuanze];
    //
//    UIButton *btn_test = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_test setFrame:CGRectMake(260, 5, 30, 30)];
//    //    [btn_test setTitle:@"旋转" forState:UIControlStateNormal];
//    [btn_test setBackgroundImage:[UIImage imageNamed:@"xuanzhuan_nishizhen.png"] forState:UIControlStateNormal];
//    [btn_test addTarget:self action:@selector(xuanzhuan:) forControlEvents:UIControlEventTouchUpInside];
//    [imagev addSubview:btn_test];
    self.rightCorner_second.hidden = NO;
    [self.rightCorner_second addTarget:self action:@selector(xuanzhuan:) forControlEvents:UIControlEventTouchUpInside];
    //
    UIImageView *bottomV = [[[UIImageView alloc]initWithFrame:CGRectMake(0, view_back.frame.size.height-50, 320, 50)]autorelease];
    [bottomV setImage:[UIImage imageNamed:@"PicInfo_menu_bg.png"]];
    bottomV.userInteractionEnabled = YES;
    [view_back addSubview:bottomV];
    
    self.field_content = [[UITextField alloc]initWithFrame:CGRectMake(10, 8, 240, 34)];
    self.field_content.borderStyle = UITextBorderStyleRoundedRect;
    self.field_content.delegate = self;
    self.field_content.placeholder = @"随便说点什么";
    self.field_content.textAlignment = NSTextAlignmentLeft;
    self.field_content.font = [UIFont systemFontOfSize:15];
    self.field_content.text = @"";
    [bottomV addSubview:self.field_content];
    
    UIButton *btn_comment = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_comment setBackgroundImage:[UIImage imageNamed:@"PicInfo_commentBtn.png"] forState:UIControlStateNormal];
    [btn_comment setFrame:CGRectMake(255, self.field_content.frame.origin.y, 60, 34)];
    [btn_comment addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
    [bottomV addSubview:btn_comment];
    
}
//旋转
-(void)xuanzhuan:(UIButton *)button
{
    [UIView animateWithDuration:0.5f animations:^{
        switch (self.normalImage.imageOrientation) {
            case UIImageOrientationUp:
                self.normalImage = [UIImage imageWithCGImage:normalImage.CGImage scale:1.0 orientation:UIImageOrientationLeft ];
                
                break;
            case UIImageOrientationLeft:
                self.normalImage = [UIImage imageWithCGImage:normalImage.CGImage scale:1.0 orientation:UIImageOrientationDown ];
                
                break;
                
            case UIImageOrientationDown:
                self.normalImage = [UIImage imageWithCGImage:normalImage.CGImage scale:1.0 orientation:UIImageOrientationRight ];
                
                break;
                
            case UIImageOrientationRight:
                self.normalImage = [UIImage imageWithCGImage:normalImage.CGImage scale:1.0 orientation:UIImageOrientationUp];
                break;
            default:
                break;
        }
        self.imageView_xuanze.image = self.normalImage;
        self.prepare_image = self.imageView_xuanze.image;
        
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)aImage editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissModalViewControllerAnimated:YES];
    [self addCommentToPic:aImage];
}
- (void) UPloadFiles{
    
    NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    NSString *url=[NSString stringWithFormat:@"http://%@/webimadmin/api/image/photo_wall",headStr];
    
    NSMutableData *mt_data = [NSMutableData data];
    [mt_data appendData:[@"-----------------------------7de2c931411d6\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"Content-Disposition: form-data; name=\"domainid\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[[NSString stringWithFormat:@"%@\r\n", [self getDomaiId]] dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"-----------------------------7de2c931411d6\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"Content-Disposition: form-data; name=\"userid\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[[NSString stringWithFormat:@"%@\r\n", [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]] dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"-----------------------------7de2c931411d6\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"Content-Disposition: form-data; name=\"description\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[[NSString stringWithFormat:@"%@\r\n", self.field_content.text] dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"-----------------------------7de2c931411d6\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"Content-Disposition: form-data; name=\"image\"; filename=\"" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[[self getPicName] dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //
    [mt_data appendData:[@"Content-Type: image/jpeg\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //
    //////////////////////////////////////////
    NSString *sPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *sImagePath = [sPath stringByAppendingPathComponent:@"temp_image"];
    
    NSString* fullPathToFile = [sImagePath stringByAppendingPathComponent:UPLOAD_IMAGENAME];
    
    UIImage *image_01 = [UIImage imageWithContentsOfFile:fullPathToFile];
    UIImage *resultImage = [UIImage image:image_01 fitInSize:image_01.size];
    [mt_data appendData:UIImageJPEGRepresentation(resultImage, 0.5f)];
    /////////////////////////////////////////////
    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"-----------------------------7de2c931411d6--\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    ASIFormDataRequest *form = [[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]] autorelease];
    [form setTimeOutSeconds:60.0];
    form.delegate = self;
    [form addRequestHeader:@"Accept" value:@"text/html"];
    [form addRequestHeader:@"Content-Type" value:@"multipart/form-data; boundary=---------------------------7de2c931411d6"];
    [form addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%@", [NSNumber numberWithInteger:mt_data.length]]];
    [form setRequestMethod:@"POST"];
    [form setPostBody:mt_data];
    [form startAsynchronous];
    [form setDidFailSelector:@selector(requestBeFailed:)];
    [form setDidFinishSelector:@selector(requestBeFinished:)];

}

-(void)requestBeFailed:(ASIFormDataRequest *)sender
{
    [[STHUDManager sharedManager] hideHUDInView:self.view_01];
//    [self alertViewupLoadingImageResult:2];
}
-(void)requestBeFinished:(ASIFormDataRequest *)request
{
    [[STHUDManager sharedManager] hideHUDInView:self.view_01];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingMutableLeaves error:nil];
    if([[dic valueForKey:@"status"] intValue]==1)
    {
//        [self alertViewupLoadingImageResult:1];
        [self initDateSource];
        [self.rootTblewView reloadData];
    }
    else
    {
//        [self alertViewupLoadingImageResult:2];
    }
}
- (IBAction)goBack:(id)sender {
    
    if([[self.field_content superview]superview]!=nil)
    {
        UIView *view = (UIView *)[[self.field_content superview]superview];
        [view removeFromSuperview];
        self.addImagesBtn.hidden = NO;
        self.rightCorner_second.hidden = YES;
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (IBAction)addImagesAction:(id)sender {
    
    
    UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                  message:@"选择上传图片类型："
                                                 delegate:self
                                        cancelButtonTitle:@"取消"
                                        otherButtonTitles:@"拍照上传", @"相册读取",nil];
    alert.tag = ADDIMAGEALERT_TAG;
    [alert show];

}
//加载更多的时候成功
-(void)alertViewLoadMoreResult:(int)result
{
    NSString *str = nil;
    if(result==1)
    {
        str=@"加载成功";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:str message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(result==2)
    {
        str=@"加载失败";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:str message:@"原因:网络超时" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(result==3)
    {
        str =@"没有新图片再加载了";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:str message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
//图片上传结果
-(void)alertViewupLoadingImageResult:(int)result
{
    if(result==1)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"图片上传成功" message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(result==2)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"图片上传失败" message:@"原因:网络超时" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)deleteLocationImageFile
{
    //判断图片本地是否存在（存在用本地 不存在加载）
    NSString *imagePid = [[dataSourceArray objectAtIndex:(self.currentImagePage-1)]valueForKey:@"pid"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *sPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *sImagePath = [sPath stringByAppendingPathComponent:@"temp_image"];
    [fileManager removeItemAtPath:[sImagePath stringByAppendingPathComponent:imagePid] error:nil];

}
-(void)deleteImage
{
    NSLog(@"删除图片");
    //第一步，创建URL
    NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    NSString *dizhi = [NSString stringWithFormat:@"http://%@/webimadmin/api/image/photo_wall/%@/%@",headStr,[[self.dataSourceArray objectAtIndex:(self.currentImagePage-1)]valueForKey:@"pid"],[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]];
    NSURL *url = [NSURL URLWithString:dizhi];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setValue:@"text/html" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"DELETE"];//设置请求方式为POST，默认为GET
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(received)
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:nil];
        if([[dic valueForKey:@"status"]intValue]==1)
        {
//            [self alertViewDeleteImageResult:1];
            //再调用一次初始化
            [self deleteLocationImageFile];
            [self initDateSource];
            [self.rootTblewView reloadData];
        }
        else
        {
//            [self alertViewDeleteImageResult:2];
        }
    }
    else//没数据
    {
        [self alertViewDeleteImageResult:2];
    }
}
//图片删除结果
-(void)alertViewDeleteImageResult:(int)result
{
    if(result==1)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"图片删除成功" message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(result==2)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"图片删除失败" message:@"原因:网络超时" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (void) ON_NOTIFICATION:(NSNotification *) wParam
{
    
    if ([[wParam name] compare:UIKeyboardWillShowNotification] == NSOrderedSame) {
        NSDictionary *info = [wParam userInfo];
        CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        UIImageView *view_001 = (UIImageView *)[self.field_content superview];
        
        [view_001 setFrame:CGRectMake(0, self.view_01.frame.size.height - kbSize.height - view_001.frame.size.height, view_001.frame.size.width, view_001.frame.size.height)];
        
    }else if ([[wParam name] compare:UIKeyboardWillHideNotification] == NSOrderedSame) {
        
        UIImageView *view_001 = (UIImageView *)[self.field_content superview];
        [view_001 setFrame:CGRectMake(0, self.view_01.frame.size.height - view_001.frame.size.height,view_001.frame.size.width, view_001.frame.size.height)];
    }
}
@end
