//
//  ImagesCharacterArrange.h
//  talktalktalk
//
//  Created by zuoxiaolin on 11-8-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImagesCharacterArrange : UIView {
	NSMutableArray   *contentStrArr;      //存放所有的内容
	NSString         *m_Name;             //用于绘制聊天人名称
    CGFloat          m_DrawWidth;         //绘字符的Rect的width	
	NSInteger        m_FontStyle;         //用来判断文字显示状态，1表示主页面的视图的小自体，2表示主页放大镜和聊天界面的自体大小3表示主页最后聊天记录
	NSInteger        m_EmoWidth;          //表情图片的大小，不同视图采用不同大小的表情
	NSInteger        m_RowHeigh;          //行高，不同视同采用不同的行高
	NSInteger        m_FontSize;          //字体大小，不同视图蔡采用不同大小
	UIFont           *m_Font;             //字体格式
	NSInteger        m_EmoHeightOffset;   //用于主页面小字体，调整表情的Y坐标位置
	
}
@property(nonatomic,retain)NSMutableArray *contentStrArr;
@property(nonatomic,assign)CGFloat m_DrawWidth;
@property(nonatomic,retain)NSString *m_Name;
@property(nonatomic,assign)NSInteger m_FontStyle;
@property(nonatomic,assign)NSInteger m_EmoWidth;
@property(nonatomic,assign)NSInteger m_RowHeigh;
@property(nonatomic,assign)NSInteger m_FontSize;
@property(nonatomic,retain)UIFont *m_Font;
@property(nonatomic,assign)NSInteger m_EmoHeightOffset;
/********************************************************************
 函数名称  : replaceEmo
 函数描述  : 处理原始字符串，用特殊字符替换表情转义字符，得到表情数组，处理后的字符串
 输入参数  : contentString
 输出参数  : N/A
 返回值    : NSMutableArray
 备注     : N/A
 *********************************************************************/
-(NSMutableArray *)replaceEmo:(NSString *)contentString;
/********************************************************************
 函数名称  : findWidthArr
 函数描述  : 获取每一行表情的坐标，存入坐标数组
 输入参数  : textIneveryLine
 输出参数  : N/A
 返回值    : NSMutableArray
 备注      : N/A
 *********************************************************************/
-(NSMutableArray *)findWidthArr:(NSString *)textIneveryLine;
/********************************************************************
 函数名称  : imagesCharactersArrange
 函数描述  : 对传入的字符串进行处理，图文混排，得到混排好的视图
 输入参数  : meg  maxWidth  name  sendfontStyle
 输出参数  : N/A
 返回值    : UIView
 备注      : N/A
 *********************************************************************/
-(UIView *)imagesCharactersArrange:(NSString *)meg maxWidth:(CGFloat)maxWidth peopleName:(NSString *)name fontStyle:(NSInteger)sendfontStyle;
/********************************************************************
 函数名称  : isEnglish
 函数描述  : 判断是否为英文  及有特殊用途的转义 字符串
 输入参数  : str
 输出参数  : N/A
 返回值    :BOOL
 备注     : N/A
 *********************************************************************/
-(BOOL)isEnglish:(NSString *)str;
@end
