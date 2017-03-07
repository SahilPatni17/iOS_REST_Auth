//
//  GeneralMethod.h
//  Nimbuka
//
//  Created by OmniPresent on 05/10/15.
//  Copyright (c) 2015 Omnipresent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GeneralMethod : NSObject
+(NSString *)getStringFromDateToNext7Days:(NSDate*)date format:(NSString*)format;
+(NSDate*)getDateFromString:(NSString*)str format:(NSString*)format;
+(NSString*)getStringFromDate:(NSDate*)date format:(NSString*)format;
+(NSDate*)changeDateFormatFromDate:(NSDate*)date format:(NSString*)format;
+(int)DateDiffrence:(NSDate*)firstDate secondDate:(NSDate*)secondDate;
+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval;
+(NSString*)get12hrtimeFormatFromString:(NSString*)time;
+ (NSDate*) nextHourDate:(NSDate*)inDate;
+(BOOL)funCheckForNull:(NSString *)string;
+(BOOL)NSStringIsValidEmail:(NSString *)checkString;
+ (BOOL)validatePhone:(NSString *)phoneNumber;
+ (NSString *)randomAlphanumericStringWithLength:(NSInteger)length;
+(NSInteger)nextIdentifies;
+ (NSString *)uuid;
+(NSMutableArray *)getListOfSearchElementsFromArray:(NSMutableArray *)arrData forKey:(NSString *)key withSearchText:(NSString *)text;
+(NSMutableArray *)sortArrayAsNumericSearch:(NSMutableArray *)array fromKey:(NSString *)key;
+(void)viewPos:(UIView*)viewName xpos:(int)xpos ypos:(int)ypos height:(int)height;
+(BOOL)isConnectionAvailable;
+ (BOOL)networkConnection;
+(void)emptyDataView:(UITableView*)tableView andImage:(NSString*)imageName andText:(NSString*)text;

+ (NSString*)toJSONStringFromObject:(id)object;
+(UIImage *)imageResize:(UIImage *)img;
+ (NSString *)encodeToBase64String:(UIImage *)image;
+(CGRect)setViewFrameFromPreviousView:(UIControl*)prev withCurrent:(UIControl*)current andDistance:(CGFloat)distance;
+(void)createBottomLineOfTextField:(UITextField*)txt withColor:(UIColor*)color;
+(void)setLeftIconOnTextField:(UITextField*)txt withImage:(NSString*)strImage;

@end
