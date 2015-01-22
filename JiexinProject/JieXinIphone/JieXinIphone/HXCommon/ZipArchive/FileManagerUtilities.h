//
//  FileManagerUtilities.h
//  ZLibDemo
//
//  Created by 雷克 on 11-12-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FileManagerUtilities : NSObject 
{
	
}
+ (NSString *)getFileMainPath;
+ (NSString *)dataFilePath:(NSString *)fileName;
+ (NSArray *)allFilesInFolder:(NSString *)folderName;
+ (NSArray *)allContentsInPath:(NSString *)directoryPath;
+ (NSArray *)allFilesInPathAndItsSubpaths:(NSString *)directoryPath;
+ (void)deleteFileWithPath:(NSString *)filePath;

@end
