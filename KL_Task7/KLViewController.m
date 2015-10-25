//
//  KLViewController.m
//  KM_LV_Task7
//
//  Created by fpmi on 24.10.15.
//  Copyright (c) 2015 fpmi. All rights reserved.
//

#import "KLViewController.h"

@implementation KLViewController

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    
    _responseData = [[NSMutableData alloc] init];

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
     NSString* newStr = [NSString stringWithUTF8String:[_responseData bytes]];
     NSLog(@"%@",newStr);
    
    NSXMLParser * parser = [[NSXMLParser alloc] initWithData:_responseData];
    [parser setDelegate:self];
    [parser parse];
    
    [parser release];
    [_responseData release];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"CharCode"]) {
        _parsingElement = elementName;
        _code = [[NSMutableString alloc] init];
    }
    else if ([elementName isEqualToString:@"Rate"])
    {
        _parsingElement = elementName;
        _rate = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    _parsingElement = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
   if([_parsingElement isEqualToString:@"CharCode"])
   {
       [_code appendString: string];
   }
   else if([_parsingElement isEqualToString:@"Rate"])
   {
       [_rate appendString: string];
       NSLog(@"%@ - %@", _code, _rate);
       [_rate release];
       [_code release];

   }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error: %@!", error);
}

@end
