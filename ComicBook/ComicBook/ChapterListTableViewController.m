//
//  ChapterListTableViewController.m
//  ComicBook
//
//  Created by jinkeke@techshino.com on 15/3/17.
//  Copyright (c) 2015年 www.techshino.com. All rights reserved.
//

#import "ChapterListTableViewController.h"
#import "SVHTTPRequest.h"
#import "ChapterTableViewController.h"

@interface ChapterListTableViewController ()

@end

@implementation ChapterListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ChapterList";
    _chapListArray = [[NSMutableArray alloc]initWithCapacity:1];
    [self getListData];
    
}

- (void)getListData{
    NSString *chapApi = @"http://test4.ishuhui.net/ComicBooks/GetChapterList";
    [SVHTTPRequest GET:chapApi parameters:[NSDictionary dictionaryWithObject:self.bookID forKey:@"id"] completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if (error) {
            [self alertTextWith:[error localizedDescription]];
        }
        else
        {
            //NSLog(@"%@",response);
            [_chapListArray removeAllObjects];
            NSDictionary *jsonDic = [NSDictionary dictionaryWithDictionary:response];
            [_chapListArray addObjectsFromArray:[[jsonDic objectForKey:@"Return"] objectForKey:@"List"]];
            [self.tableView reloadData];
            
            if ([_chapListArray count]==0) {
                [self alertTextWith:@"列表为空！"];
            }

        }
        
    }];
}

- (void)alertTextWith:(NSString *)text
{
    UIAlertView *alertText = [[UIAlertView alloc]initWithTitle:nil message:text delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertText show];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *oneDic = [_chapListArray objectAtIndex:indexPath.row];
    ChapterTableViewController *chap = [ChapterTableViewController new];
    chap.chapID = oneDic[@"Id"];
    [self.navigationController pushViewController:chap animated:YES];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_chapListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary *oneDic = [_chapListArray objectAtIndex:indexPath.row];
    cell.textLabel.text = oneDic[@"Title"];
    
    return cell;
}



@end
