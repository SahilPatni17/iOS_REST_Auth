//
//  GeneralMethod.m
//  Nimbuka
//
//  Created by OmniPresent on 05/10/15.
//  Copyright (c) 2015 Omnipresent. All rights reserved.
//

#import "GeneralMethod.h"

@implementation GeneralMethod

#pragma mark - methods For Date

+(NSString *)getStringFromDateToNext7Days:(NSDate*)date format:(NSString*)format
{
    NSDateFormatter *df2 = [[NSDateFormatter alloc]init];
    [df2 setDateFormat:format];
    NSString *str=[df2 stringFromDate:date];
    return str;
}
+(NSDate*)getDateFromString:(NSString*)str format:(NSString*)format
{
    NSDateFormatter *df2 = [[NSDateFormatter alloc]init];
    [df2 setDateFormat:format];
    [df2 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    NSDate *date=[df2 dateFromString:str];
    return date;
}
+(NSString*)getStringFromDate:(NSDate*)date format:(NSString*)format
{
    NSDateFormatter *df2 = [[NSDateFormatter alloc]init];
    [df2 setDateFormat:format];
    NSString *str=[df2 stringFromDate:date];
    return str;
}
+(NSDate*)changeDateFormatFromDate:(NSDate*)date format:(NSString*)format
{
//    NSDateFormatter *df2 = [[NSDateFormatter alloc]init];
//    [df2 setDateFormat:format];
    NSString *strDate=[self getStringFromDateToNext7Days:date format:format];
    date=[self getDateFromString:strDate format:format];
    return date;
}

//+(NSArray *)getStringFromDate:(NSDate*)date format:(NSString*)format
//{
//    NSDateFormatter *df2 = [[NSDateFormatter alloc]init];
//    [df2 setDateFormat:format];
//    NSString *str=[df2 stringFromDate:date];
//    NSArray *arr = [str componentsSeparatedByString:@"-"];
//    return arr;
//}
+(int)DateDiffrence:(NSDate*)firstDate secondDate:(NSDate*)secondDate
{
    NSTimeInterval interval = [firstDate timeIntervalSinceDate:secondDate];
    return interval;
}
+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval
{
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}
// new Implement By Muzu For 12hr Time Format from String
+(NSString*)get12hrtimeFormatFromString:(NSString*)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    NSDate *date = [dateFormatter dateFromString:time];
    dateFormatter.dateFormat = @"hh:mm a";
    NSString *pmamDateString = [dateFormatter stringFromDate:date];
    NSLog(@"original Time = %@",pmamDateString);
    
    return pmamDateString;
}
+ (NSDate*) nextHourDate:(NSDate*)inDate //NOTE : If you Want Next Month Or Year then jsut change components hour to month or year
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components: NSCalendarUnitEra|NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour fromDate: inDate];
    //here you can set any hours just change '+1' value
    [comps setHour: [comps hour]+1]; //NSDateComponents handles rolling over between days, months, years, etc
    return [calendar dateFromComponents:comps];
}
/*-(NSDate *) dateRoundedDownTo15Minutes:(NSDate *)dt
 {
 int referenceTimeInterval = (int)[dt timeIntervalSinceReferenceDate];
 int remainingSeconds = referenceTimeInterval % 900;
 int timeRoundedTo5Minutes = referenceTimeInterval - remainingSeconds;
 if(remainingSeconds>450)
 {/// round up
 timeRoundedTo5Minutes = referenceTimeInterval +(900-remainingSeconds);
 }
 NSDate *roundedDate = [NSDate dateWithTimeIntervalSinceReferenceDate:(NSTimeInterval)timeRoundedTo5Minutes];
 return roundedDate;
 }*/
