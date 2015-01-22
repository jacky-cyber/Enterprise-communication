//
//  Integrated+Extensions.h
//  LastHistory
//
//  Created by Frederik Seiffert on 28.11.08.
//  Copyright 2008 Frederik Seiffert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSString (Extensions)

//中文编码转换
/**
 * URL encodes a string
 */
- (NSString*)stringByURLEncodingStringParameter;
+ (NSString *)getDate;
+ (NSString *)createUUID;
+ (NSString *)decodeUTF8ToChinese:(NSString *)encodeStr;
+ (NSString *)encodeChineseToUTF8:(NSString *)encodeStr;
+ (NSString *)encodeURL:(NSString *)string;
+ (NSString *)encodeURL:(NSString *)string endcode:(NSStringEncoding)stringEncoding;
+ (NSString *)encodeURL:(NSString *)originalString stringEncoding:(NSStringEncoding)stringEncoding;
+ (NSString*)encodeXML:(NSString *)originalString;
+ (NSString*)decodeXML:(NSString *)originalString;
+ (NSString *)unEscapedString:(NSString *)oldString;


- (NSString *)stringByEscapingMetacharacters;
//加密解密
- (NSString *)md5;
+ (NSData *)desData:(NSData *)data key:(NSString *)keyString CCOperation:(CCOperation)op;
//3des+base64
+ (NSString *)tripleDES:(NSString*)dataString encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key;

+ (NSString *)getEscapeMetacharacters:(NSString *)formatString;

@end

@interface UIColor (Color)

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

@end

@interface UIColor (Document)

+ (NSString *)documentsDirectory;

@end