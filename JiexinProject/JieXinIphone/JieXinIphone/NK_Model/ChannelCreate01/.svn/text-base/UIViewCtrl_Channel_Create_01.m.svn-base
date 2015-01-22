//
//  UIViewCtrl_Channel_Create_01.m
//  JieXinIphone
//
//  Created by gabriella on 14-4-8.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "UIViewCtrl_Channel_Create_01.h"
#import "FaceKeyBoardDeal.h"
#import "EmojiKeyBoardView.h"
#import "ASIFormDataRequest.h"
#import "NGLABAL_DEFINE.h"
#import "Emoji_Translation.h"
#import "EmotionView.h"


@interface UIViewCtrl_Channel_Create_01 ()<EmojiKeyboardViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate ,UITextViewDelegate,EmotionDelegate>




@property (assign, nonatomic) IBOutlet UITextView *textview_01;
@property (assign, nonatomic) IBOutlet UIButton *button_01;
@property (assign, nonatomic) IBOutlet UIButton *button_02;
@property (assign, nonatomic) IBOutlet UIButton *button_03;
@property (assign, nonatomic) IBOutlet UIView *view_01;
@property (assign, nonatomic) IBOutlet UIView *view_02;
@property (assign, nonatomic) IBOutlet UIScrollView *scrollview_01;
@property (assign, nonatomic) IBOutlet UILabel *label_01;

@property (assign, nonatomic) IBOutlet UIImageView *imageview_file_01;
@property (assign, nonatomic) IBOutlet UIImageView *imageview_file_02;
@property (assign, nonatomic) IBOutlet UIImageView *imageview_file_03;
@property (assign, nonatomic) IBOutlet UIImageView *imageview_file_04;
@property (assign, nonatomic) IBOutlet UIImageView *imageview_file_05;
@property (assign, nonatomic) IBOutlet UIImageView *imageview_file_06;
@property (assign, nonatomic) IBOutlet UIImageView *imageview_file_07;
@property (assign, nonatomic) IBOutlet UIImageView *imageview_file_08;
@property (assign, nonatomic) IBOutlet UIImageView *imageview_file_09;

@property (assign, nonatomic) IBOutlet UIButton *button_file_01;
@property (assign, nonatomic) IBOutlet UIButton *button_file_02;
@property (assign, nonatomic) IBOutlet UIButton *button_file_03;
@property (assign, nonatomic) IBOutlet UIButton *button_file_04;
@property (assign, nonatomic) IBOutlet UIButton *button_file_05;
@property (assign, nonatomic) IBOutlet UIButton *button_file_06;
@property (assign, nonatomic) IBOutlet UIButton *button_file_07;
@property (assign, nonatomic) IBOutlet UIButton *button_file_08;
@property (assign, nonatomic) IBOutlet UIButton *button_file_09;

@property (strong, nonatomic) NSMutableArray *arr_image;
@property (strong, nonatomic) EmojiKeyBoardView *emojiKeyboardView;
@property (strong, nonatomic) ASIFormDataRequest *request_form;
@property (strong, nonatomic) NSString *sValue;
@property (strong, nonatomic) EmotionView *emojiView;


@property (strong,nonatomic) NSMutableArray *inputArr;
@property (nonatomic,strong) NSMutableString *inputStr;

@property (nonatomic) int delnum;
@property (nonatomic) int selectIndex;
@end

@implementation UIViewCtrl_Channel_Create_01

@synthesize textview_01 = _textview_01;
@synthesize button_01 = _button_01;
@synthesize button_02 = _button_02;
@synthesize button_03 = _button_03;
@synthesize view_01 = _view_01;
@synthesize view_02 = _view_02;

