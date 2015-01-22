//
//  STFormDataRequest.h
//  SunboxSoft_MO_iPad
//
//  Created by 雷 克 on 12-6-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"

/*
typedef enum _NetworkRequestType
{
//	Network_Pie_Kinds = 1,			//饼、酒吧、雷达
//    Network_Bubble_Kinds,           //气泡图
//	Network_Line_Kinds,				//线、堆栈
//    Network_MSColumnDYLine_Kinds,   //双Y轴
//	Network_Column_Kinds,			//条形图
//    Network_Chain_Kinds,            //同比环比图
//	Network_Form_Kinds,				//表格
	//NetWork_Meeting_Kinds,			//会议资料
//	NetWork_ChartIndex_Kinds,		//索引
//	NetWork_Schedule_Kinds,			//日程安排
	//NetWork_3Des_Kinds,			//3des
//	NetWork_FormGroup_Kinds,		//报表分组
	NetWork_Notice_Kinds,			//通知公告
	//NetWork_MainMenu_Kinds,			//菜单数据
	NetWork_DBSYMask_Kinds,			//代办事宜目录数据
	NetWork_DBSYDetail_Kinds,	    //代办事宜具体数据
    NetWork_HTMask_Kinds,			//合同审批目录数据
	NetWork_HTDetail_Kinds,         //合同审批具体数据
	NetWork_Test_Kinds,
    NetWork_Pic_Kinds,               //企业风采
//    NetWork_UserAccount_Kinds,
//    NetWork_StaticChart_Kinds,      //静态报表xml
//    NetWork_ZipDownload_Kinds,      //静态报表，zip下载
//    NetWork_ReportResult_Kinds,     //经营成果数据
//    NetWork_ChartXML_Kinds,         //报表解析
//    NetWork_ChartImage_Kinds,       //chart的image下载保存
//    NetWork_MapData_Kinds,           //地图信息
//    NetWork_WirelessMeeting_Kinds,
//    NetWork_WirelessMeeting_End,
//    NetWork_WirelessMeeting_Test,
    
}NetworkRequestType;*/

@interface STFormDataRequest : ASIFormDataRequest
{
    NSString  *requestFlagMark;
	//NetworkRequestType requestType;
}

@property (copy, nonatomic) NSString *requestFlagMark;
//@property (assign, nonatomic)NSInteger requestType;

- (void)buildMultipartFormDataPostBody;

@end
