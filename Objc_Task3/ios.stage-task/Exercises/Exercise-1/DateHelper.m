#import "DateHelper.h"

@implementation DateHelper

#pragma mark - First

-(NSString *)monthNameBy:(NSUInteger)monthNumber {
    if (monthNumber > 12 || monthNumber < 1) {
        return nil;
    }
    
    return [[[NSDateFormatter alloc] init] monthSymbols][monthNumber-1];
}

#pragma mark - Second

- (long)dayFromDate:(NSString *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    return [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:[dateFormatter dateFromString:date]];
}

#pragma mark - Third

- (NSString *)getDayName:(NSDate*) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
    long dayNumber = [[NSCalendar currentCalendar] component:NSCalendarUnitWeekday fromDate:date];
    
    if ([[NSCalendar currentCalendar] component:NSCalendarUnitWeekday fromDate:date]) {
        return [[dateFormatter shortWeekdaySymbols] objectAtIndex:dayNumber-1];
    }
    
    return nil;
}

#pragma mark - Fourth

- (BOOL)isDateInThisWeek:(NSDate *)date {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitWeekOfYear fromDate:date] == [[NSCalendar currentCalendar] component:NSCalendarUnitWeekOfYear fromDate:[NSDate now]] ? YES : NO;
}

@end
