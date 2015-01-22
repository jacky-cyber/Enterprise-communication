//
//  NSDictionary+HttpXMLParser.m
//  JieXinIphone
//
//  Created by 高大鹏 on 14-3-12.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "GDataXMLNode.h"
#import "NSDictionary+HttpXMLParser.h"

@interface NSDictionary(HttpPrivateXMLParser)

+ (NSDictionary *)dictionaryWithAPPVersionXMLElement:(GDataXMLElement *)rootElement;
+ (NSDictionary *)dictionaryWithCarLoginXMLElement:(GDataXMLElement *)rootElement;

@end

@implementation NSDictionary (HttpXMLParser)

+ (NSDictionary *)httpDictionaryFromXML:(NSString *)xmlString withType:(HttpRequestType)type
{
    //NSLog(@"xmlString  %@",xmlString);
	NSError          *error         = nil;
	GDataXMLDocument *document      = [[[GDataXMLDocument alloc] initWithXMLString:xmlString options:0 error:&error] autorelease];
    //NSLog(@"document   %@",document);
	NSDictionary     *newDictionary = nil;
	switch (type)
	{
		case Http_FretchAppVersion:
		{
			newDictionary = [NSDictionary dictionaryWithAPPVersionXMLElement:[document rootElement]];
		}break;
        case kCarManager_Login:
		{
			newDictionary = [NSDictionary dictionaryWithCarLoginXMLElement:[document rootElement]];
		}break;
    
		default:
			break;
	}
	return newDictionary;
}


@end


@implementation NSDictionary(HttpPrivateXMLParser)

+ (NSDictionary *)dictionaryWithAPPVersionXMLElement:(GDataXMLElement *)rootElement
{
    NSLog(@"rootElement  %@",rootElement);
    NSString *version = [[[rootElement elementsForName:@"product_publish_version"] objectAtIndex:0] stringValue];
    
    NSString *info = [[[rootElement elementsForName:@"product_lastVersionInfo"] objectAtIndex:0] stringValue];
    
    NSString *downloadUrl = [[[rootElement elementsForName:@"product_publish_apk"] objectAtIndex:0] stringValue];
    
    NSString *mustUpdate = [[[rootElement elementsForName:@"product_mustupdate"] objectAtIndex:0] stringValue];
    
    NSMutableDictionary *parsDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:version,@"Version",info,@"Info",downloadUrl,@"URL",mustUpdate,@"MustUpdate",nil];
    
    return parsDic;
}

@end