@synthesize scrollview_01 = _scrollview_01;
@synthesize label_01 = _label_01;
@synthesize imageview_file_01 = _imageview_file_01;
@synthesize imageview_file_02 = _imageview_file_02;
@synthesize imageview_file_03 = _imageview_file_03;
@synthesize imageview_file_04 = _imageview_file_04;
@synthesize imageview_file_05 = _imageview_file_05;
@synthesize imageview_file_06 = _imageview_file_06;
@synthesize imageview_file_07 = _imageview_file_07;
@synthesize imageview_file_08 = _imageview_file_08;
@synthesize imageview_file_09 = _imageview_file_09;
@synthesize button_file_01 = _button_file_01;
@synthesize button_file_02 = _button_file_02;
@synthesize button_file_03 = _button_file_03;
@synthesize button_file_04 = _button_file_04;
@synthesize button_file_05 = _button_file_05;
@synthesize button_file_06 = _button_file_06;
@synthesize button_file_07 = _button_file_07;
@synthesize button_file_08 = _button_file_08;
@synthesize button_file_09 = _button_file_09;

@synthesize arr_image = _arr_image;
@synthesize emojiKeyboardView = _emojiKeyboardView;
@synthesize request_form = _request_form;
@synthesize sValue = _sValue;

@synthesize inputArr;
@synthesize inputStr;
@synthesize delnum;
@synthesize selectIndex;

@synthesize delegate;

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
    
    inputArr=[[NSMutableArray alloc] initWithCapacity:0];
    inputStr=[[NSMutableString alloc ] initWithString:@""];
    
    
    
    // Do any additional setup after loading the view from its nib.
    CGRect rect = [[UIScreen mainScreen] bounds];
    if (rect.size.height < 568.0f) {
        CGFloat fwidth = self.view.frame.size.width;
        CGFloat fheight = self.view.frame.size.height - (568.0f - rect.size.height);
        [self.view setFrame:CGRectMake(0, 0, fwidth, fheight)];
    }
    
    [self.textview_01.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.textview_01.layer setBorderWidth:1.0f];
    [self.textview_01.layer setCornerRadius:5.0f];
    [self.textview_01 becomeFirstResponder];
    selectIndex=0;
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTextView:)];
//    [self.textview_01 addGestureRecognizer:tap];
    
    
    
    UIImage *image_03 = [UIImage imageNamed:@"uiview_button_01_pressed.png"];
    UIImage *image_04 = [image_03 resizableImageWithCapInsets:UIEdgeInsetsMake(image_03.size.height /2, image_03.size.width / 2, image_03.size.height / 2 , image_03.size.width / 2)];
    [self.button_03 setBackgroundImage:image_04 forState:UIControlStateNormal];
    [self.button_03 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIImage *image_05 = [UIImage imageNamed:@"uiview_button_02_pressed.png"];
    UIImage *image_06 = [image_05 resizableImageWithCapInsets:UIEdgeInsetsMake(image_05.size.height /2, image_05.size.width / 2, image_05.size.height / 2 , image_05.size.width / 2)];
    [self.button_02 setBackgroundImage:image_06 forState:UIControlStateNormal];
    [self.button_02 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.button_01 setBackgroundImage:image_06 forState:UIControlStateNormal];
    [self.button_01 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.view_01 setHidden:YES];
    
    [self.imageview_file_01 setHidden:YES];
    [self.imageview_file_02 setHidden:YES];
    [self.imageview_file_03 setHidden:YES];
    [self.imageview_file_04 setHidden:YES];
    [self.imageview_file_05 setHidden:YES];
    [self.imageview_file_06 setHidden:YES];
    [self.imageview_file_07 setHidden:YES];
    [self.imageview_file_08 setHidden:YES];
    [self.imageview_file_09 setHidden:YES];
    
    [self.button_file_01 setHidden:YES];
    [self.button_file_02 setHidden:YES];
    [self.button_file_03 setHidden:YES];
    [self.button_file_04 setHidden:YES];
    [self.button_file_05 setHidden:YES];
    [self.button_file_06 setHidden:YES];
    [self.button_file_07 setHidden:YES];
    [self.button_file_08 setHidden:YES];
    [self.button_file_09 setHidden:YES];
    
    self.arr_image = [NSMutableArray array];
    self.sValue = @"";
    float iosFolat = 0;
    if (IOSVersion>=7.0) {
        iosFolat = 20;
    }
    EmotionView *aEmotion = [[EmotionView alloc] initWithFrame:CGRectMake(0, kScreen_Height - 216-(20-iosFolat), self.view.frame.size.width, 216)];
    aEmotion.hidden = YES;
    aEmotion.delegate = self;
    self.emojiView = aEmotion;
    [self.view addSubview:_emojiView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ON_NOTIFICATION:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ON_NOTIFICATION:) name:UIKeyboardWillHideNotification object:nil];
    [self.scrollview_01 setContentSize:CGSizeMake(320, rect.size.height - 64.0f)];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.emojiKeyboardView = nil;
    self.arr_image = nil;
    self.request_form.delegate = nil;
    self.request_form = nil;
    self.sValue = nil;
    [super dealloc];
}

