#import "PlayersSeparator.h"

@implementation PlayersSeparator

- (NSInteger)dividePlayersIntoTeams:(NSArray<NSNumber *>*)ratingArray {
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<ratingArray.count; i++) {
        for (int j=i+1; j<ratingArray.count; j++) {
            if ([ratingArray[i] integerValue] < [ratingArray[j] integerValue]) {
                for (int k=j+1; k<ratingArray.count; k++) {
                    if ([ratingArray[j] integerValue] < [ratingArray[k] integerValue]) {
                        [resultArray addObjectsFromArray:@[ratingArray[i], ratingArray[j], ratingArray[k]]];
                    }
                }
            }
            if ([ratingArray[i] integerValue] > [ratingArray[j] integerValue]) {
                for (int k=j+1; k<ratingArray.count; k++) {
                    if ([ratingArray[j] integerValue] > [ratingArray[k] integerValue]) {
                        [resultArray addObjectsFromArray:@[ratingArray[i], ratingArray[j], ratingArray[k]]];
                    }
                }
            }
        }
    }
    return (int)resultArray.count/3;
}

@end
