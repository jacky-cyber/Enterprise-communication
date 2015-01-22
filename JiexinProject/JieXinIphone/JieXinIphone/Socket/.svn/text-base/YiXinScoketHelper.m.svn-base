//
//  YiXinScoketHelper.m
//  yixintest
//
//  Created by liqiang on 14-2-18.
//  Copyright (c) 2014年 ishinetech. All rights reserved.
//

#import "YiXinScoketHelper.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>
#import "NSString+MD5.h"
#import "AllDataReplyCenter.h"
#import "SockeMergeHelper.h"
#import "OnLoginConnect.h"
#import "HttpReachabilityHelper.h"
#import "SockeMergeHelper.h"

static long int countTime = 0;

@interface YiXinScoketHelper()

@property (nonatomic, retain) NSDictionary  *loginDic;

@end
@implementation YiXinScoketHelper
{
    NSTimer *_timer;
    PackType packtype;
}

+ (id) sharedService
{
	static YiXinScoketHelper *_sharedInst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInst=[[YiXinScoketHelper alloc] init];
    });
    return _sharedInst;
}

- (void)dealloc
{
    self.receiveData = nil;
    self.getPasswordXml = nil;
    [super dealloc];
}

- (id) init
{
	if (self = [super init])
	{
        //进来是没有连接
        _isConnect = DisConnect;
        self.isAutoLoginConnect = YES;
        packtype = PackType_receiveStart;
        
        [HttpReachabilityHelper  sharedService];
        self.receiveData = [NSMutableData data];
	}
	return self;
}

//设置登录的数据
- (void)setLoginDatas:(NSDictionary *)infoDic
{
    self.isToLogin = YES;
    self.loginDic = infoDic;
}
- (void)getGetPasswordXmlWithStr:(NSString *)getPasswordXml
{
    self.isToLogin = NO;
    self.getPasswordXml = getPasswordXml;
}


