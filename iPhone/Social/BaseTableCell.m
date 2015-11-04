//
//  BaseTableCell.m
//  BTracker
//
//  Created by Satish Kumar on 04/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseTableCell.h"

@implementation BaseTableCell

+ (BaseTableCell *)cellFromNibNamed:(NSString *)nibName {
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        
    {
        nibName=[NSString stringWithFormat:@"%@_iPad",nibName];
        
    }
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:NULL];
    NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
    BaseTableCell *customCell = nil;
    NSObject* nibItem = nil;
    while ((nibItem = [nibEnumerator nextObject]) != nil) {
        if ([nibItem isKindOfClass:[BaseTableCell class]]) {
            customCell = (BaseTableCell *)nibItem;
            break; // we have a winner
        }
    }
    return customCell;
}


@end