#pragma label -
#pragma label UIImagePickerControllerDelegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *lage_image = [editingInfo objectForKey:UIImagePickerControllerOriginalImage];
    
    CGFloat max_size = ([lage_image size].width >= [lage_image size].height) ? [lage_image size].width : [lage_image size].height;
    if (max_size > 600) {
        NSInteger scale_size = [[NSNumber numberWithFloat: max_size / 600] integerValue];
        
        UIGraphicsBeginImageContext(CGSizeMake([lage_image size].width / scale_size, [lage_image size].height / scale_size));
        [lage_image drawInRect:CGRectMake(0, 0, [lage_image size].width / scale_size, [lage_image size].height / scale_size)];
        lage_image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIImage *small_image = image;
    UIGraphicsBeginImageContext(CGSizeMake([small_image size].width / 10, [small_image size].height / 10));
    [small_image drawInRect:CGRectMake(0, 0, [small_image size].width / 10, [small_image size].height / 10)];
    small_image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.arr_image addObject:lage_image];
    
    if ([self.arr_image count] == 1) {
        [self.imageview_file_01 setImage:lage_image];
    }else if ([self.arr_image count] == 2) {
        [self.imageview_file_02 setImage:lage_image];
    }else if ([self.arr_image count] == 3) {
        [self.imageview_file_03 setImage:lage_image];
    }else if ([self.arr_image count] == 4) {
        [self.imageview_file_04 setImage:lage_image];
    }else if ([self.arr_image count] == 5) {
        [self.imageview_file_05 setImage:lage_image];
    }else if ([self.arr_image count] == 6) {
        [self.imageview_file_06 setImage:lage_image];
    }else if ([self.arr_image count] == 7) {
        [self.imageview_file_07 setImage:lage_image];
    }else if ([self.arr_image count] == 8) {
        [self.imageview_file_08 setImage:lage_image];
    }else if ([self.arr_image count] == 9) {
        [self.imageview_file_09 setImage:lage_image];
    }
    
    if ([self.arr_image count] > 0) {
        [self.imageview_file_01 setHidden:NO];
        [self.button_file_01 setHidden:NO];
    }
    
    if ([self.arr_image count] > 1) {
        [self.imageview_file_02 setHidden:NO];
        [self.button_file_02 setHidden:NO];
    }
    
    if ([self.arr_image count] > 2) {
        [self.imageview_file_03 setHidden:NO];
        [self.button_file_03 setHidden:NO];
    }
    
    if ([self.arr_image count] > 3) {
        [self.imageview_file_04 setHidden:NO];
        [self.button_file_04 setHidden:NO];
    }
    
    if ([self.arr_image count] > 4) {
        [self.imageview_file_05 setHidden:NO];
        [self.button_file_05 setHidden:NO];
    }
    
    if ([self.arr_image count] > 5) {
        [self.imageview_file_06 setHidden:NO];
        [self.button_file_06 setHidden:NO];
    }
    
    if ([self.arr_image count] > 6) {
        [self.imageview_file_07 setHidden:NO];
        [self.button_file_07 setHidden:NO];
    }
    
    if ([self.arr_image count] > 7) {
        [self.imageview_file_08 setHidden:NO];
        [self.button_file_08 setHidden:NO];
    }
    
    if ([self.arr_image count] > 8) {
        [self.imageview_file_09 setHidden:NO];
        [self.button_file_09 setHidden:NO];
    }
    
    if ([self.arr_image count] > 6) {
        [self.scrollview_01 setContentSize:CGSizeMake(320.0f, 560.0f)];
    }else if ([self.arr_image count] > 3) {
        [self.scrollview_01 setContentSize:CGSizeMake(320.0f, 470.0f)];
    }else{
        CGRect rect = [[UIScreen mainScreen] bounds];
        [self.scrollview_01 setContentSize:CGSizeMake(rect.size.width, rect.size.height - 64)];
    }
    
    [self.textview_01 setFrame:CGRectMake(self.textview_01.frame.origin.x,
                                          self.textview_01.frame.origin.y,
                                          self.textview_01.frame.size.width,
                                          246)];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //[self.imageview_01 setImage:small_image];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma label -
