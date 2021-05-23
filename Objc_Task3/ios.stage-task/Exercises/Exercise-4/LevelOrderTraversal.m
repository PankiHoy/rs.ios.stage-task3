#import "LevelOrderTraversal.h"

@interface BTreeNode : NSObject

@property (assign, nonatomic) NSNumber *value;
@property (strong, nonatomic) BTreeNode *rightBranch;
@property (strong, nonatomic) BTreeNode *leftBranch;

-(instancetype)initWithValue:(NSNumber *)value;
-(NSArray *)getLevelOrderTraversal:(BTreeNode *)preorderTraversal;

+(BTreeNode *)getRootFromPreorder:(NSArray *)preorderTraversal;

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

+ (instancetype)getRootFromPreorder:(NSArray *)preorder {
     if (preorder.count == 0 || preorder[0] == [NSNull null]) {
         return nil;
     }

     BTreeNode *tree = [[BTreeNode alloc] initWithValue:preorder[0]];

     if (preorder.count == 1) {
         return tree;
     }

     unsigned long rightNodePosition = preorder.count;
     for (unsigned long i = 0; i < preorder.count; ++i) {
         if (preorder[i] != [NSNull null] && [preorder[i] intValue] > [preorder[0] intValue]) {
             rightNodePosition = i;
             break;
         }
     }

     if (rightNodePosition == preorder.count) {
         tree.rightBranch = nil;
     } else {
         tree.rightBranch = [BTreeNode getRootFromPreorder:[preorder subarrayWithRange:NSMakeRange(rightNodePosition, preorder.count - rightNodePosition)]];
     }

     tree.leftBranch = [BTreeNode getRootFromPreorder:[preorder subarrayWithRange:NSMakeRange(1, rightNodePosition - 1)]];

     return tree;
 }

- (NSArray *)getLevelOrderTraversal:(BTreeNode *)root {
    NSMutableArray *queue = [[NSMutableArray alloc] init];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    if (root == nil) {
        return nil;
    }
    
    [queue addObject:root];
    
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
    BTreeNode *node = [BTreeNode getRootFromPreorder:[tree mutableCopy]];
    return node == nil ? @[] : [node getLevelOrderTraversal:node];
}
