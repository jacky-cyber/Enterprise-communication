//
//  PicInfoVC.m
//  JieXinIphone
//
//  Created by macOne on 14-3-24.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "PicInfoVC.h"
#import "SynUserIcon.h"
#import "UIImage-Extensions.h"
//
#import "User.h"
#import "LinkDateCenter.h"
#import "ChatDetailViewController.h"
#import "ChatConversationListFeed.h"
//
@interface PicInfoVC ()

@end

@implementation PicInfoVC
@synthesize aScrollView;
@synthesize allDictionary;
#define FONT [UIFont systemFontOfSize:14]
#define HEIGHT 50
#define VIEW_BOTTOM_TAG 9000
#define TEXTFIELDVIEW_TAG 9001
//#define MOVEDISTINCE 215
#define ZHONGWEN_KEYBOARD  中文
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
    self.commentCount=0;
    self.contentStr = @"";
    self.allDictionary = [NSMutableDictionary dictionary];
    [self initScrollView];
    //
    UIView *comView = [[[UIView alloc]initWithFrame:CGRectMake(0, self.view_01.frame.size.height-50, 320, 50)]autorelease];
    [comView setBackgroundColor:[UIColor whiteColor]];
    comView.tag = TEXTFIELDVIEW_TAG;
    [self.view_01 addSubview:comView];
    
    UIImageView *back_comView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"PicInfo_menu_bg.png"]]autorelease];
    back_comView.frame = comView.frame;
    //    back_comView.layer.borderColor = [UIColor grayColor].CGColor;
    //    back_comView.layer.borderWidth = 4.0f;
    [comView addSubview:back_comView];
    
    self.textField_content= [[[UITextField alloc]initWithFrame:CGRectMake(10, 8, 240, 34)]autorelease];
    self.textField_content.borderStyle = UITextBorderStyleRoundedRect;
    self.textField_content.delegate = self;
    [self.textField_content setBackgroundColor:[UIColor lightTextColor]];
    [self.textField_content setPlaceholder:@"发表您的评论"];
    [self.textField_content setFont:FONT];
    [self.textField_content setTextColor:[UIColor blackColor]];
    [comView addSubview:self.textField_content];
    
    UIButton *isComBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [isComBtn setBackgroundImage:[UIImage imageNamed:@"PicInfo_commentBtn.png"] forState:UIControlStateNormal];
    [isComBtn addTarget:self action:@selector(isToComment) forControlEvents:UIControlEventTouchUpInside];
    [isComBtn setFrame:CGRectMake(self.textField_content.frame.origin.x+self.textField_content.frame.size.width+5, self.textField_content.frame.origin.y, 60, self.textField_content.frame.size.height)];
    [comView addSubview:isComBtn];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ON_NOTIFICATION:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ON_NOTIFICATION:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if([self.textField_content isFirstResponder])
    {
        [self.textField_content resignFirstResponder];
    }
    //
    if(scrollView==aScrollView)
    {
        int m = (int)scrollView.contentOffset.x/320+1;
        if(m!=self.currentImagePage_picInfo)
        {
            self.currentImagePage_picInfo = m;
            [self showScrollview];
        }
    }
    //
    self.textField_content.text = @"";
    self.commentCount=0;
    self.contentStr = @"";
    
}

-(void)initScrollView
{
    self.array_oneOfcomment = [NSMutableArray array];
    aScrollView = [[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view_01.frame.size.width, self.view_01.frame.size.height)]autorelease];
    aScrollView.pagingEnabled = YES;
    aScrollView.scrollEnabled =NO;
    aScrollView.delegate = self;
    CGSize contentSize = CGSizeMake(320*[self.dataSourceArray_picInfo count], 400);
    [aScrollView setContentSize:contentSize];
    [self.view_01 addSubview:aScrollView];
    if([self.dataSourceArray_picInfo count]!=0)
    {
        int i = self.currentImagePage_picInfo-1;
        
//        for(int i=0;i<[self.dataSourceArray_picInfo count];i++)
//        {
//            NSLog(@"i=%d",i);
//            if(i!=self.currentImagePage_picInfo-1)
//                continue;
            UIScrollView *view = [[UIScrollView alloc]initWithFrame:CGRectMake(i*320, 0, 320, self.view_01.frame.size.height)];
            view.delegate = self;
            view.tag = i+1;
            [aScrollView addSubview:view];
            [view release];

            //
            UIImageView *headView = [[[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 50, 50)]autorelease];
            headView.userInteractionEnabled = YES;
            [view addSubview:headView];
            NSString *filePath = [NSString stringWithString:[NSString stringWithFormat:@"%@/%@.jpg",[[SynUserIcon sharedManager] getCurrentUserBigIconPath],[[self.dataSourceArray_picInfo objectAtIndex:i]valueForKey:@"userid"]]];
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:filePath] != NO)
            {
                headView.image = [UIImage imageWithContentsOfFile:filePath];
            }
            else
            {
                NSString *userId = [[self.dataSourceArray_picInfo objectAtIndex:i]valueForKey:@"userid"];
                User *user = [[LinkDateCenter sharedCenter] getUserWithUserId:userId];
                if([user.sex isEqualToString:@"0"])
                {
                    headView.image = [UIImage imageNamed:@"fm_online.png"];
                }
                else
                {
                    headView.image = [UIImage imageNamed:@"m_online.png"];
                }
            }
            //长按方法
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(headViewLongpress:)];
            [headView addGestureRecognizer:longPress];
            [longPress release];
            //
            //单机方法
            UITapGestureRecognizer *tapPress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewTappress:)];
            [headView addGestureRecognizer:tapPress];
            [tapPress release];
            //
            UILabel *label_nickname = [[[UILabel alloc]initWithFrame:CGRectMake(headView.frame.origin.x+headView.frame.size.width+20, 15, 200, 30)]autorelease];
            label_nickname.textAlignment = NSTextAlignmentLeft;
            label_nickname.textColor = [UIColor blackColor];
            label_nickname.font = [UIFont systemFontOfSize:16];
            label_nickname.text = [NSString stringWithFormat:@"%@",[[self.dataSourceArray_picInfo objectAtIndex:i]valueForKey:@"nickname"]];
            [view addSubview:label_nickname];
            //
