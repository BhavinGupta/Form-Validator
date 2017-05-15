//
//  ViewController.h
//  IBCollectionTextFieldDemo
//
//  Created by Bhavin Gupta on 09/05/17.
//  Copyright © 2017 Easy Pay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "TextFieldTableCell.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tblTextFields;
@property (strong, nonatomic) NSMutableArray *aryTextFields;
@property (strong, nonatomic) NSIndexPath *currentIndex;

@end

