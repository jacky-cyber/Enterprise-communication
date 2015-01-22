//
//  pullVC.m
//  JieXinIphone
//
//  Created by macOne on 14-3-7.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "pullVC.h"

#import "PicWallCell.h"
#import "ConstantValue.h"
#import "ASIFormDataRequest.h"
#import "PullSelfPicVC.h"
#import "UIImage-Extensions.h"
#import "PicInfoVC.h"
#import "ShowBigPicVC.h"


@interface pullVC ()

@property (nonatomic, retain) PullTableView *rootTblewView;

@end

@implementation pullVC

#define ZONGSHU [dataSourceArray count]
#define HEI  100
#define UPLOAD_IMAGENAME @"image_up.png"
#define ADDIMAGEALERT_TAG 9001
#define MOVEDISTINCE 215


@synthesize dataSourceArray;
@synthesize page;
@synthesize dic_cell;
@synthesize normalImage;
@synthesize xuanzhuancount;

//    新版图片墙是使用者自己上传到服务器指定目录
//public static final String URL_POSITION = "111.11.28.30";
//public static final String URL_DOWNLOAD_PHOTOWALL_PIC_PIRFIX = "http://" + URL_POSITION + "/webimadmin/";
//public static final String URL_PHOTOWALL = URL_DOWNLOAD_PHOTOWALL_PIC_PIRFIX + "api/image/photo_wall/"; // 所有人上传的图片
//public static final String URL_PHOTOWALL_ME = URL_DOWNLOAD_PHOTOWALL_PIC_PIRFIX + "api/image/person_photo_wall/"; // 该目录是存放我自己上传的图片

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
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    if (rect.size.height < 568.0f) {
        CGFloat fwidth = self.view.frame.size.width;
        CGFloat fheight = self.view.frame.size.height - (568.0f - rect.size.height);
        [self.view setFrame:CGRectMake(0, 0, fwidth, fheight)];
    }
    
    self.isCanLoadMore = YES;//可以下拉加载更多
    self.page_number = 18;//默认是20
    self.dic_cell = [NSMutableDictionary dictionary];
    self.dataSourceArray = [NSMutableArray array];
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
    self.page=1;
    NSString *dizhi = [NSString stringWithFormat:@"http://%@/webimadmin/api/image/photo_wall?domainid=%@&userid=%@&page=%d&page_number=%d",headStr,[self getDomaiId],[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId],self.page,self.page_number];
    NSURL *url = [NSURL URLWithString:dizhi];
//    NSLog(@"图片墙获取图片=%@",url);
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
//            NSLog(@"1");
//            NSLog(@"self.dataSourceArray = %@",[self.dataSourceArray count]);
            if([[dic valueForKey:@"info"] isKindOfClass:[NSNull class]])
            {
                NSLog(@"空数据3");
            }
            else
            {
                self.dataSourceArray = [NSMutableArray arrayWithArray:[dic valueForKey:@"info"]];
                NSLog(@"self.dataSourceArray====%@",self.dataSourceArray);
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
        [self alertViewLoadMoreResult:2];
    }
    
    [self initCache];
        NSLog(@"initDateSource");
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
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEI;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
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
    if(ZONGSHU!=0)
    {
        if(ZONGSHU/3>=(indexPath.section+1))//这一行够3个
        {
            int number_m = (int)indexPath.section*3+0;
            str_indentify=[[dataSourceArray objectAtIndex:number_m]valueForKey:@"pid"];
        }
        else//这一行不够3个
        {
            if(ZONGSHU%3>0)
            {
                int number_n = (int)ZONGSHU/3*3;
                str_indentify = [[dataSourceArray objectAtIndex:number_n]valueForKey:@"pid"];
            }
        }
    }
    NSString *str_ID = [NSString stringWithFormat:@"%d_%@",indexPath.section,str_indentify];
    NSString *kCustomCellID = [NSString stringWithFormat:@"%@",str_ID];
    NSString *delete_cellIdentify =@"";
    if([self.dic_cell valueForKey:[NSString stringWithFormat:@"%d",indexPath.section]]!=nil)
    {
        delete_cellIdentify = [self.dic_cell valueForKey:[NSString stringWithFormat:@"%d",indexPath.section]];
    }
    //    NSString *kCustomCellID = [NSString stringWithFormat:@"PicWallCell"];
	PicWallCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellID];
	if (cell == nil)
	{
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
//                  NSLog(@"%@是空",delete_cellIdentify);
            }
        }
    }
    }
    return cell;
}


