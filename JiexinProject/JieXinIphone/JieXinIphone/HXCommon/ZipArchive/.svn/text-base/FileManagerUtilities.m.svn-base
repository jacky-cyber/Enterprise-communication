//
//  FileManagerUtilities.m
//  ZLibDemo
//
//  Created by 雷克 on 11-12-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FileManagerUtilities.h"

@implementation FileManagerUtilities

+ (NSString *)getFileMainPath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

+ (NSString *)dataFilePath:(NSString *)fileName
{
	NSString *filesDirectory = [FileManagerUtilities getFileMainPath];
	NSString *path = [filesDirectory stringByAppendingPathComponent:fileName];
	NSLog(@"path:%@",path);
	
    return path;
}

//根据文件名取目录下的自目录名称
+ (NSArray *)allFilesInFolder:(NSString *)folderName
{
	return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[self getFileMainPath] stringByAppendingPathComponent:folderName] error:nil];
}
//根据路径名取目录下的自目录名称
+ (NSArray *)allContentsInPath:(NSString *)directoryPath
{
	return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:nil];
}

//取路径下的所有文件名
+ (NSArray *)allFilesInPathAndItsSubpaths:(NSString *)directoryPath
{
	NSMutableArray *allContentsPathArray = [[[NSFileManager defaultManager] subpathsAtPath:directoryPath] mutableCopy];
	BOOL isDir = NO;
	for (int i = [allContentsPathArray count] - 1;i >= 0; i--) 
	{
		NSString *path = [allContentsPathArray objectAtIndex:i];
		if (![[NSFileManager defaultManager] fileExistsAtPath:[directoryPath stringByAppendingPathComponent:path] isDirectory:&isDir] || isDir)
		{
			[allContentsPathArray removeObject:path];
			//isDir = NO;
		}
	}
	return allContentsPathArray;
}

//根据目录删除文件
+ (void)deleteFileWithPath:(NSString *)filePath
{	
	if (![filePath length])
	{
		return;
	}
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if ([fileManager fileExistsAtPath:filePath]) 
	{
		[fileManager removeItemAtPath:filePath error:nil];
	}
}

@end