#pragma mark - 创建连接和关闭连接
//连接socket
- (void)connect
{
    [self checkTheNetWork];
    //进来是正在连接
    [self connectClose];
    _isConnect = Connecting;
    if (!self.yiXinSocket)
    {
        self.yiXinSocket = [[[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()] autorelease];
    }
    NSString *ip = [[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain];
    int port = kSERVER_PORT;
    //int port1 = 8087;
    NSString* ip1 = @"10.120.145.79";
    NSError *error;
    [_yiXinSocket connectToHost:ip onPort:port withTimeout:10.f error:&error];
}
//断开socket连接
- (void)connectClose
{
    countTime = 0;
    _isConnect = DisConnect;
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    if (self.yiXinSocket) {
        [_yiXinSocket setDelegate:nil delegateQueue:NULL];
        if (_yiXinSocket.isConnected) {
            [_yiXinSocket disconnect];
        }
        self.yiXinSocket = nil;
    }
}


#pragma mark - 定时器
//启用定时器
- (void)startListenTimer
{
    countTime = 0;
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(increseTime) userInfo:nil repeats:YES];
    [_timer retain];
    [_timer fire];
}

- (void)increseTime
{
    //如果正处于连接状态 则发送心跳包
    if (_isConnect == HasConnected) {
        if (countTime == 0) {
            NSString *tcpPack = @" ";//心跳就是空格
            NSData *data = [tcpPack dataUsingEncoding:NSUTF8StringEncoding];
            [_yiXinSocket writeData: data withTimeout: -1 tag: 0];
        }
        countTime += 5;
        //因为服务器是4分钟心跳包频率  所以客户端暂定是230s发送一次心跳包
        if (countTime > 100) {
            countTime = 0;
        }
    }
//    //如果断开连接 则尝试去连接
//    else if (_isConnect == DisConnect)
//    {
//        [self connect];
//    }
}

#pragma mark - 发送数据
- (void)sendDataToServer:(NSString *)string
{
    [self checkTheNetWork];
    //登录
//    NSString *sendXml = [NSString stringWithFormat:@"<JoyIM><cmd>login</cmd><status>1</status><domain>9000</domain><userName>baibo_qt</userName><clientDbVersion>0</clientDbVersion><userPsw>e10adc3949ba59abbe56e057f20f883e</userPsw><type>req</type><loginType>0</loginType></JoyIM>"];
//    NSString *sendXml = [NSString stringWithFormat:@"<JoyIM><cmd>login</cmd><status>1</status><domain>9000</domain><userName>mayina</userName><clientDbVersion>0</clientDbVersion><userPsw>e10adc3949ba59abbe56e057f20f883e</userPsw><type>req</type><loginType>0</loginType></JoyIM>"];

    //获取用户状态
//    NSString *sendXml = [NSString stringWithFormat:@"<JoyIM><sessionID>5811831</sessionID><cmd>pullUserStatusList</cmd><type>req</type></JoyIM>"];
    //获取某个或多个用户的状态
//    NSString *sendXml = [NSString stringWithFormat:@"<JoyIM><sessionID>5811831</sessionID><cmd>getUserStatus</cmd><userlist>5811831</userlist><type>req</type></JoyIM>"];
   //获取某个部门的直属用户状态
//    NSString *sendXml = [NSString stringWithFormat:@"<JoyIM><type>req</type><sessionID>5811831</sessionID><cmd>getDepartUserStatus</cmd><depart>3211</depart></JoyIM>"];
    //用户设置状态
//    NSString *sendXml = [NSString stringWithFormat:@"<JoyIM><type>req</type><sessionID>5811831</sessionID><cmd>pushUserStatus</cmd><loginType>0</loginType><status>1</status></JoyIM>"];
    //接收离线消息
//    NSString *sendXml = [NSString stringWithFormat:@"<JoyIM><type>req</type><sessionID>5811831</sessionID><cmd>fetchOfflineMsg</cmd></JoyIM>"];
    
#warning   //发送消息
    
//    NSString *sendXml = [NSString stringWithFormat:@"<JoyIM><type>req</type><sessionID>5811831</sessionID><SerialID>22342340234<SerialID><cmd>sendMsg</cmd><toID>5343118</toID><RelateID>RelateID</RelateID><msg>hello</msg></JoyIM>"];
    //获取分组
//    NSString *sendXml = [NSString stringWithFormat:@"<JoyIM><type>req</type><sessionID>5343118</sessionID><cmd>group</cmd></JoyIM>"];
    //获取指定组的成员
//    NSString *sendXml = [NSString stringWithFormat:@"<JoyIM><type>req</type><sessionID>5343118</sessionID><cmd>groupMember</cmd><groupID>2349</groupID></JoyIM>"];
    //发群组消息  531274为群中的一个人 999689 也是
//    NSString *sendXml = [NSString stringWithFormat:@"<JoyIM><type>req</type><cmd>groupMsg</cmd><groupID>2349</groupID><sessionID>531274</sessionID><msg>liqiang</msg></JoyIM>"];

#warning //接收群组消息
//    NSString *sendXml = [NSString stringWithFormat:@"<JoyIM><type>rsp</type><cmd>fetchGroupMsgReply</cmd><sessionID>999689</sessionID><SerialID>321</SerialID><from>531274</from><groupid>2349</groupid></JoyIM>"];
  //	公告接口  3,2,14,13,12,11,10,9,8,7,6,5,4,15,
//    NSString *sendXml = [NSString stringWithFormat:@"<JoyIM><type>req</type><sessionID>5343118</sessionID><cmd>getAllSysMsg</cmd><MaxLocalMsgId>getAllSysMsg</MaxLocalMsgId ></JoyIM>"];
    // 公告内容
//    NSString *sendXml = [NSString stringWithFormat:@"<JoyIM><type>req</type><sessionID>5343118</sessionID><cmd>getSysMsgContent</cmd><msgIDs>3,2,14,13,12,11,10,9,8,7,6,5,4,15,</msgIDs></JoyIM>"];
    
    //手机端创建群组
//    NSString *sendXml = [NSString stringWithFormat:@"<JoyIM><type>rsp</type><sessionID>5811831</sessionID><cmd>CreateGroup</cmd><GroupName>duwenjie姐姐姐</GroupName><GroupType>1</GroupType><createId>5811831</createId><MemberId>999689</MemberId></JoyIM>"];
    NSString *sendXml = string;
//    NSData *data = [sendXml dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data=[[[NSData alloc]initWithBytes:[sendXml UTF8String] length:[sendXml lengthOfBytesUsingEncoding:NSUTF8StringEncoding]] autorelease];

//    SHXMLParser	*parser	= [[[SHXMLParser alloc] init] autorelease];
//    NSDictionary *datas = [[parser parseData:data] objectForKey:@"JoyIM"];
//    NSString *cmd = [datas objectForKey:@"cmd"];
//    index = [[_dirListBox objectForKey:cmd] intValue];
    
    [_yiXinSocket writeData: data withTimeout:10.f tag: 0];
}

- (void)checkTheNetWork
{
    if (![[HttpReachabilityHelper sharedService] checkNetwork:nil]) {
        [ShowAlertView showAlertViewStr:@"网络连接已断开"];
        [[STHUDManager sharedManager] removeAllWaittingViews];
        return;
    }
}
#pragma mark - AsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    //	NSLog(@"%s %d", __FUNCTION__, __LINE__);
    //连接成功
    [[NSNotificationCenter defaultCenter] postNotificationName:kConnect object:nil];
    _isConnect = HasConnected;
    [_yiXinSocket readDataWithTimeout:-1 tag: 0];
    [self startListenTimer];
    
    //连接上就登录
    if (_isToLogin) {
        [OnLoginConnect doReLoginConnect:_loginDic];
    }
    else
    {
        self.isToLogin = YES;
        [self sendDataToServer:_getPasswordXml];
    }
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"%s %d, tag = %ld", __FUNCTION__, __LINE__, tag);
    NSLog(@"did write");
}

