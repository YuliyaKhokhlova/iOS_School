//
//  MasterViewController.h
//  Galery
//
//  Created by Yuliya Khokhlova on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewUpdater.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <DetailViewUpdater>
{
    NSString * imagesPath;
    NSArray * imagesName;
    NSMutableArray * images;

    NSMutableArray * scrollSubviews;
    NSInteger currentItem;
}

@property (strong, nonatomic) DetailViewController * detailViewController;

@end