- (void)dealloc {
    [_rootTblewView release];
    [_view_01 release];
    [_addImagesBtn release];
    [_rightCorner_second release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setRootTblewView:nil];
    [self setView_01:nil];
    [self setRightCorner_second:nil];
    [super viewDidUnload];
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

-(void)imageWithPath:(NSString *)path andTag:(int)Tag
{
    //判断图片本地是否存在（存在用本地 不存在加载）
    NSString *imagePid = [[dataSourceArray objectAtIndex:Tag]valueForKey:@"pid"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *sPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *sImagePath = [sPath stringByAppendingPathComponent:@"temp_image"];
    
    
    if(![fileManager fileExistsAtPath:[sImagePath stringByAppendingPathComponent:imagePid]]) //如果不存在
    {
        //        NSLog(@"%d图片网络加载",Tag);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
            NSString *dizhi = [NSString stringWithFormat:@"http://%@/webimadmin/%@",headStr,path];
            NSURL *url = [NSURL URLWithString:dizhi];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image_01 = [UIImage imageWithData:data];
            if(data !=nil)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //图片写入本地
                    [self saveImage:image_01 WithName:imagePid];
                    //显示
                    [self addActionWithPic:Tag andimage:image_01];
                });
            }
        });
        //
    }
    else
    {
        //        NSLog(@"%d图片本地加载",Tag);
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
-(void)addActionWithPic:(int)Tag andimage:(UIImage *)image
{
    UIButton *button = (UIButton *)[self.view viewWithTag:(Tag+1)];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showPic:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)showPic:(UIButton *)button
{
    ShowBigPicVC *showVC = [[[ShowBigPicVC alloc]initWithNibName:@"ShowBigPicVC" bundle:nil]autorelease];
    showVC.dataSourceArray = self.dataSourceArray;
    showVC.currentImagePage = button.tag;
    [self.navigationController pushViewController:showVC animated:YES];
    return;
    //
//    UIView *view_back = [[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds]autorelease];
//    view_back.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:view_back];
    UIView *view_back = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view_01.frame.size.width, self.view_01.frame.size.height)]autorelease];
    view_back.backgroundColor = [UIColor whiteColor];
    [self.view_01 addSubview:view_back];
    //
   UIImageView *imagev_one = [[UIImageView alloc]init];
    imagev_one.userInteractionEnabled = YES;
    imagev_one.image = button.currentBackgroundImage;
    imagev_one.contentMode = UIViewContentModeScaleAspectFit;
//    imagev_one.contentMode = UIViewContentModeScaleToFill;
    imagev_one.tag = button.tag;
    self.currentImagePage = (int)imagev_one.tag;
    imagev_one.frame = view_back.frame;
    [view_back addSubview:imagev_one];
    [imagev_one release];
    //
    imagev_one.multipleTouchEnabled = YES;
    UIPinchGestureRecognizer *pinGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    [imagev_one addGestureRecognizer:pinGesture];
    [pinGesture release];
    //
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [imagev_one addGestureRecognizer:pan];
    [pan release];
    //
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removePic:)];
    [imagev_one addGestureRecognizer:singleTap];
    [singleTap release];
    

//    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipFrom:)];
//    [swipRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
//    [imagev addGestureRecognizer:swipRight];
//    [swipRight release];
//    
//    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipFrom:)];
//    [swipLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
//    [imagev addGestureRecognizer:swipLeft];
//    [swipLeft release];
    //
//    UILabel *picNameLab = [[UILabel alloc]initWithFrame:CGRectMake(imagev_one.frame.origin.x+10, 20+5, 300, 30)];
//    NSString *nickname_str = [[self.dataSourceArray objectAtIndex:(button.tag-1)]valueForKey:@"nickname"];
//    NSString *description_str = [[self.dataSourceArray objectAtIndex:(button.tag-1)]valueForKey:@"description"];
//    NSString *all_str = @"";
//    if([description_str isEqualToString:@""])
//    {
//        all_str = nickname_str;
//    }
//    else
//    {
//        all_str = [NSString stringWithFormat:@"%@:%@",nickname_str,description_str];
//    }
//    picNameLab.text = [NSString stringWithFormat:@"%@",all_str];
//    picNameLab.backgroundColor = [UIColor clearColor];
//    [picNameLab setTextColor:[UIColor whiteColor]];
//    [picNameLab setNumberOfLines:0];
//    [picNameLab setFont:[UIFont boldSystemFontOfSize:16]];
//    picNameLab.lineBreakMode = NSLineBreakByWordWrapping;
//    picNameLab.tag = 1;
//    CGSize titleSize = [picNameLab.text sizeWithFont:picNameLab.font constrainedToSize:CGSizeMake(picNameLab.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//    [picNameLab setFrame:CGRectMake(picNameLab.frame.origin.x, picNameLab.frame.origin.y, picNameLab.frame.size.width, titleSize.height)];
//    [view_back addSubview:picNameLab];
//    [picNameLab release];
    //