//            UIButton *button_chat = [UIButton buttonWithType:UIButtonTypeCustom];
//            [button_chat setFrame:CGRectMake(250, label_nickname.frame.origin.y+3, 23, 18)];
//            button_chat.layer.cornerRadius = 5.0f;
//            button_chat.clipsToBounds = YES;
//            [button_chat setBackgroundImage:[UIImage imageNamed:@"PicInfo_faqihuifa.png"] forState:UIControlStateNormal];
//            [button_chat addTarget:self action:@selector(button_chatAction:) forControlEvents:UIControlEventTouchUpInside];
//            [view addSubview:button_chat];
            //
            UIImageView *imageV_downHeadView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, headView.frame.origin.y+headView.frame.size.height+5, 320, 1)]autorelease];
            [imageV_downHeadView setImage:[UIImage imageNamed:@"PicInfo_separate.png"]];
            [view addSubview:imageV_downHeadView];
            //

            UILabel *descriptionLab = [[UILabel alloc]initWithFrame:CGRectMake(10, imageV_downHeadView.frame.origin.y+imageV_downHeadView.frame.size.height+5, 300, 30)];
            descriptionLab.text = [NSString stringWithFormat:@"%@",[[self.dataSourceArray_picInfo objectAtIndex:i]valueForKey:@"description"]];
            [descriptionLab setTextColor:[UIColor blackColor]];
            [descriptionLab setNumberOfLines:0];
            [descriptionLab setTextAlignment:NSTextAlignmentLeft];
            descriptionLab.lineBreakMode = NSLineBreakByWordWrapping;
            descriptionLab.font = [UIFont systemFontOfSize:15];
            CGSize titleSize = [descriptionLab.text sizeWithFont:descriptionLab.font constrainedToSize:CGSizeMake(descriptionLab.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            [descriptionLab setFrame:CGRectMake(descriptionLab.frame.origin.x, descriptionLab.frame.origin.y, descriptionLab.frame.size.width, titleSize.height)];
            [view addSubview:descriptionLab];
            [descriptionLab release];
            //
            NSString *str_time = [[self.dataSourceArray_picInfo objectAtIndex:i]valueForKey:@"add_time"];
            NSString *timeStr = [str_time substringToIndex:[str_time length]-3];
            UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(descriptionLab.frame.origin.x, descriptionLab.frame.origin.y+descriptionLab.frame.size.height+5, 300, 30)];
            timeLab.text = [NSString stringWithFormat:@"%@",timeStr];
            [timeLab setTextColor:[UIColor blackColor]];
            [timeLab setTextAlignment:NSTextAlignmentRight];
            [timeLab setNumberOfLines:0];
            timeLab.lineBreakMode = NSLineBreakByWordWrapping;
            timeLab.font = [UIFont systemFontOfSize:15];
            CGSize titleSize2 = [timeLab.text sizeWithFont:timeLab.font constrainedToSize:CGSizeMake(timeLab.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            [timeLab setFrame:CGRectMake(timeLab.frame.origin.x, timeLab.frame.origin.y, timeLab.frame.size.width, titleSize2.height)];
            [view addSubview:timeLab];
            [timeLab release];
            //
            UIImageView *imageV_downTimeLab = [[[UIImageView alloc]initWithFrame:CGRectMake(0, timeLab.frame.origin.y+timeLab.frame.size.height+3, 320, 1)]autorelease];
            [imageV_downTimeLab setImage:[UIImage imageNamed:@"PicInfo_separate.png"]];
            [view addSubview:imageV_downTimeLab];
        
        self.under_timeY = imageV_downTimeLab.frame.origin.y+imageV_downTimeLab.frame.size.height;
//            if(i==self.currentImagePage_picInfo-1)
//            {
//                self.under_timeY = imageV_downTimeLab.frame.origin.y+imageV_downTimeLab.frame.size.height;
//                break;
//            }
//        }
    }
    
    [self showScrollview];

}
-(void)headViewTappress:(UITapGestureRecognizer *)gestureRecognizer
{
    UIImageView *img_gesture = (UIImageView*)gestureRecognizer.view;
//    UIView *view_img = (UIView *)[img_gesture superview];
    UIView *view_black = [[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds]autorelease];
    view_black.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view_black];
    
    UIImageView *imageV = [[[UIImageView alloc]initWithFrame:view_black.frame]autorelease];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    imageV.image = img_gesture.image;
    [view_black addSubview:imageV];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(view_black_romove:)];
    [view_black addGestureRecognizer:singleTap];
    [singleTap release];

}
-(void)view_black_romove:(UITapGestureRecognizer *)gestureRecognizer
{
     UIView *view_remove = (UIView *)gestureRecognizer.view;
    [view_remove removeFromSuperview];
}
-(void)headViewLongpress:(UILongPressGestureRecognizer*)gestureRecognizer
{
    if(![self.view viewWithTag:kAlertShowTag])
    {
        UIImageView *img_gesture = (UIImageView*)gestureRecognizer.view;
        UIView *view_img = (UIView *)[img_gesture superview];
        NSString *sender = [[self.dataSourceArray_picInfo objectAtIndex:(view_img.tag-1)]valueForKey:@"userid"];
        if (sender && [sender isKindOfClass:[NSString class]])
        {
            User *user = [[LinkDateCenter sharedCenter] getUserWithUserId:sender];
            CustomAlertView *customAllertView = [[CustomAlertView alloc] initWithAlertStyle:User_Style withObject:user];
            [self.view addSubview:customAllertView];
            customAllertView.delegate = self;
            customAllertView.tag = kAlertShowTag;
            [customAllertView release];
        }
    }
}

