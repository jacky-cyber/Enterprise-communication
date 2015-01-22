//
//  Integrated+Extensions.m
//  LastHistory
//
//  Created by Frederik Seiffert on 28.11.08.
//  Copyright 2008 Frederik Seiffert. All rights reserved.
//

#import "Integrated+Extensions.h"
#import "GTMBase64.h"
#import <vis.h>

@implementation NSString (Extensions)
- (NSString *)trim {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString *)getDate
{
    NSDateFormatter *format = [[[NSDateFormatter alloc] init] autorelease];
    [format setDateFormat:@"yyyyMMddHHmmss"];
    NSString *atheDateString = [format stringFromDate:[NSDate date]];
    return atheDateString;
}

+ (NSString *)createUUID
{
    // Create universally unique identifier (object)
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    // Get the string representation of CFUUID object.
    NSString *uuidStr = (NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidObject);
    
    // If needed, here is how to get a representation in bytes, returned as a structure
    // typedef struct {
    //   UInt8 byte0;
    //   UInt8 byte1;
    //   …
    //   UInt8 byte15;
    // } CFUUIDBytes;
    //CFUUIDBytes bytes = CFUUIDGetUUIDBytes(uuidObject);
    CFRelease(uuidObject);
    
    return uuidStr;
}

+ (NSString *)decodeUTF8ToChinese:(NSString *)encodeStr;
{
	return [encodeStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)encodeChineseToUTF8:(NSString *)encodeStr;
{
	return [[NSString stringWithFormat:@"%@",encodeStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)encodeURL:(NSString *)string endcode:(NSStringEncoding)stringEncoding
{
	NSString *newString = NSMakeCollectable([(NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(stringEncoding)) autorelease]);
	if (newString) {
		return newString;
	}
    
	return @"";
}

+ (NSString *)encodeURL:(NSString *)string
{
	NSString *newString = NSMakeCollectable([(NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)) autorelease]);
	if (newString) {
		return newString;
	}
    
	return @"";
}

+ (NSString*)encodeURL:(NSString *)originalString stringEncoding:(NSStringEncoding)stringEncoding 
{
    //!  @  $  &  (  )  =  +  ~  `  ;  '  :  ,  /  ?
    //%21%40%24%26%28%29%3D%2B%7E%60%3B%27%3A%2C%2F%3F
    NSArray *escapeChars = [NSArray arrayWithObjects:@";" , @"/" , @"?" , @":" ,
                            @"@" , @"&" , @"=" , @"+" ,    @"$" , @"," ,
                            @"!", @"'", @"(", @")", @"*", nil];
    
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B" , @"%2F", @"%3F" , @"%3A" ,
                             @"%40" , @"%26" , @"%3D" , @"%2B" , @"%24" , @"%2C" ,
                             @"%21", @"%27", @"%28", @"%29", @"%2A", nil];
    
    int len = [escapeChars count];
    
    NSMutableString *temp = [[originalString
                              stringByAddingPercentEscapesUsingEncoding:stringEncoding]
                             mutableCopy];
    
    int i;
    for (i = 0; i < len; i++) {
        
        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
    
    NSString *outStr = [NSString stringWithString: temp];
    
    return outStr;
}

+ (NSString *)unEscapedString:(NSString *)oldString
{
    NSString *escapedString_lt = [oldString stringByReplacingOccurrencesOfString:@"<" withString:@"&lt"];
    NSString *escapedString = [escapedString_lt stringByReplacingOccurrencesOfString:@">" withString:@"&gt"];
    return escapedString;
}


+ (NSString*)encodeXML:(NSString *)originalString
{
//    
//    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
//    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
//    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
//    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
    //不包换双引号：@"&quot;" @"\""
    
    NSArray *escapeChars = [NSArray arrayWithObjects:@"'" , @"&" , @"<" ,
                            @">", nil];
    NSArray *replaceChars = [NSArray arrayWithObjects:@"&apos;", @"&amp;" , @"&lt;" ,
                             @"&gt;", nil];
    
    int count = [escapeChars count];
    NSMutableString *temp = [originalString  mutableCopy];
    for(int i = 0; i < count; i++) 
    {
        
        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
    
    NSString *outStr = [NSString stringWithString:temp];
    
    return outStr;
}



+ (NSString*)decodeXML:(NSString *)originalString
{
    NSArray *escapeChars = [NSArray arrayWithObjects:@"&quot;" , @"&apos;", @"&lt;" ,
                            @"&gt;",@"&#xD;",@"&amp;" ,  nil];
    NSArray *replaceChars = [NSArray arrayWithObjects:@"\"" , @"'" , @"<" ,
                             @">", @"\r",@"&" , nil];
    int count = [escapeChars count];
    NSMutableString *temp = [originalString  mutableCopy];
    for(int i = 0; i < count; i++) 
    {
        
        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
    
    NSString *outStr = [NSString stringWithString:temp];
    
    return outStr;
}

//.m
- (NSString*)stringByURLEncodingStringParameter
{
    // NSURL's stringByAddingPercentEscapesUsingEncoding: does not escape
    // some characters that should be escaped in URL parameters, like / and ?; 
    // we'll use CFURL to force the encoding of those
    //
    // We'll explicitly leave spaces unescaped now, and replace them with +'s
    //
    // Reference: <a href="\"http://www.ietf.org/rfc/rfc3986.txt\"" target="\"_blank\"" onclick="\"return" checkurl(this)\"="" id="\"url_2\"">http://www.ietf.org/rfc/rfc3986.txt</a>
    
    NSString *resultStr = self;
    
    CFStringRef originalString = (CFStringRef) self;
    CFStringRef leaveUnescaped = CFSTR(" ");
    CFStringRef forceEscaped = CFSTR("!*'();:@&=+$,/?%#[]");
    
    CFStringRef escapedStr;
    escapedStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                         originalString,
                                                         leaveUnescaped, 
                                                         forceEscaped,
                                                         kCFStringEncodingUTF8);
    
    if(escapedStr)
    {
        NSMutableString *mutableStr = [NSMutableString stringWithString:(NSString *)escapedStr];
        CFRelease(escapedStr);
        
        // replace spaces with plusses
        [mutableStr replaceOccurrencesOfString:@" "
                                    withString:@"%20"
                                       options:0
                                         range:NSMakeRange(0, [mutableStr length])];
        resultStr = mutableStr;
    }
    return resultStr;
}


- (NSString *)md5
{
	const char *cStr = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	
	CC_MD5(cStr, strlen(cStr), result);
	
	NSMutableString *resultStr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
	for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		[resultStr appendFormat:@"%02x", result[i]];
	}
	return [[resultStr copy] autorelease];
}

+ (NSData *)desData:(NSData *)data key:(NSString *)keyString CCOperation:(CCOperation)op
{
	// Byte *buffer;
	char buffer [1024] ;
	memset(buffer, 0, sizeof(buffer));
	// memset(buffer, 0, 1024);
	size_t bufferNumBytes;
	CCCryptorStatus cryptStatus = CCCrypt(op, 
										  
										  kCCAlgorithmDES, 
										  
										  kCCOptionPKCS7Padding | kCCOptionECBMode,
										  
										  [keyString UTF8String], 
										  
										  kCCKeySizeDES,
										  
										  NULL, 
										  
										  [data bytes], 
										  
										  [data length],
										  
										  buffer, 
										  
										  1024,
										  
										  &bufferNumBytes);
	if(cryptStatus == kCCSuccess)
	{
		NSData *returnData = [NSData dataWithBytes:buffer length:bufferNumBytes];
		return returnData;
		// NSString *returnString = [[[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding]autorelease];
	}
	NSLog(@"des failed！");
	return nil;
	
}


+ (NSString *)tripleDES:(NSString*)dataString encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key 
{
    const void *vdataString;
    size_t dataStringBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        NSData *EncryptData = [GTMBase64 decodeData:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
        dataStringBufferSize = [EncryptData length];
        vdataString = [EncryptData bytes];
    }
    else
    {
        NSData* data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
        dataStringBufferSize = [data length];
        vdataString = (const void *)[data bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    // uint8_t ivkCCBlockSize3DES;
    
    bufferPtrSize = (dataStringBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    //    NSString *key = @"123456789012345678901234";
    NSString *initVec = @"init Vec";
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [initVec UTF8String];
    
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey, //"123456789012345678901234", //key
                       kCCKeySize3DES,
                       vinitVec, //"init Vec", //iv,
                       vdataString, //"Your Name", //dataString,
                       dataStringBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    //if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
    /*else if (ccStatus == kCC ParamError) return @"PARAM ERROR";
	 else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
	 else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
	 else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
	 else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
	 else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED"; */
    
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr 
                                                                length:(NSUInteger)movedBytes] 
                                        encoding:NSUTF8StringEncoding] 
                  autorelease];
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMBase64 stringByEncodingData:myData];
    }
    
    return result;
} 

