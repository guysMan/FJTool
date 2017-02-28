//
//  NSData+AES.m
//  TestAES
//
//  Created by Baoyongzhang on 13-10-18.
//  Copyright (c) 2013年 Baoyongzhang. All rights reserved.
//

#import "NSData+AES.h"

@implementation NSData (AES)

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

+(void)AESKeyRand:(char*)data length:(NSInteger)len
{
    while( len > 0 )
    {
        *(data + --len) =  127 - arc4random() % 256;  /* 产生-127 - 128 之间的随机整数 */
    }
}

+ (NSData *) AESEncryptWithData:(NSData *)data encodedKey:(char *)keyArray
{	// 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    bzero(buffer, sizeof(buffer));
    
    size_t numBytesEncrypted = 0;
//    char keyArray[]={99, -123, 61, 75, 62, 100, -35, 114, 48, 68, -85, -110, -60, 82, -117, 77};
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,kCCOptionPKCS7Padding,
                                          //                                          [[AES_KEY dataUsingEncoding:NSUTF8StringEncoding] bytes],
                                          keyArray,
                                          kCCKeySizeAES128,
                                          [[AES_IV dataUsingEncoding:NSUTF8StringEncoding] bytes] /* initialization vector (optional) */,
                                          [data bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        return encryptData;//[encryptData base64Encoding2];
        
    }
    
    free(buffer); //free the buffer;
    return nil;
}


+ (NSString *) AESEncryptWithData:(NSData *)data
{	// 'key' should be 32 bytes for AES256, will be null-padded otherwise
	char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
	bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
	NSUInteger dataLength = [data length];
    
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
    bzero(buffer, sizeof(buffer));
	
	size_t numBytesEncrypted = 0;
    char keyArray[]={99, -123, 61, 75, 62, 100, -35, 114, 48, 68, -85, -110, -60, 82, -117, 77};
    
	CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,kCCOptionPKCS7Padding,
//                                          [[AES_KEY dataUsingEncoding:NSUTF8StringEncoding] bytes],
                                          keyArray,
                                          kCCKeySizeAES128,
										  [[AES_IV dataUsingEncoding:NSUTF8StringEncoding] bytes] /* initialization vector (optional) */,
										  [data bytes], dataLength, /* input */
										  buffer, bufferSize, /* output */
										  &numBytesEncrypted);
	if (cryptStatus == kCCSuccess) {
        NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
		return [encryptData base64Encoding2];
        
	}
	
	free(buffer); //free the buffer;
	return nil;
}

+ (NSData *)AESDecryptWithText:(NSString *)text
{
    NSData *cipherData = [NSData dataWithBase64EncodedString:text];
	// 'key' should be 32 bytes for AES256, will be null-padded otherwise
	char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
	bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
	NSUInteger dataLength = [cipherData length];
	
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
    
	size_t numBytesDecrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
										  [[AES_KEY dataUsingEncoding:NSUTF8StringEncoding] bytes], kCCKeySizeAES128,
										  [[AES_IV dataUsingEncoding:NSUTF8StringEncoding] bytes] ,/* initialization vector (optional) */
										  [cipherData bytes], dataLength, /* input */
										  buffer, bufferSize, /* output */
										  &numBytesDecrypted);
	
	if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
	
	free(buffer); //free the buffer;
	return nil;
}


+ (NSData *)AESDecryptWithText:(NSData *)cipherData decKey:(char *)keyArray
{
//    NSData *cipherData = [NSData dataWithBase64EncodedString:text];
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    NSUInteger dataLength = [cipherData length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyArray, kCCKeySizeAES128,
                                          [[AES_IV dataUsingEncoding:NSUTF8StringEncoding] bytes] ,/* initialization vector (optional) */
                                          [cipherData bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}


+ (id)dataWithBase64EncodedString:(NSString *)string;
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:nil];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

- (NSString *)base64Encoding2;
{
    if ([self length] == 0)
        return @"";
    
    char *characters = malloc((([self length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [self length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [self length])
            buffer[bufferLength++] = ((char *)[self bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

@end