//    UIView *view_transparent = [[[UIView alloc]initWithFrame:CGRectMake(250,[UIScreen mainScreen].bounds.size.height-80, 140, 50)]autorelease];
    
//     UIView *view_transparent = [[[UIView alloc]initWithF rame:CGRectMake(250,imagev_one.frame.size.height-80, 140, 50)]autorelease];
//    [view_transparent setBackgroundColor:[UIColor clearColor]];
//    [view_back addSubview:view_transparent];
    
    UIView *view_gray = [[[UIView alloc]initWithFrame:CGRectMake(self.view_01.frame.origin.x, self.view_01.frame.size.height-60, self.view_01.frame.size.width,60)]autorelease];
    [view_gray setBackgroundColor:[UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:0.5f]];
  
    [view_back addSubview:view_gray];
    
    UIButton *btn_goInfo = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_goInfo addTarget:self action:@selector(goToInfo:) forControlEvents:UIControlEventTouchUpInside];
    [btn_goInfo setBackgroundImage:[UIImage imageNamed:@"pullVC_goToInfo.png"] forState:UIControlStateNormal];
    [btn_goInfo setFrame:CGRectMake(140,15,40,30)];
    [view_gray addSubview:btn_goInfo];
   
//    [imagev_one setFrame:CGRectMake(view_back.frame.origin.x, picNameLab.frame.origin.y+picNameLab.frame.size.height+1, view_back.frame.size.width, view_back.frame.size.height-(picNameLab.frame.origin.y+picNameLab.frame.size.height+5))];
//    [imagev_one setFrame:self.view_01.frame];
}
-(void)goToInfo:(UIButton *)button
{
    PicInfoVC *infoVC = [[PicInfoVC alloc]initWithNibName:@"PicInfoVC" bundle:nil];
    infoVC.dataSourceArray_picInfo = self.dataSourceArray;
    infoVC.currentImagePage_picInfo = self.currentImagePage;
    [self.navigationController pushViewController:infoVC animated:YES];
    [infoVC release];
    UIView *view = (UIView *)[button superview];
    UIView *view_a = (UIView *)[view superview];
    [view_a removeFromSuperview];

}
//  拖拽手势响应事件
-(void) pan:(UIPanGestureRecognizer *) pan
{
    CGPoint point = [pan translationInView:pan.view];
    pan.view.transform = CGAffineTransformMakeTranslation(point.x, point.y);
    
}
//  捏合手势响应事件
-(void) pinch:(UIPinchGestureRecognizer *)pinch
{
    pinch.view.transform = CGAffineTransformMakeScale(pinch.scale, pinch.scale);
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
            UILabel *pickNameLab = (UILabel *)[[img_swip superview] viewWithTag:1];
            if ([pickNameLab isKindOfClass:[UILabel class]]) {
                pickNameLab.text = @"";
            }
            
            UILabel *timeLab = (UILabel *)[[img_swip superview] viewWithTag:2];
            if ([timeLab isKindOfClass:[UILabel class]]) {
                timeLab.text = @"";
            }
        }
        else
        {
            img_swip.image = [UIImage imageWithContentsOfFile:[sImagePath stringByAppendingPathComponent:imagePid]];
            UILabel *pickNameLab = (UILabel *)[[img_swip superview] viewWithTag:1];
            if ([pickNameLab isKindOfClass:[UILabel class]])
            [pickNameLab  setText:[NSString stringWithFormat:@"%@",[[self.dataSourceArray objectAtIndex:(self.currentImagePage-1)]valueForKey:@"nickname"]]];
            
            UILabel *timeLab = (UILabel *)[[img_swip superview] viewWithTag:2];
            if ([timeLab isKindOfClass:[UILabel class]])
            timeLab.text = [NSString stringWithFormat:@"拍摄时间:%@",[[[[self.dataSourceArray objectAtIndex:(self.currentImagePage-1)]valueForKey:@"add_time"] componentsSeparatedByString:@" "] objectAtIndex:0]];
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
    
}

#pragma mark -
#pragma mark Refresh and load more methods

