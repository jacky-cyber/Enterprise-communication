//
//  DocumentViewController.m
//  DocumentManagerModel
//
//  Created by lxrent01 on 14-3-31.
//  Copyright (c) 2014年 lxrent01. All rights reserved.
//
#define  SCREENRECT [UIScreen mainScreen].bounds

#import "DocumentViewController.h"
#import "DomumentShareController.h"

@interface DocumentViewController ()
@property (nonatomic,strong) UIButton *lastBtn;
@end

@implementation DocumentViewController


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
    
    DomumentShareController *shareController = [[DomumentShareController alloc] initWithNibName:@"DomumentShareController" bundle:nil];
    shareController.viewTag=0;
    shareController.delegate=self;
    
    DomumentShareController *downloadController = [[DomumentShareController alloc] initWithNibName:@"DomumentShareController" bundle:nil];
    downloadController.viewTag=1;
    downloadController.delegate=self;
    
    self.viewControllers=@[shareController,downloadController];
   
    [self initBottomView];
}

-(void)initBottomView{
    self.tabBar.hidden=YES;
    
    UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0,  SCREENRECT.size.height-49, SCREENRECT.size.width, 49)];
    bottomView.tag=1001;
    [self.view addSubview:bottomView];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 00, SCREENRECT.size.width, 1)];
    label.backgroundColor=[UIColor lightGrayColor];
    [bottomView addSubview:label];
    
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake((160-27)/2, (49-27)/2, 27, 27);
    [leftBtn setImage:[UIImage imageNamed:@"documentShare"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchDown];
    leftBtn.tag=10;
    [bottomView addSubview:leftBtn];
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(160+(160-27)/2, (49-27)/2, 27, 27);
    [rightBtn setImage:[UIImage imageNamed:@"myupload"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchDown];
    rightBtn.tag=11;
    [bottomView addSubview:rightBtn];
    
   
}

-(void)hiddenOrShowBottomView:(BOOL)flag{
    
   UIView *bottomView=  [self.view viewWithTag:1001];
    bottomView.hidden=flag;
}


-(void)changeView:(UIButton *)sender{
    int tagNum=sender.tag-10;
    
    NSData *btnImg=UIImagePNGRepresentation(sender.imageView.image);
    
    if(tagNum==0){
        NSData *shareData=UIImagePNGRepresentation([UIImage imageNamed:@"documentShare_pressed"]);
        if(btnImg!=shareData){
            [sender setImage:[UIImage imageWithData:shareData] forState:UIControlStateNormal];
            if(_lastBtn&&_lastBtn!=sender){
                [_lastBtn setImage:[UIImage imageNamed:@"myupload"] forState:UIControlStateNormal];
            }
        }
    }else if(tagNum==1){
        NSData *shareData=UIImagePNGRepresentation([UIImage imageNamed:@"myupload_pressed"]);
        if(btnImg!=shareData){
            [sender setImage:[UIImage imageWithData:shareData] forState:UIControlStateNormal];
            if(_lastBtn&&_lastBtn!=sender){
                [_lastBtn setImage:[UIImage imageNamed:@"documentShare"] forState:UIControlStateNormal];
            }

        }
    }
    _lastBtn=sender;
    if(tagNum==0){
    self.selectedIndex=tagNum;
    }else{
        UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"提示" message:@"该功能正在建设中...." delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
        [alertView show];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
