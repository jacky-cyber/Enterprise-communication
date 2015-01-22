//
//  STFormDataRequest.m
//  SunboxSoft_MO_iPad
//
//  Created by 雷 克 on 12-6-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "STFormDataRequest.h"

@implementation STFormDataRequest
@synthesize requestFlagMark;
//@synthesize requestType;

//- (void)buildMultipartFormDataPostBody
//{
//#if DEBUG_FORM_DATA_REQUEST
//	[self addToDebugBody:@"\r\n==== Building a multipart/form-data body ====\r\n"];
//#endif
//	// Set your own boundary string only if really obsessive. We don't bother to check if post data contains the boundary, since it's pretty unlikely that it does.
//	NSString *stringBoundary = @"0xKhTmLbOuNdArY";
//    
//    //modify by raik
//    [self addRequestHeader:@"Content-Type" value:[NSString stringWithFormat:@"multipart/form-data"]];
//    
//    //	NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding([self stringEncoding]));
//    //[self addRequestHeader:@"Content-Type" value:[NSString stringWithFormat:@"multipart/form-data; charset=%@; boundary=%@", charset, stringBoundary]];
//	
//	[self appendPostString:[NSString stringWithFormat:@"--%@\r\n",stringBoundary]];
//	
//	// Adds post data
//	NSString *endItemBoundary = [NSString stringWithFormat:@"\r\n--%@\r\n",stringBoundary];
//	NSUInteger i=0;
//	for (NSDictionary *val in [self postData]) {
//		[self appendPostString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",[val objectForKey:@"key"]]];
//		[self appendPostString:[val objectForKey:@"value"]];
//		i++;
//		if (i != [[self postData] count] || [[self fileData] count] > 0) { //Only add the boundary if this is not the last item in the post body
//			[self appendPostString:endItemBoundary];
//		}
//	}
//	
//	// Adds files to upload
//	i=0;
//	for (NSDictionary *val in [self fileData]) {
//        
//		[self appendPostString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", [val objectForKey:@"key"], [val objectForKey:@"fileName"]]];
//		[self appendPostString:[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", [val objectForKey:@"contentType"]]];
//		
//		id data = [val objectForKey:@"data"];
//		if ([data isKindOfClass:[NSString class]]) {
//			[self appendPostDataFromFile:data];
//		} else {
//			[self appendPostData:data];
//		}
//		i++;
//		// Only add the boundary if this is not the last item in the post body
//		if (i != [[self fileData] count]) { 
//			[self appendPostString:endItemBoundary];
//		}
//	}
//	
//	[self appendPostString:[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary]];
//	
//#if DEBUG_FORM_DATA_REQUEST
//	[self addToDebugBody:@"==== End of multipart/form-data body ====\r\n"];
//#endif
//}
//
//
//- (void)buildURLEncodedPostBody
//{
//    
//	// We can't post binary data using application/x-www-form-urlencoded
//	if ([[self fileData] count] > 0) {
//		[self setPostFormat:ASIMultipartFormDataPostFormat];
//		[self buildMultipartFormDataPostBody];
//		return;
//	}
//	
//#if DEBUG_FORM_DATA_REQUEST
//	[self addToDebugBody:@"\r\n==== Building an application/x-www-form-urlencoded body ====\r\n"]; 
//#endif
//	
//	
//	NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding([self stringEncoding]));
//    
//    //modify by raik
//    [self addRequestHeader:@"Content-Type" value:[NSString stringWithFormat:@"application/x-www-form-urlencoded"]];
//    
//	//[self addRequestHeader:@"Content-Type" value:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@",charset]];
//    
//	NSUInteger i = 0;
//	NSUInteger count = [[self postData] count]-1;
//	for (NSDictionary *val in [self postData]) {
//        NSString *data = [NSString stringWithFormat:@"%@=%@%@", [self encodeURL:[val objectForKey:@"key"]], [self encodeURL:[val objectForKey:@"value"]],(i<count ?  @"&" : @"")]; 
//		[self appendPostString:data];
//		i++;
//	}
//#if DEBUG_FORM_DATA_REQUEST
//	[self addToDebugBody:@"\r\n==== End of application/x-www-form-urlencoded body ====\r\n"]; 
//#endif
//}

- (void)dealloc
{
    [requestFlagMark release];
    
    [super dealloc];
}
@end