//-(void)button_chatAction:(UIButton *)button
//{
// 
//    NSString *groupid = [[self.dataSourceArray_picInfo objectAtIndex:(self.currentImagePage_picInfo-1)]valueForKey:@"userid"];
//    ChatDetailViewController *detail = [[ChatDetailViewController alloc] initWithNibName:nil bundle:nil];
//    ChatConversationListFeed  *feed = [[[ChatConversationListFeed alloc] init] autorelease];
//    //这里要传群组的id
//    feed.relativeId = [groupid intValue];
//    feed.isGroup = 0;
//    feed.loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
//    detail.conFeed = feed;
//    [[AppDelegate shareDelegate].rootNavigation pushViewController:detail animated:YES];
//    [detail release];
//}
-(void)showScrollview
{
    [aScrollView setContentOffset:CGPointMake(320*(self.currentImagePage_picInfo-1), 0) animated:YES];
//    if([[aScrollView viewWithTag:self.currentImagePage_picInfo]viewWithTag:VIEW_BOTTOM_TAG]==nil)
//    {
//        [self addCommentAtViewTag:self.currentImagePage_picInfo];
//    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [[STHUDManager sharedManager] showHUDInView:self.view_01];
}
-(void)viewDidAppear:(BOOL)animated
{
    if([[aScrollView viewWithTag:self.currentImagePage_picInfo]viewWithTag:VIEW_BOTTOM_TAG]==nil)
    {
        [self addCommentAtViewTag:self.currentImagePage_picInfo];
    }
    [[STHUDManager sharedManager] hideHUDInView:self.view_01];
}
-(void)addCommentAtViewTag:(int)Tag
{
    //    NSLog(@"i=======%d",Tag-1);
    if([self.array_oneOfcomment count]!=0)
    {
        [self.array_oneOfcomment removeAllObjects];
    }
    NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    NSString *dizhi = [NSString stringWithFormat:@"http://%@/webimadmin/api/image/comments?domainid=%@&pid=%@",headStr,[[self.dataSourceArray_picInfo objectAtIndex:(Tag-1)]valueForKey:@"domainid"],[[self.dataSourceArray_picInfo objectAtIndex:(Tag-1)]valueForKey:@"pid"]];
    
    NSURL *url = [NSURL URLWithString:dizhi];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    [request release];
    if(received!=nil)//有数据
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
        if([[dic valueForKey:@"status"]intValue]==1)
        {
            
            if([[dic valueForKey:@"info"] count]==0)
            {
                //                NSLog(@"还没有人评论");
                NSDictionary *dic_none = [NSDictionary dictionaryWithObject:@"还没有人评论" forKey:@"none"];
                [self.array_oneOfcomment addObject:dic_none];
            }
            else
            {
                for (int j=0; j<[[dic valueForKey:@"info"] count]; j++)
                {
                    NSDictionary *dic_one = [NSDictionary dictionaryWithDictionary:[[dic valueForKey:@"info"] objectAtIndex:j]];
                    
                    NSArray *array_firstKeys = [NSArray arrayWithObjects:@"nickname",@"content",@"time",@"fid",@"domainid",@"userid",@"pid",@"cid", nil];
                    NSArray *array_firstContents = [NSArray arrayWithObjects:[dic_one valueForKey:@"nickname"],[dic_one valueForKey:@"content"],[dic_one valueForKey:@"time"],[dic_one valueForKey:@"fid"],[dic_one valueForKey:@"domainid"],[dic_one valueForKey:@"userid"],[dic_one valueForKey:@"pid"], [dic_one valueForKey:@"cid"],nil];
                    NSDictionary *dic_first = [NSDictionary dictionaryWithObjects:array_firstContents forKeys:array_firstKeys];
                    
                    [self.array_oneOfcomment addObject:dic_first];
                    if([[dic_one allKeys]containsObject:@"children"])
                    {
                        [self process_03:dic_one];
                    }
                }
            }
            [self addCommentInfoWithTag:Tag andArray:self.array_oneOfcomment];
        }
        else//请求失败
        {
            NSLog(@"接口请求失败");
        }
    }
    else
    {
        NSLog(@"没有返回数据");
    }
    
}
-(void)addCommentInfoWithTag:(int)Tag andArray:(NSMutableArray *)array_info
{
    float  vertical_height = 0.0;
    [allDictionary setObject:self.array_oneOfcomment forKey:[NSString stringWithFormat:@"%d",Tag]];
 
    UIScrollView *view_comment = (UIScrollView *)[aScrollView viewWithTag:Tag];
    UIView *view_bottom = [[[UIView alloc]init]autorelease];
    [view_bottom setFrame:CGRectMake(0, self.under_timeY, view_comment.frame.size.width, HEIGHT*[array_info count])];
    view_bottom.tag = VIEW_BOTTOM_TAG;
    [view_comment addSubview:view_bottom];
    [view_comment setContentSize:CGSizeMake(view_comment.frame.size.width, 44+319+view_bottom.frame.size.height)];
    
    if([array_info count]==1)
    {
        UIView *view_one = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, view_bottom.frame.size.width, HEIGHT)]autorelease];
        [view_bottom addSubview:view_one];
        
        if([[[array_info objectAtIndex:0] valueForKey:@"none"] isEqualToString:@"还没有人评论"])
        {
            UILabel *label_one = [[[UILabel alloc]init]autorelease];
            label_one.font = [UIFont boldSystemFontOfSize:16];
            [label_one setFrame:CGRectMake(10, 0, 280, HEIGHT)];
            [label_one setTextColor:[UIColor lightGrayColor]];
            [label_one setText:[NSString stringWithFormat:@"%@",[[array_info objectAtIndex:0]valueForKey:@"none"]]] ;
            [label_one setTextAlignment:NSTextAlignmentCenter];
            [view_one addSubview:label_one];
            
            [view_one setSize:CGSizeMake(view_one.frame.size.width, label_one.frame.origin.y+label_one.frame.size.height)];
            
        }
        else
        {
            UILabel *label_one = [[[UILabel alloc]init]autorelease];
            label_one.font = FONT;
            [label_one setFrame:CGRectMake(10, 0, 140, HEIGHT/2)];
            [label_one setTextColor:[UIColor blueColor]];
            NSString *nicknameStr = [[array_info objectAtIndex:0]valueForKey:@"nickname"];
            NSString *contentStr = [[array_info objectAtIndex:0]valueForKey:@"content"];
            NSString *str_time = [[array_info objectAtIndex:0]valueForKey:@"time"];
            NSString *timeStr = [str_time substringToIndex:[str_time length]-3];
            [label_one setText:[NSString stringWithFormat:@"%@",nicknameStr]];
            [label_one setTextAlignment:NSTextAlignmentLeft];
            [view_one addSubview:label_one];
            //
            UILabel *label_two = [[[UILabel alloc]init]autorelease];
            label_two.font = FONT;
            [label_two setFrame:CGRectMake(160, 0, 150, HEIGHT/2)];
            [label_two setTextColor:[UIColor grayColor]];
            [label_two setText:[NSString stringWithFormat:@"%@",timeStr]];
            [label_two setTextAlignment:NSTextAlignmentRight];
            [view_one addSubview:label_two];
            //
//            UILabel *label_three = [[[UILabel alloc]init]autorelease];
//            label_three.font = FONT;
//            [label_three setFrame:CGRectMake(label_one.frame.origin.x, HEIGHT/2, 250, HEIGHT/2)];
//            [label_three setText:[NSString stringWithFormat:@"%@",contentStr]];
//            [label_three setTextAlignment:NSTextAlignmentLeft];
//            [view_one addSubview:label_three];
            //
            UILabel *label_three = [[[UILabel alloc]init]autorelease];
            label_three.font = FONT;
            [label_three setFrame:CGRectMake(label_one.frame.origin.x, HEIGHT/2, 250, HEIGHT/2)];
            [label_three setText:[NSString stringWithFormat:@"%@",contentStr]];
            [label_three setTextAlignment:NSTextAlignmentLeft];
            [label_three setNumberOfLines:0];
            label_three.lineBreakMode = NSLineBreakByWordWrapping;
            CGSize titleSize2 = [label_three.text sizeWithFont:label_three.font constrainedToSize:CGSizeMake(label_three.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            [label_three setFrame:CGRectMake(label_three.frame.origin.x, label_three.frame.origin.y, label_three.frame.size.width, titleSize2.height)];
            [view_one addSubview:label_three];
            if(label_three.frame.size.height>=HEIGHT/2)
            {
                [view_one setSize:CGSizeMake(view_one.frame.size.width, label_three.frame.origin.y+label_three.frame.size.height)];
            }
            //
            if([[[array_info objectAtIndex:0]valueForKey:@"userid"]intValue]==[[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]intValue])
            {
                //和本地一样的话
            }
            else
            {
                commentButton *button_comment = [[[commentButton alloc]init]autorelease];
                [button_comment setFrame:CGRectMake(280, HEIGHT/2+3, 18, 17)];
                button_comment.titleLabel.font = FONT;
                button_comment.identify = 1;
                [button_comment setBackgroundImage:[UIImage imageNamed:@"PicInfo_reply_icon.png"] forState:UIControlStateNormal];
                [button_comment addTarget:self action:@selector(addCommentForComment:) forControlEvents:UIControlEventTouchUpInside];
                [button_comment setBackgroundColor:[UIColor clearColor]];
                [view_one addSubview:button_comment];
            }
        }
        vertical_height = view_one.frame.origin.y+view_one.frame.size.height;
        
    }
    else
    {
        for(int i=0;i<[array_info count];i++)
        {
//            UIView *view_many = [[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT*i, view_bottom.frame.size.width, HEIGHT)]autorelease];
            UIView *view_many = [[[UIView alloc]initWithFrame:CGRectMake(0, vertical_height, view_bottom.frame.size.width, HEIGHT)]autorelease];
            [view_bottom addSubview:view_many];
            
            NSDictionary *dic_info_01 = [NSDictionary dictionaryWithDictionary:[array_info objectAtIndex:i]];
            
            if([[dic_info_01 valueForKey:@"fid"]intValue]==0)//一级的评论
            {
                if(i!=0)
                {
                    UIImageView *imageV_downlabel = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)]autorelease];
                    [imageV_downlabel setImage:[UIImage imageNamed:@"PicInfo_separate.png"]];
                    [view_many addSubview:imageV_downlabel];
                }
                UILabel *label_nickname = [[[UILabel alloc]initWithFrame:CGRectMake(10, 2, 140, HEIGHT/2)]autorelease];
                label_nickname.font = FONT;
                [label_nickname setText:[NSString stringWithFormat:@"%@",[dic_info_01 valueForKey:@"nickname"]]];
                [label_nickname setTextColor:[UIColor blueColor]];
                [view_many addSubview:label_nickname];
                
                UILabel *label_time = [[[UILabel alloc]initWithFrame:CGRectMake(160, label_nickname.frame.origin.y, 150, HEIGHT/2)]autorelease];
                [label_time setTextColor:[UIColor grayColor]];
                label_time.font = FONT;
                NSString *str_time = [dic_info_01 valueForKey:@"time"];
                NSString *timeStr = [str_time substringToIndex:[str_time length]-3];
                [label_time setText:[NSString stringWithFormat:@"%@",timeStr]];
                [label_time setTextAlignment:NSTextAlignmentRight];
                [view_many addSubview:label_time];
                
//                UILabel *label_content = [[[UILabel alloc]initWithFrame:CGRectMake(label_nickname.frame.origin.x, HEIGHT/2, 250, HEIGHT/2)]autorelease];
//                label_content.font = FONT;
//                [label_content setText:[NSString stringWithFormat:@"%@",[dic_info_01 valueForKey:@"content"]]];
//                [label_content setTextAlignment:NSTextAlignmentLeft];
//                [view_many addSubview:label_content];
                //
                UILabel *label_content = [[[UILabel alloc]initWithFrame:CGRectMake(label_nickname.frame.origin.x, HEIGHT/2, 250, HEIGHT/2)]autorelease];
                label_content.font = FONT;
                [label_content setText:[NSString stringWithFormat:@"%@",[dic_info_01 valueForKey:@"content"]]];
                [label_content setTextAlignment:NSTextAlignmentLeft];
                [label_content setNumberOfLines:0];
                label_content.lineBreakMode = NSLineBreakByWordWrapping;
                CGSize titleSize2 = [label_content.text sizeWithFont:label_content.font constrainedToSize:CGSizeMake(label_content.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                [label_content setFrame:CGRectMake(label_content.frame.origin.x, label_content.frame.origin.y, label_content.frame.size.width, titleSize2.height)];
                [view_many addSubview:label_content];
                if(label_content.frame.size.height>=HEIGHT/2)
                {
                    [view_many setSize:CGSizeMake(view_many.frame.size.width, label_content.frame.origin.y+label_content.frame.size.height)];
                }
                vertical_height = view_many.frame.origin.y+view_many.frame.size.height;
                //
                if([[dic_info_01 valueForKey:@"userid"]intValue]==[[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]intValue])
                {
                    //和本地一样的话
                }
                else
                {
                    commentButton *button_comment = [[[commentButton alloc]init]autorelease];
                    [button_comment setFrame:CGRectMake(280, HEIGHT/2+3, 18, 17)];
                    button_comment.titleLabel.font = FONT;
                    button_comment.identify = i+1;
                    [button_comment addTarget:self action:@selector(addCommentForComment:) forControlEvents:UIControlEventTouchUpInside];
                    [button_comment setBackgroundImage:[UIImage imageNamed:@"PicInfo_reply_icon.png"] forState:UIControlStateNormal];
                    [view_many addSubview:button_comment];
                }
            }
            else//回复类型的
            {
                UIImageView *replay_imageV02 = [[[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 320-20-10, HEIGHT)]autorelease];
                replay_imageV02.image = [UIImage imageNamed:@"PicInfo_reply_02.png"];
                [view_many addSubview:replay_imageV02];
                
                UIImageView *replay_imageV01 = [[[UIImageView alloc]initWithFrame:CGRectMake(20, replay_imageV02.frame.origin.y-5, 150, 10)]autorelease];
                replay_imageV01.image = [UIImage imageNamed:@"PicInfo_reply_01.png"];
                [view_many addSubview:replay_imageV01];
                
                UILabel *label_nickname1 = [[[UILabel alloc]initWithFrame:CGRectMake(25, 0, 45, HEIGHT/2)]autorelease];
                label_nickname1.font = FONT;
                [label_nickname1 setText:[NSString stringWithFormat:@"%@",[dic_info_01 valueForKey:@"nickname1"]]];
                [label_nickname1 setTextColor:[UIColor blueColor]];
                [label_nickname1 setBackgroundColor:[UIColor clearColor]];
                [view_many addSubview:label_nickname1];
                
                UILabel *label_huifu = [[[UILabel alloc]initWithFrame:CGRectMake(label_nickname1.frame.origin.x+label_nickname1.frame.size.width, label_nickname1.frame.origin.y, 30, HEIGHT/2)]autorelease];
                [label_huifu setTextColor:[UIColor blackColor]];
                [label_huifu setBackgroundColor:[UIColor clearColor]];
                label_huifu.font = FONT;
                [label_huifu setText:@"回复"];
                [view_many addSubview:label_huifu];
                
                UILabel *label_nickname2 = [[[UILabel alloc]initWithFrame:CGRectMake(label_huifu.frame.origin.x+label_huifu.frame.size.width, label_huifu.frame.origin.y, 45, HEIGHT/2)]autorelease];
                label_nickname2.font = FONT;
                [label_nickname2 setBackgroundColor:[UIColor clearColor]];
                [label_nickname2 setText:[NSString stringWithFormat:@"%@",[dic_info_01 valueForKey:@"nickname2"]]];
                [label_nickname2 setTextColor:[UIColor blueColor]];
                [view_many addSubview:label_nickname2];
                
                UILabel *label_time = [[[UILabel alloc]initWithFrame:CGRectMake(160, 0, 150, HEIGHT/2)]autorelease];
                [label_time setTextColor:[UIColor grayColor]];
                label_time.font = FONT;
                [label_time setBackgroundColor:[UIColor clearColor]];
                NSString *str_time = [dic_info_01 valueForKey:@"time"];
                NSString *timeStr = [str_time substringToIndex:[str_time length]-3];
                [label_time setText:[NSString stringWithFormat:@"%@",timeStr]];
                [label_time setTextAlignment:NSTextAlignmentRight];
                [view_many addSubview:label_time];
                
//                UILabel *label_content = [[[UILabel alloc]initWithFrame:CGRectMake(label_nickname1.frame.origin.x, HEIGHT/2, 250, HEIGHT/2)]autorelease];
//                [label_content setBackgroundColor:[UIColor clearColor]];
//                label_content.font =FONT;
//                [label_content setText:[NSString stringWithFormat:@"%@",[dic_info_01 valueForKey:@"content"]]];
//                [label_content setTextAlignment:NSTextAlignmentLeft];
//                [view_many addSubview:label_content];
                //
                UILabel *label_content = [[[UILabel alloc]initWithFrame:CGRectMake(label_nickname1.frame.origin.x, HEIGHT/2, 250, HEIGHT/2)]autorelease];
                [label_content setBackgroundColor:[UIColor clearColor]];
                label_content.font =FONT;
                [label_content setText:[NSString stringWithFormat:@"%@",[dic_info_01 valueForKey:@"content"]]];
                [label_content setTextAlignment:NSTextAlignmentLeft];
                [label_content setNumberOfLines:0];
                label_content.lineBreakMode = NSLineBreakByWordWrapping;
                CGSize titleSize2 = [label_content.text sizeWithFont:label_content.font constrainedToSize:CGSizeMake(label_content.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                [label_content setFrame:CGRectMake(label_content.frame.origin.x, label_content.frame.origin.y, label_content.frame.size.width, titleSize2.height)];
                [view_many addSubview:label_content];
                
                if(label_content.frame.size.height>=HEIGHT/2)
                {
                     [replay_imageV02 setSize:CGSizeMake(replay_imageV02.frame.size.width,label_content.frame.origin.y+label_content.frame.size.height)];
                    [view_many setSize:CGSizeMake(view_many.frame.size.width, label_content.frame.origin.y+label_content.frame.size.height)];
                }
                vertical_height = view_many.frame.origin.y+view_many.frame.size.height;
                //
                if([[dic_info_01 valueForKey:@"userid1"]intValue]==[[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]intValue])
                {
                    //和本地一样的话
                }
                else
                {
                    commentButton *button_comment = [[[commentButton alloc]init]autorelease];
                    [button_comment setFrame:CGRectMake(280, HEIGHT/2+3, 18, 17)];
                    button_comment.titleLabel.font = FONT;
                    button_comment.identify = i+1;
                    [button_comment addTarget:self action:@selector(addCommentForComment:) forControlEvents:UIControlEventTouchUpInside];
                    [button_comment setBackgroundImage:[UIImage imageNamed:@"PicInfo_reply_icon.png"] forState:UIControlStateNormal];
                    [button_comment setBackgroundColor:[UIColor clearColor]];
                    [view_many addSubview:button_comment];
                }
            }
        }
        
    }
    //
    [view_bottom setFrame:CGRectMake(0, self.under_timeY, view_comment.frame.size.width, vertical_height)];
    [view_comment setContentSize:CGSizeMake(view_comment.frame.size.width, 44+319+view_bottom.frame.size.height)];
    //
    UIImageView *imageV_down = [[[UIImageView alloc]initWithFrame:CGRectMake(0, view_bottom.frame.size.height-1, 320, 1)]autorelease];
    [imageV_down setImage:[UIImage imageNamed:@"PicInfo_separate.png"]];
    [view_bottom addSubview:imageV_down];
}

-(void)addCommentForComment:(commentButton *)btn_addComment
{
    self.commentCount=btn_addComment.identify;
    //成为第一响应者
    [self.textField_content becomeFirstResponder];
}

-(void)isToComment
{
    if([self.textField_content isFirstResponder])
    {
        self.contentStr = self.textField_content.text;
        [self.textField_content resignFirstResponder];
    }
    if([self.contentStr isEqualToString:@""])
    {
        return;
    }
    if(self.commentCount==0)
    {
        NSLog(@"评论图片");
        NSDictionary *dic_up = [NSDictionary dictionaryWithDictionary:[self.dataSourceArray_picInfo objectAtIndex:(self.currentImagePage_picInfo-1)]];
        //        NSLog(@"%@",dic_up);
        NSString *str_userid = [NSString stringWithFormat:@"%d",[[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]intValue]];
        //POST 请求
        //第一步，创建URL
        NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/webimadmin/api/image/comments?",headStr]];
        //第二步，创建请求
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
        NSString *str = [NSString stringWithFormat:@"fid=0&domainid=%@&userid=%@&pid=%@&content=%@",[dic_up valueForKey:@"domainid"],str_userid,[dic_up valueForKey:@"pid"],self.contentStr];//设置参数
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        //第三步，连接服务器
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        if(received!=nil)
        {
            NSDictionary *dic_result_post = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:nil];
            //            NSLog(@"%@",dic_result_post);
            if([[dic_result_post valueForKey:@"status"]intValue]==1)
            {
                NSLog(@"评论成功");
                [self refreshCurrentPage];
            }
            else
            {
                NSLog(@"评论失败");
            }
        }
        else
        {
            NSLog(@"没返回数据");
        }
    }
    else
    {
        //        NSLog(@"回复%d",self.commentCount);
        self.array_oneOfcomment = [self.allDictionary valueForKey:[NSString stringWithFormat:@"%d",self.currentImagePage_picInfo]];
        NSDictionary *dic_up = [NSDictionary dictionaryWithDictionary:[self.array_oneOfcomment objectAtIndex:(self.commentCount-1)]];
        //        NSLog(@"%@",dic_up);
        NSString *str_userid = [NSString stringWithFormat:@"%d",[[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]intValue]];
        //POST 请求
        //第一步，创建URL
        NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/webimadmin/api/image/comments?",headStr]];
        //第二步，创建请求
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
        NSString *str = [NSString stringWithFormat:@"fid=%@&domainid=%@&userid=%@&pid=%@&content=%@",[dic_up valueForKey:@"cid"],[dic_up valueForKey:@"domainid"],str_userid,[dic_up valueForKey:@"pid"],self.contentStr];//设置参数
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        //第三步，连接服务器
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        if(received!=nil)
        {
            NSDictionary *dic_result_post = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:nil];
            //            NSLog(@"%@",dic_result_post);
            if([[dic_result_post valueForKey:@"status"]intValue]==1)
            {
                NSLog(@"评论成功");
                [self refreshCurrentPage];
            }
            else
            {
                NSLog(@"评论失败");
            }
        }
        else
        {
            NSLog(@"没返回数据");
        }
    }
    self.contentStr=@"";
}
-(void)refreshCurrentPage
{
    if([[aScrollView viewWithTag:self.currentImagePage_picInfo]viewWithTag:VIEW_BOTTOM_TAG]!=nil)
    {
        UIView *view = (UIView *)[[aScrollView viewWithTag:self.currentImagePage_picInfo]viewWithTag:VIEW_BOTTOM_TAG];
        [view removeFromSuperview];
    }
    [self addCommentAtViewTag:self.currentImagePage_picInfo];
    self.textField_content.text = @"";
    self.commentCount = 0;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])  {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.textField_content == textField)  {
        if ([toBeString length] > 100)  {
            textField.text = [toBeString substringToIndex:100];
            return NO;
        }
    }
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.contentStr = @"";
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.contentStr = textField.text;
    [textField resignFirstResponder];
    return YES;
}
-(void)process_03:(id)object
{
    if (object == nil) {
        return;
    }else if ([object isKindOfClass:[NSArray class]]){
        for (int i = 0; i < [object count]; i++) {
            id tmp_item = [object objectAtIndex:i];
            if ([tmp_item valueForKey:@"children"] != nil) {
                for(int j=0;j<[[tmp_item valueForKey:@"children"]count];j++)
                {
                    NSArray *array_secondKeys = [NSArray arrayWithObjects:@"nickname1",@"nickname2",@"content",@"time",@"fid",@"domainid",@"userid1",@"userid2",@"pid",@"cid", nil];
                    NSArray *array_secondContents = [NSArray arrayWithObjects:[[[tmp_item valueForKey:@"children"]objectAtIndex:j]valueForKey:@"nickname"],[tmp_item valueForKey:@"nickname"],[[[tmp_item valueForKey:@"children"]objectAtIndex:j]valueForKey:@"content"],[[[tmp_item valueForKey:@"children"]objectAtIndex:j]valueForKey:@"time"],[[[tmp_item valueForKey:@"children"]objectAtIndex:j]valueForKey:@"fid"],[[[tmp_item valueForKey:@"children"]objectAtIndex:j]valueForKey:@"domainid"],[[[tmp_item valueForKey:@"children"]objectAtIndex:j]valueForKey:@"userid"], [tmp_item valueForKey:@"userid"],[[[tmp_item valueForKey:@"children"]objectAtIndex:j]valueForKey:@"pid"],[[[tmp_item valueForKey:@"children"]objectAtIndex:j]valueForKey:@"cid"],nil];
                    
                    NSDictionary *dic_second = [NSDictionary dictionaryWithObjects:array_secondContents forKeys:array_secondKeys];
                    [self.array_oneOfcomment addObject:dic_second];
                }
                [self process_03:[tmp_item valueForKey:@"children"]];
            }
        }
    }else if ([object isKindOfClass:[NSDictionary class]]){
        
        if ([[object allKeys]containsObject:@"children"]) {
            
            for(int j=0;j<[[object valueForKey:@"children"] count];j++)
            {
                NSArray *array_secondKeys = [NSArray arrayWithObjects:@"nickname1",@"nickname2",@"content",@"time",@"fid",@"domainid",@"userid1",@"userid2",@"pid",@"cid", nil];
                
                
                NSArray *array_secondContents = [NSArray arrayWithObjects:[[[object valueForKey:@"children"]valueForKey:@"nickname"]objectAtIndex:j],[object valueForKey:@"nickname"],[[[object valueForKey:@"children"] valueForKey:@"content"]objectAtIndex:j],[[[object valueForKey:@"children"] valueForKey:@"time"]objectAtIndex:j],[[[object valueForKey:@"children"] valueForKey:@"fid"]objectAtIndex:j],[[[object valueForKey:@"children"] valueForKey:@"domainid"]objectAtIndex:j],[[[object valueForKey:@"children"] valueForKey:@"userid"]objectAtIndex:j],[object valueForKey:@"userid"],[[[object valueForKey:@"children"] valueForKey:@"pid"]objectAtIndex:j],[[[object valueForKey:@"children"] valueForKey:@"cid"]objectAtIndex:j],nil];
                
                NSDictionary *dic_second = [NSDictionary dictionaryWithObjects:array_secondContents forKeys:array_secondKeys];
                [self.array_oneOfcomment addObject:dic_second];
            }
            [self process_03:[object valueForKey:@"children"]];
        }
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_view_01 release];
    [super dealloc];
}
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)chatAction:(id)sender {
    NSString *groupid = [[self.dataSourceArray_picInfo objectAtIndex:(self.currentImagePage_picInfo-1)]valueForKey:@"userid"];
    ChatDetailViewController *detail = [[ChatDetailViewController alloc] initWithNibName:nil bundle:nil];
    ChatConversationListFeed  *feed = [[[ChatConversationListFeed alloc] init] autorelease];
    //这里要传群组的id
    feed.relativeId = [groupid intValue];
    feed.isGroup = 0;
    feed.loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    detail.conFeed = feed;
    [[AppDelegate shareDelegate].rootNavigation pushViewController:detail animated:YES];
    [detail release];
}
- (void) ON_NOTIFICATION:(NSNotification *) wParam
{
    
    if ([[wParam name] compare:UIKeyboardWillShowNotification] == NSOrderedSame) {
        NSDictionary *info = [wParam userInfo];
        CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        UIView *view_001 = (UIView *)[self.view_01 viewWithTag:TEXTFIELDVIEW_TAG];
        
        [view_001 setFrame:CGRectMake(0, self.view_01.frame.size.height - kbSize.height - view_001.frame.size.height, view_001.frame.size.width, view_001.frame.size.height)];
        

    }else if ([[wParam name] compare:UIKeyboardWillHideNotification] == NSOrderedSame) {

        
        UIView *view_001 = (UIView *)[self.view_01 viewWithTag:TEXTFIELDVIEW_TAG];
        [view_001 setFrame:CGRectMake(0, self.view_01.frame.size.height - view_001.frame.size.height,view_001.frame.size.width, view_001.frame.size.height)];
    }
}

@end