#pragma label UITextViewDelegate Methods

-(void)clickTextView:(UIGestureRecognizer *)tap{

    [self.view endEditing:YES];
    self.textview_01.inputView = nil;
    [self.textview_01 becomeFirstResponder];

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *str=[NSString stringWithFormat:@"%@%@",textView.text,text];
 
    if(str.length>141){
        NSString *subStr=[str substringToIndex:140];
        textView.text= subStr;
        return NO;
    }
    
    if([text isEqualToString:@""]){
        if ( range.length > 1 || range.location != textView.text.length-1) {
            return YES;
        }else {
            [FaceKeyBoardDeal faceBackDeal:textView];
            [self textViewDidChange:textView];
            return NO;
        }
    }else if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
    }
    return YES;
}

-(void)textViewDidChangeSelection:(UITextView *)textView{
//    NSLog(@"%d:::%d",textView.selectedRange.length,textView.selectedRange.location);
    selectIndex=textView.selectedRange.location;
}

-(void)textViewDidChange:(UITextView *)textView{
  selectIndex=textView.selectedRange.location;
    NSString *str=textView.text;
    if (textView.markedTextRange == nil && textView.text.length > 140) {
        str=[str substringToIndex:140];
        // str = [str rangeOfComposedCharacterSequenceAtIndex:140];
        textView.text= str;
        selectIndex=140;
        // Perform change
    }
       [self.label_01 setText:[NSString stringWithFormat:@"%d / 140",str.length]];
}


#pragma label -
#pragma label Custom Methods

- (IBAction)onBtnReturn_Click:(id)sender
{
    [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
}

- (IBAction)onBtnFun01_Click:(id)sender
{
   
}

- (IBAction)onBtnFun02_Click:(id)sender
{
    self.emojiView.hidden = NO;

    [self.view endEditing:YES];
    
    [self.textview_01 setFrame:CGRectMake(self.textview_01.frame.origin.x,
                                      self.textview_01.frame.origin.y,
                                      self.textview_01.frame.size.width,
                                          self.view.frame.size.height - CGRectGetHeight(self.emojiView.frame)-10-100)];
    
    //    self.textview_01.inputView = self.emojiKeyboardView;
    //    [self.textview_01 becomeFirstResponder];
    
}

- (void)selectEmotionFinish:(NSDictionary *)infoDic
{
    NSLog(@"%@",infoDic);
    
       NSString *faceStr=[infoDic objectForKey:@"image"];
        NSString *textStr=self.textview_01.text;
        NSString *str1=[textStr substringToIndex:selectIndex];
        NSString *str2=[textStr substringFromIndex:selectIndex];
        NSString *str3=[NSString stringWithFormat:@"%@%@",str1,faceStr];
        NSString *str4=[NSString stringWithFormat:@"%@%@",str3,str2];
        NSLog(@"%@",str4);
    
    selectIndex+=faceStr.length;
    self.textview_01.selectedRange=NSMakeRange(selectIndex, 0);
    self.textview_01.text=str4;
    
    [self textViewDidChange:self.textview_01];
}

-(NSString *)getImageRange:(NSString*)message
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionPlist" ofType:@"plist"];
    NSDictionary *imageNameDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSArray *keyArr = [imageNameDic allKeys];
    
    for(NSString *key in keyArr)
    {
        NSString *value = [imageNameDic objectForKey:key];
        BOOL isExist = YES;
        while(isExist)
        {
            NSRange range =  [message rangeOfString:value];
            if (range.length) {
                NSString *nameStr = [[[NSString alloc] initWithFormat:@"<&%@&>",key] autorelease];
                
                return nameStr;
                
            }
            else
            {
                isExist = NO;
            }
        }
    }
    return nil;
}

