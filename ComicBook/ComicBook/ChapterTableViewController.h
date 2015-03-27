//
//  ChapterTableViewController.h
//  ComicBook
//
//  Created by jinkeke@techshino.com on 15/3/17.
//  Copyright (c) 2015年 www.techshino.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChapterTableViewController : UITableViewController

{
    NSMutableArray *_chapImageArray;
}
@property (nonatomic,strong)NSString *chapID;

@end