/*
调用示例代码

NSString* req = @"234234234234234中国";
NSString* key = @"888fdafdakfjak;";

NSString* ret1 = [NSString TripleDES:req encryptOrDecrypt:kCCEncrypt key:key];        
NSLog(@"3DES/Base64 Encode Result=%@", ret1);

NSString* ret2 = [NSString TripleDES:ret1 encryptOrDecrypt:kCCDecrypt key:key];
NSLog(@"3DES/Base64 Decode Result=%@", ret2);
*/


- (NSString *)stringByEscapingMetacharacters;
{
    const char *UTF8Input = [self UTF8String];
    char *UTF8Output = [[NSMutableData dataWithLength:strlen(UTF8Input) * 4 + 1 /* Worst case */] mutableBytes];
    char ch, *och = UTF8Output;
	
    while ((ch = *UTF8Input++))
        if (ch == '\'' || ch == '\'' || ch == '\\' || ch == '"')
        {
            *och++ = '\\';
            *och++ = ch;
        }
        else if (isascii(ch))
            och = vis(och, ch, VIS_NL | VIS_TAB | VIS_CSTYLE, *UTF8Input);
        else
            och+= sprintf(och, "\\%03hho", ch);
	
    return [NSString stringWithUTF8String:UTF8Output];
}