- (IBAction)onBtnFun03_Click:(id)sender
{
    
    self.emojiView.hidden=YES;
    [self.textview_01 resignFirstResponder];
    
    [self.textview_01 setFrame:CGRectMake(self.textview_01.frame.origin.x,
                                          self.textview_01.frame.origin.y,
                                          self.textview_01.frame.size.width,
                                          246)];
    
    if ([self.arr_image count] >= 9) {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"您不能添加更多图了！" delegate:nil cancelButtonTitle:@"知道了！" otherButtonTitles: nil] autorelease];
        [alert show];
        return;
    }
    
    [self.view_01 setHidden:NO];
}

- (IBAction)onBtnFun04_Click:(id)sender
{
    [self.view_01 setHidden:YES];
    if ([self.arr_image count] >= 9) {
        return;
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
    [picker release];
}

- (IBAction)onBtnFun05_Click:(id)sender
{
    [self.view_01 setHidden:YES];
    if ([self.arr_image count] >= 9) {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"您不能添加更多图了！" delegate:nil cancelButtonTitle:@"知道了！" otherButtonTitles: nil] autorelease];
        [alert show];
        return;
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
    [picker release];
}

- (IBAction)onBtnFun06_Click:(id)sender
{
    
    [self.view_01 setHidden:YES];
    
}

- (IBAction)onBtnFun07_Click:(id)sender
{
    if (self.textview_01.text.length == 0&&[self.arr_image count] == 0) {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"您不能发布空内容到员工园地！" delegate:nil cancelButtonTitle:@"知道了！" otherButtonTitles: nil] autorelease];
        [alert show];
        return;
    }else if ([[self.textview_01 text] length] > 140) {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"您发布的空内容长度不能超过140个字符！" delegate:nil cancelButtonTitle:@"知道了！" otherButtonTitles: nil] autorelease];
        [alert show];
        return;
    }
    [[STHUDManager sharedManager] showHUDInView:self.view];
    NSThread *tmp_thread = [[[NSThread alloc] initWithTarget:self selector:@selector(THREAD_PROC_01:) object:nil] autorelease];
    [tmp_thread start];
}

- (IBAction)Close_KeyBroad:(id)sender
{
//    [self.view endEditing:YES];
}

- (void) ON_NOTIFICATION:(NSNotification *) wParam
{
    if ([[wParam name] compare:UIKeyboardWillShowNotification] == NSOrderedSame) {
        self.emojiView.hidden = YES;
        NSDictionary *info = [wParam userInfo];
        CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        [self.textview_01 setFrame:CGRectMake(self.textview_01.frame.origin.x,
                                          self.textview_01.frame.origin.y,
                                          self.textview_01.frame.size.width,
                                           kScreen_Height - kbSize.height-100-10)];
        
    }else if ([[wParam name] compare:UIKeyboardWillHideNotification] == NSOrderedSame) {
        if([self.arr_image count]==0){
            
            [self.textview_01 setFrame:CGRectMake(self.textview_01.frame.origin.x,
                                                  self.textview_01.frame.origin.y,
                                                  self.textview_01.frame.size.width,
                                                  self.view.frame.size.height - self.textview_01.frame.origin.y-100-10)];
        }else{
        
            [self.textview_01 setFrame:CGRectMake(self.textview_01.frame.origin.x,
                                                  self.textview_01.frame.origin.y,
                                                  self.textview_01.frame.size.width,
                                                  self.view.frame.size.height - self.textview_01.frame.origin.y-10-50-40-50-20-20)];
        }
       
    }
}