// 这里必须要使用流式数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"%s %d, tag = %ld", __FUNCTION__, __LINE__, tag);
    
    //首先将计时器计1
    countTime = 1;
    //将收到的数据强制转成数据包结构体

//    NSString *tcpPack1 = [[[NSString alloc] initWithData:data encoding:enc] autorelease];
//    NSString *tcpPack2 = [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease];
//    NSString *tcpPack3 = [[[NSString alloc] initWithData:data encoding:NSUnicodeStringEncoding] autorelease];

    //这里准备用通知返回数据
//    NSLog(@"%@ ",tcpPack);
////    NSLog(@"%@ %@,%@",tcpPack1,tcpPack2,tcpPack3);
//
//    [sock readDataWithTimeout:-1 tag:0];
//
//    packtype = [[SockeMergeHelper sharedService] inputString:tcpPack];
//    
//    if (packtype == PackType_receiveFinished)
//    {
//        NSMutableArray *msgArr = nil;
//        msgArr = [[SockeMergeHelper sharedService] analyzeString];
//        for (NSString *str in msgArr)
//        {
//            [AllDataReplyCenter dealDataWithXmlString:str];
//        }
//    }
    
    //TODO:modify 有时候转化为UTF8字符时返回为nil，有可能是因为返回的nsdata片段刚好中断在一些utf8非法的字符上导致不能转化，所以先把nsdata拼全了再转化字符，就没问题了。可以试试看，呵呵，
    
    [self.receiveData appendData:data];
  
    if([self.receiveData length] >= 8)
    {
        NSString *indicator = [[[NSString alloc] initWithData:[self.receiveData subdataWithRange:NSMakeRange([self.receiveData length]-8, 8)] encoding:NSUTF8StringEncoding] autorelease];
        if([indicator isEqualToString:@"</JoyIM>"])
        {
            //将收到的数据强制转成数据包结构体
            NSString *tcpPack  = [[[NSString alloc] initWithBytes:[self.receiveData bytes] length:[self.receiveData length] encoding:NSUTF8StringEncoding] autorelease];

//            NSString *tcpPack1 = [[NSString alloc] initWithData:self.receiveData encoding:NSUTF8StringEncoding];
            
            NSLog(@"new:===%@",tcpPack);
//            if (!tcpPack) {
//                NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//                tcpPack = [[[NSString alloc] initWithBytes:[self.receiveData bytes] length:[self.receiveData length] encoding:gbkEncoding] autorelease];
//            }
//            if (!tcpPack) {
//                [sock readDataWithTimeout:-1 tag:0];
//                return;
//            }
            if (tcpPack) {
                [[SockeMergeHelper sharedService] setPackString:tcpPack];
                NSMutableArray *msgArr = nil;
                msgArr = [[SockeMergeHelper sharedService] analyzeString];
                for (NSString *str in msgArr)
                {
                    [AllDataReplyCenter dealDataWithXmlString:str];
                }
            }
            self.receiveData = [NSMutableData data];
        }
    }
    [sock readDataWithTimeout:-1 tag:0];
}

/*
 //连接成功，打开监听数据读取，如果不监听那么无法读取数据
 - (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
 //    NSData *strData = [data subdataWithRange:NSMakeRange(0, [data length] - 2)];
 NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
 NSLog(msg);
 //    [sock readDataToData:[AsyncSocket CRLFData] withTimeout:-1 tag:0];
 [sock readDataWithTimeout:-1 tag:0];
 }
 //读取数据了，继续监听读取，注释的第2行可以替代最后一行，但是输出的数据最后也要追加"\r\n"，这个iphone里面不用考虑。

 */

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kDisconnect object:nil];
//    NSLog(@"%s %d", __FUNCTION__, __LINE__);
    [self connectClose];
}
- (void)socketDidCloseReadStream:(GCDAsyncSocket *)sock
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kDisconnect object:nil];
    //    NSLog(@"%s %d", __FUNCTION__, __LINE__);
    [self connectClose];
}

@end