#pragma mark - Validation Methods
+(BOOL)funCheckForNull:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if([string isEqual:[NSNull null]] || string==nil || [string isEqualToString:@""] || [string isEqualToString:@"null"] || [string isEqualToString:@"(null)"])
    {
        return YES;
    }
    return NO;
}
+(BOOL)NSStringIsValidEmail:(NSString *)checkString
{
    NSPredicate *emailTest;
    if (![self funCheckForNull:checkString])
    {
        BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
        NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
        NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
        NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
        emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    }
    return [emailTest evaluateWithObject:checkString];
}
+ (BOOL)validatePhone:(NSString *)phoneNumber
{
    NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [phoneTest evaluateWithObject:phoneNumber];
}
#pragma mark - UIVIEW animation for splitview
+(void)viewPos:(UIView*)viewName xpos:(int)xpos ypos:(int)ypos height:(int)height
{
    [UIView beginAnimations:Nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelay:0.0];
    [viewName setFrame:CGRectMake(xpos, ypos, viewName.frame.size.width,height)];
    [UIView commitAnimations];
    // [viewName.superview addSubview:viewName];
}
+(void)QubeAnimation:(UIView*)ViewName
{
    [ViewName bringSubviewToFront:ViewName.superview];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [ViewName.superview.layer addAnimation:transition forKey:@"animation"];
}
#pragma mark - image related maethods
+(UIImage *) getImageFromURL:(NSString *)fileURL {
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}
//TODO: Resizing Image Without Reduce image quality
+(UIImage *)imageResize:(UIImage *)img
{
    CGSize newSize ;
    
    UIImage *image = img;
    
    if (image.size.width>image.size.height)
    {
        newSize = CGSizeMake(460, 320);// landscape
        
    }
    else if (image.size.height>image.size.width)
    {
        newSize = CGSizeMake(320, 460); // portrait
    }
    else if (image.size.width==image.size.height)
    {
        newSize = CGSizeMake(460, 460); // Square
    }
    
    UIGraphicsBeginImageContext( newSize );
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //    UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
    NSLog(@"%f %f",[newImage size].width,[newImage size].height);
    return newImage;
}
#pragma mark - method For randomly generate Numeric String
+ (NSString *)randomAlphanumericStringWithLength:(NSInteger)length
{
    NSString *letters = @"0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    for (int i = 0; i < length; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    
    return randomString;
}
+(NSInteger)nextIdentifies
{
    static NSString* lastID = @"lastID";
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSInteger identifier = [defaults integerForKey:lastID] + 1;
    [defaults setInteger:identifier forKey:lastID];
    [defaults synchronize];
    return identifier;
}
+ (NSString *)uuid
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge_transfer NSString *)uuidStringRef;
}
#pragma mark - method for get List of Search elements from array
+(NSMutableArray *)getListOfSearchElementsFromArray:(NSMutableArray *)arrData forKey:(NSString *)key withSearchText:(NSString *)text
{
    NSString *match = text;
    NSMutableArray *listFiles = [[NSMutableArray alloc] init];
    NSPredicate *sPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", match];
    NSMutableArray *arrSearchItems=[[NSMutableArray alloc]init];
    for (int i=0; i<arrData.count; i++)
    {
        [arrSearchItems addObject:[[arrData objectAtIndex:i] objectForKey:key]];
    }
    listFiles = [NSMutableArray arrayWithArray:[arrSearchItems filteredArrayUsingPredicate:sPredicate]]; //search list
    NSLog(@"%@",listFiles);
    
    // following array gives you sorted array
    NSMutableArray *sortedArray = [[NSMutableArray alloc]initWithArray: [listFiles sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
    NSLog(@"%@",sortedArray);
    
    //return listFiles; // if you dont want sort list then returns this array
    return sortedArray;
}
+(NSMutableArray *)sortArrayAsNumericSearch:(NSMutableArray *)array fromKey:(NSString *)key
{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:key
                                                   ascending:YES
                                                  comparator:^(id obj1, id obj2)
    {
        return [obj1 compare:obj2 options:NSNumericSearch];
        
    }];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [array
                   sortedArrayUsingDescriptors:sortDescriptors];
    [array removeAllObjects];
    [array addObjectsFromArray:sortedArray];
    
    return array;
}
//M^^Check Internet Connection is Available or Not ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^//
//+(BOOL)isConnectionAvailable
//{
//    if ([self networkConnection] == NotReachable)
//    {
//        /* No Network */
//        return NO;
//    } else
//    {
//        /* Network */
//        return YES;
//    }
//    //Use ReachableViaWiFi / ReachableViaWWAN to get the type of connection.
//}
//+ (BOOL)networkConnection {
//    return [[Reachability reachabilityWithHostName:@"www.google.com"] currentReachabilityStatus];
//}
+(void)emptyDataView:(UITableView*)tableView andImage:(NSString*)imageName andText:(NSString*)text
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tableView.frame.size.height)];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.center.x - tableView.frame.size.width/4 , tableView.center.y - tableView.frame.size.height/4 - 100, tableView.frame.size.width/2, tableView.frame.size.width/2)];
//    imageView.center = tableView.center;
    imageView.image = image;
    [view addSubview:imageView];