- (void) THREAD_PROC_01:(id)wParam
{
    NSDateFormatter *dt_format = [[[NSDateFormatter alloc] init] autorelease];
    [dt_format setDateFormat:@"MMddHHmmss"];
    
    NSString *headStr1;
    
    NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    if([headStr compare:@"111.11.28.29"] == NSOrderedSame) { //正式全通
        headStr1 = @"http://111.11.28.9:8088/staffCorner/phoneInterface.action";
    }else if ([headStr compare:@"111.11.28.41"] == NSOrderedSame){ //正式政企
        headStr1 = @"http://111.11.28.9:8088/staffCornerzq/phoneInterface.action";
    } else {
        headStr1 = @"http://111.11.28.30:8091/staffCorner/phoneInterface.action";
    }
    
    
    NSString *sDestContent=[FaceKeyBoardDeal faceSendStr:self.textview_01.text];
    
    NSString *str_userid = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]];
    NSString *str_nickname = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:User_NickName]];
    
    NSMutableData *mt_data = [NSMutableData data];
    [mt_data appendData:[@"-----------------------------7de2821190dec\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"Content-Disposition: form-data; name=\"cmd\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[[NSString stringWithFormat:@"%@\r\n", @"publishStatus"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [mt_data appendData:[@"-----------------------------7de2821190dec\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"Content-Disposition: form-data; name=\"userId\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[[NSString stringWithFormat:@"%@\r\n", str_userid] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [mt_data appendData:[@"-----------------------------7de2821190dec\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"Content-Disposition: form-data; name=\"userName\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[[NSString stringWithFormat:@"%@\r\n", str_nickname] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [mt_data appendData:[@"-----------------------------7de2821190dec\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"Content-Disposition: form-data; name=\"location\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [mt_data appendData:[@"-----------------------------7de2821190dec\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"Content-Disposition: form-data; name=\"content\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [mt_data appendData:[[NSString stringWithFormat:@"%@\r\n", sDestContent] dataUsingEncoding:NSUTF8StringEncoding]];
    
    for (NSInteger i = 0; i < [self.arr_image count]; i ++) {
        NSString *file_name = [NSString stringWithFormat:@"%@%02d", [dt_format stringFromDate:[NSDate date]], i];
        [mt_data appendData:[@"-----------------------------7de2821190dec\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [mt_data appendData:[@"Content-Disposition: form-data; name=\"pic\"; filename=\"" dataUsingEncoding:NSUTF8StringEncoding]];
        [mt_data appendData:[file_name dataUsingEncoding:NSUTF8StringEncoding]];
        [mt_data appendData:[@".jpg" dataUsingEncoding:NSUTF8StringEncoding]];
        [mt_data appendData:[@"\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        //
        [mt_data appendData:[@"Content-Type: image/jpeg\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [mt_data appendData:UIImageJPEGRepresentation([self.arr_image objectAtIndex:i], 1.0f)];
        
        [mt_data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    [mt_data appendData:[@"-----------------------------7de2821190dec--\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (self.request_form != nil) {
        self.request_form.delegate = nil;
    }
    
    
    
    self.request_form = [[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:headStr1]] autorelease];
    
    [self.request_form setTimeOutSeconds:60.0];
    self.request_form.delegate = self;
    [self.request_form addRequestHeader:@"Accept" value:@"text/html"];
    [self.request_form addRequestHeader:@"Content-Type" value:@"multipart/form-data; boundary=---------------------------7de2821190dec"];
    [self.request_form addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%@", [NSNumber numberWithInteger:mt_data.length]]];
    [self.request_form setRequestMethod:@"POST"];
    [self.request_form setPostBody:mt_data];
    [self.request_form startAsynchronous];
    [self.request_form setDidFailSelector:@selector(requestBeFailed:)];
    [self.request_form setDidFinishSelector:@selector(requestBeFinished:)];
    
}



-(void)requestBeFailed:(ASIFormDataRequest *)sender
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"内容发表失败！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] autorelease];
    [alert show];
    
}
-(void)requestBeFinished:(ASIFormDataRequest *)request
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@", dic);
    if([[dic valueForKey:@"resultcode"] intValue]==0) {
        [[STHUDManager sharedManager] hideHUDInView:self.view];
        
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"内容发表成功！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] autorelease];
        [alert show];
        [[NSNotificationCenter defaultCenter] postNotificationName:PARAMTER_KEY_NOTIFY_REFRESH_DATA object:nil];
        [[AppDelegate shareDelegate].rootNavigation popViewControllerAnimated:YES];
    } else {
        [[STHUDManager sharedManager] hideHUDInView:self.view];
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"内容发表失败！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] autorelease];
        [alert show];
    }
}

@end
