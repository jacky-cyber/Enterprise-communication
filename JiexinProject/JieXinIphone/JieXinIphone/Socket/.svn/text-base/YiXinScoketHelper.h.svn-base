//
//  YiXinScoketHelper.h
//  yixintest
//
//  Created by liqiang on 14-2-18.
//  Copyright (c) 2014年 ishinetech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

typedef enum
{
    Connecting = 100,//正在连接
    HasConnected,      //联通中
    DisConnect,     //连接失败
}ConnectStatus;

typedef enum
{
    PackType_receiveStart = 0,         //开始获取数据
    PackType_receiving,                //获取包不完整
    PackType_receiveFinished           //获取包完整
}PackType;

@interface YiXinScoketHelper : NSObject
@property (nonatomic, retain)GCDAsyncSocket  *yiXinSocket;
@property (nonatomic, assign) ConnectStatus isConnect;
@property (nonatomic, assign) BOOL isAutoLoginConnect;
@property (nonatomic, retain) NSMutableData *receiveData;
@property (nonatomic, assign) BOOL isToLogin;
@property (nonatomic, retain) NSString *getPasswordXml;

+ (id) sharedService;

//连接服务器
- (void)connect;
//关闭连接
- (void)connectClose;
//发送数据到服务器
- (void)sendDataToServer:(NSString *)string;
//scoket 开始计时
- (void)startListenTimer;
//设置登录的数据
//设置登录的数据
- (void)setLoginDatas:(NSDictionary *)infoDic;

- (void)getGetPasswordXmlWithStr:(NSString *)getPasswordXml;


@end