//    [imageView setContentMode:UIViewContentModeCenter];
    
    UILabel *messageLbl = [[UILabel alloc] initWithFrame:CGRectMake(10,
                                                                    imageView.frame.size.height + imageView.frame.origin.y + 15
                                                                    , tableView.frame.size.width - 20, 100)];
    messageLbl.numberOfLines = 0;
    messageLbl.lineBreakMode = NSLineBreakByWordWrapping;
    messageLbl.text = text;
    messageLbl.font = [UIFont systemFontOfSize:25.0];
    messageLbl.textAlignment = NSTextAlignmentCenter;
//    [messageLbl sizeToFit];
    [view addSubview:messageLbl];
    
    tableView.backgroundView = view;
}
//Create JSON String from DATA
+ (NSString*)toJSONStringFromObject:(id)object
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *jsonString = @"";
    if (! jsonData)
    {
        NSLog(@"Got an error: %@", error);
    }
    else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
+ (NSString *)encodeToBase64String:(UIImage *)image //  ios 7 >
{
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
+(CGRect)setViewFrameFromPreviousView:(UIControl*)prev withCurrent:(UIControl*)current andDistance:(CGFloat)distance
{
    return CGRectMake(current.frame.origin.x, prev.frame.origin.y + prev.frame.size.height + distance, current.frame.size.width, current.frame.size.height);
}

/*
func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat
{
    let label:UILabel = UILabel(frame: CGRect(x:0, y:0, width:width,height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text
    
    label.sizeToFit()
    return label.frame.height
}

func setViewFrameFromPreviousView(current: AnyObject, prev:AnyObject, distance:CGFloat) -> CGRect
{
    return CGRect(x: (current.frame.origin.x), y: (prev.frame.origin.y) + (prev.frame.height) + distance, width : (current.frame.size.width), height: (current.frame.size.height))
}*/
+(void)createBottomLineOfTextField:(UITextField*)txt withColor:(UIColor*)color
{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = color.CGColor;
    border.frame = CGRectMake(0, txt.frame.size.height - borderWidth, txt.frame.size.width, txt.frame.size.height);
    border.borderWidth = borderWidth;
    [txt.layer addSublayer:border];
    txt.layer.masksToBounds = YES;
}
//Set Left View on TextField
+(void)setLeftIconOnTextField:(UITextField*)txt withImage:(NSString*)strImage
{
    UIImage *iconImage = [UIImage imageNamed:strImage];
    UIView *vwContainer = [[UIView alloc] init];
    [vwContainer setFrame:CGRectMake(0.0f, 0.0f, txt.frame.size.height/1.5, txt.frame.size.height)];
    [vwContainer setBackgroundColor:[UIColor clearColor]];
    
    //    float width = txt.frame.size.height - iconImage.size.width / 2;
    //    float x = width /2;
    //
    //    float height = txt.frame.size.height - iconImage.size.height / 2;
    //    float y = height /2;
    
    UIImageView *icon = [[UIImageView alloc] init];
    [icon setImage:iconImage];
    [icon setFrame:CGRectMake(2 , 0, iconImage.size.width, iconImage.size.height )];
    [icon setBackgroundColor:[UIColor clearColor]];
    
    [vwContainer addSubview:icon];
    
    [txt setLeftView:vwContainer];
    
    [txt setLeftViewMode:UITextFieldViewModeAlways];
    
}
@end