- (void)refreshTable
{
    //刷新代码
    self.rootTblewView.pullLastRefreshDate = [NSDate date];
    self.rootTblewView.pullTableIsRefreshing = NO;
    [self initFirstPage];
}
-(void)initFirstPage
{
    NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    self.page=1;
    NSString *dizhi = [NSString stringWithFormat:@"http://%@/webimadmin/api/image/photo_wall?domainid=%@&userid=%@&page=%d&page_number=%d",headStr,[self getDomaiId],[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId],self.page,self.page_number];
    
    NSURL *url = [NSURL URLWithString:dizhi];
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
            self.dataSourceArray = [NSMutableArray arrayWithArray:[dic valueForKey:@"info"]];
        }
        else if([[dic valueForKey:@"status"]integerValue]==0)
        {
            //            [self alertViewLoadMoreResult:2];
        }
        else
        {
            //            [self alertViewLoadMoreResult:2];
        }
        [self.rootTblewView reloadData];
    }
    else//没数据
    {
        [self alertViewLoadMoreResult:2];
    }
    
}
- (void)loadMoreDataToTable
{
    //加载代码
    self.rootTblewView.pullTableIsLoadingMore = NO;
    if(self.isCanLoadMore==YES)
    {
        [self loadMoreImages];
    }
    else
    {
        //不能再加载了
        //        [self alertViewLoadMoreResult:3];
    }
}
-(void)loadMoreImages
{
    self.page++;
    NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    NSString *dizhi = [NSString stringWithFormat:@"http://%@/webimadmin/api/image/photo_wall?domainid=%@&userid=%@&page=%d&page_number=%d",headStr,[self getDomaiId],[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId],self.page,self.page_number];
    NSURL *url = [NSURL URLWithString:dizhi];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    [request release];
    if(received!=nil)
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
        if([[dic valueForKey:@"status"]integerValue]==1)
        {
            if([[NSMutableArray arrayWithArray:[dic valueForKey:@"info"]]count]<self.page_number)
            {
                if([[NSMutableArray arrayWithArray:[dic valueForKey:@"info"]]count]!=0)
                {
                    [self.dataSourceArray addObjectsFromArray:[NSMutableArray arrayWithArray:[dic valueForKey:@"info"]]];
                }
                self.isCanLoadMore = NO;
            }
            else
            {
                [self.dataSourceArray addObjectsFromArray:[NSMutableArray arrayWithArray:[dic valueForKey:@"info"]]];
            }
            //            [self alertViewLoadMoreResult:1];
            [self.rootTblewView reloadData];
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
    else
    {
        [self alertViewLoadMoreResult:2];
        self.page--;
    }
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
//保存图片
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
    self.field_content.text = textField.text;
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
//    UIImageView *imagev = [[[UIImageView alloc]init]autorelease];
//    imagev.userInteractionEnabled = YES;
//    imagev.contentMode = UIViewContentModeScaleToFill;
//    [imagev setFrame:view_back.frame];
//    imagev.image = aImage;
//    self.prepare_image = aImage;
//    [view_back addSubview:imagev];
    self.imageView_xuanze = [[[UIImageView alloc]init]autorelease];
    self.imageView_xuanze.userInteractionEnabled = YES;
    self.imageView_xuanze.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView_xuanze.autoresizesSubviews = YES;
    [self.imageView_xuanze setFrame:view_back.frame];
    self.imageView_xuanze.image = aImage;
    xuanzhuancount=0;
    self.normalImage=aImage;
    self.prepare_image = aImage;
    [view_back addSubview:self.imageView_xuanze];
    //
//    UIButton *btn_test = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_test setFrame:CGRectMake(260, 5, 30, 30)];
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
    self.field_content.placeholder = @"随便写点什么";
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
-(void)xuanzhuan:(UIButton *)button
{
//    UIImageView *imagev = (UIImageView *)[button superview];
//    long double rotate = 0.0;
//    CGRect rect;
//    float translateX = 0;
//    float translateY = 0;
//    float scaleX = 1.0;
//    float scaleY = 1.0;
//    UIGraphicsBeginImageContext(self.imageView_xuanze.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    //
//    xuanzhuancount = xuanzhuancount%4;
//    if(xuanzhuancount==3)
//    {
//        self.imageView_xuanze.image = normalImage;
//        xuanzhuancount++;
//        return;
//    }
//    rotate = M_PI_2;
//    rect = CGRectMake(0, 0, self.imageView_xuanze.size.width, self.imageView_xuanze.size.height);
//    translateX = 0;
//    translateY = -rect.size.width;
//    scaleY = rect.size.width/rect.size.height;
//    scaleX = rect.size.height/rect.size.width;
//    //做CTM变换
//    CGContextTranslateCTM(context, 0.0, rect.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    CGContextRotateCTM(context, rotate);
//    CGContextTranslateCTM(context, translateX, translateY);
//    CGContextScaleCTM(context, scaleX, scaleY);
//    //绘制图片
//     CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), self.imageView_xuanze.image.CGImage);
//    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
//    self.imageView_xuanze.image = newPic;
//    self.prepare_image = self.imageView_xuanze.image;
//    xuanzhuancount++;
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


//添加描述
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
    UIImage *resultImage = [UIImage image:image_01 fitInSize:CGSizeMake(image_01.size.width/2, image_01.size.height/2)];
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
        [self initFirstPage];
    }
    else
    {
        //        [self alertViewupLoadingImageResult:2];
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
