#import "LevelOrderTraversal.h"

@interface BTreeNode : NSObject

@property (assign, nonatomic) NSNumber *value;
@property (strong, nonatomic) BTreeNode *rightBranch;
@property (strong, nonatomic) BTreeNode *leftBranch;

-(instancetype)initWithValue:(NSNumber *)value;

+(BTreeNode *)getRootFromPreorder:(NSArray *)preorderTraversal;
+ (NSArray *)getLevelOrderTraversal:(BTreeNode *)root;

@end

@implementation BTreeNode

-(instancetype)initWithValue:(NSNumber *)value {
    self = [super init];
    if (self) {
        _value = value;
        _rightBranch = nil;
        _leftBranch = nil;
    }
    return self;
}

+ (BTreeNode *)getRootFromPreorder:(NSMutableArray *)preorder {
    if (preorder.count == 0) {
        return nil;
    }

    if (preorder.firstObject == [NSNull null]) {
        [preorder removeObjectAtIndex:0];
        return nil;
    }
    
    BTreeNode *root = [[BTreeNode alloc] initWithValue:preorder.firstObject];
    [preorder removeObjectAtIndex:0];

    root.leftBranch  = [BTreeNode getRootFromPreorder:preorder];
    root.rightBranch = [BTreeNode getRootFromPreorder:preorder];
    
    return root;
}

+ (NSArray *)getLevelOrderTraversal:(BTreeNode *)root {
    NSMutableArray *queue = [[NSMutableArray alloc] init];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    [queue addObject:root];
    
    //    ┌── nil
    //    4
    //    │  ┌── nil
    //    └──3
    //       │  ┌── nil
    //       └──2
    //          └── 1
    
    while (queue.count != 0) {
        NSInteger size = queue.count;
        NSMutableArray *currentLevel = [[NSMutableArray alloc] init];
        
        for (int i=0; i<size; i++) {
            BTreeNode *node = queue.firstObject;
            [queue removeObjectAtIndex:0];
            [currentLevel addObject:node.value];
            if (node.leftBranch != nil) {
                [queue addObject:node.leftBranch];
            }
            if (node.rightBranch != nil) {
                [queue addObject:node.rightBranch];
            }
        }
        [resultArray addObject:[NSArray arrayWithArray:currentLevel]];
    }
    
    return resultArray;
}

@end

NSArray *LevelOrderTraversalForTree(NSArray *tree) {
    return [BTreeNode getRootFromPreorder:[tree mutableCopy]] == nil ? @[] : [BTreeNode getLevelOrderTraversal:[BTreeNode getRootFromPreorder:[tree mutableCopy]]];
}
