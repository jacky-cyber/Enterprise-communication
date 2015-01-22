//
//  PDFSelectedViewController.h
//  SunboxSoft_MO_iPad
//
//  Created by 雷 克 on 12-4-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDFSelectedDelegate
- (void)searchStringSelected:(int)index;
@end

@interface PDFSelectedViewController : UITableViewController
{
    NSMutableArray *_searchStrings;				//关联的字段
    id<PDFSelectedDelegate> _delegate;
}

@property (nonatomic, retain) NSMutableArray *searchStrings;
@property (nonatomic, assign) id<PDFSelectedDelegate> delegate;

- (void)reloadWithData:(NSArray *)data;
@end