//Temp Raik Add
+ (NSString *)getEscapeMetacharacters:(NSString *)formatString
{
	if(!formatString)
	{
		return nil;
	}
	formatString = [formatString stringByReplacingOccurrencesOfString:@"\\" withString:@"%5C"];
	formatString = [formatString stringByReplacingOccurrencesOfString:@"|" withString:@"%7C"];
	
	return formatString;
}


@end


@implementation UIColor (Color)

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert{
	NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
	if([cString length]==3){
		
		NSString *c1 = [cString substringWithRange:NSMakeRange(0,1)];
		NSString *c2 = [cString substringWithRange:NSMakeRange(1,1)];
		NSString *c3 = [cString substringWithRange:NSMakeRange(2,1)];
		
		cString = [NSString stringWithFormat:@"%@%@%@%@%@%@",c1,c1,c2,c2,c3,c3,nil];
	}
	
	// String should be 6 or 8 characters
	if ([cString length] < 6) return [UIColor blackColor];
	// strip 0X if it appears
	if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
		if ([cString length] != 6) return [UIColor blackColor];
	// Separate into r, g, b substrings
	NSRange range;
	range.location = 0;
	range.length = 2;
	NSString *rString = [cString substringWithRange:range];
	range.location = 2;
	NSString *gString = [cString substringWithRange:range];
	range.location = 4;
	NSString *bString = [cString substringWithRange:range];
	// Scan values
	unsigned int r, g, b;
	[[NSScanner scannerWithString:rString] scanHexInt:&r];
	[[NSScanner scannerWithString:gString] scanHexInt:&g];
	[[NSScanner scannerWithString:bString] scanHexInt:&b];
	
	return [UIColor colorWithRed:((float) r / 255.0f)
						   green:((float) g / 255.0f)
							blue:((float) b / 255.0f)
						   alpha:1.0f];
}
@end

@implementation UIColor (Document)
+ (NSString *)documentsDirectory{
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documents = [paths objectAtIndex:0];
	
	return documents;
}
@end

