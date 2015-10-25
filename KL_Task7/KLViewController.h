//
//  KLViewController.h
//  KM_LV_Task7
//
//  Created by fpmi on 24.10.15.
//  Copyright (c) 2015 fpmi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLViewController : NSObject <NSURLConnectionDelegate>
{
    NSMutableData *_responseData;
    NSMutableString *_code;
    NSMutableString *_rate;
    NSString *_parsingElement;
}

@end
