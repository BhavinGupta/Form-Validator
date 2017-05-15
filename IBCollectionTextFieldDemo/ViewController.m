//
//  ViewController.m
//  IBCollectionTextFieldDemo
//
//  Created by Bhavin Gupta on 09/05/17.
//  Copyright © 2017 Easy Pay. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tblTextFields setHidden:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud.bezelView setBackgroundColor:[UIColor blackColor]];
    hud.contentColor = [UIColor whiteColor];
    hud.label.text = @"Loading Form...";
    [self performSelector:@selector(initWithTextFieldArray) withObject:nil afterDelay:2.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Dyanmic UITextField Array Method
- (void)initWithTextFieldArray{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        self.aryTextFields = [[NSMutableArray alloc]initWithObjects:[NSMutableArray new],[NSMutableArray new],[NSMutableArray new],[NSMutableArray new],[NSMutableArray new], nil];
        
        // Section Dictionary
        NSMutableDictionary *mSecDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Personal Information", @"txtFieldSection", nil];
        NSMutableDictionary *mSecDic1 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Address", @"txtFieldSection", nil];
        
        // Rows Dictionary
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Enter First Name", @"txtFieldPlaceholder", nil];
        NSMutableDictionary *mDic1 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Enter Last Name", @"txtFieldPlaceholder", nil];
        NSMutableDictionary *mDic2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Enter E-mail Address", @"txtFieldPlaceholder", nil];
        NSMutableDictionary *mDic3 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Enter Age", @"txtFieldPlaceholder", nil];
        NSMutableDictionary *mDic4 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Enter Mobile Number", @"txtFieldPlaceholder", nil];
        NSMutableDictionary *mDic5 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Enter Pin Code", @"txtFieldPlaceholder", nil];
        NSMutableDictionary *mDic6 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Enter State", @"txtFieldPlaceholder", nil];
        NSMutableDictionary *mDic7 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Enter City", @"txtFieldPlaceholder", nil];
        NSMutableDictionary *mDic8 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Enter Home Address", @"txtFieldPlaceholder", nil];
        NSMutableDictionary *mDic9 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Enter Office Address", @"txtFieldPlaceholder", nil];
        
        NSArray *arySecFields = @[mSecDic,mSecDic1];
        NSArray *aryFields = @[mDic,mDic1,mDic2,mDic3,mDic4];
        NSArray *aryFlds = @[mDic5,mDic6,mDic7,mDic8,mDic9];
        
        for (int i=0; i<arySecFields.count; i++) {
            NSDictionary *dic = arySecFields[i];
            [self.aryTextFields[0] addObject:dic];
        }
        
        for (int i=0; i<aryFields.count; i++) {
            NSDictionary *dic = aryFields[i];
            [self.aryTextFields[1] addObject:dic];
            [self.aryTextFields[2] addObject:@""];
        }
        
        for (int i=0; i<aryFlds.count; i++) {
            NSDictionary *dic = aryFlds[i];
            [self.aryTextFields[3] addObject:dic];
            [self.aryTextFields[4] addObject:@""];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tblTextFields reloadData];
            [self.tblTextFields setHidden:NO];
        });
    });
}

#pragma mark - UITableView Delegate And Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.aryTextFields[0] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return [self.aryTextFields[1] count];
    }
    else if (section == 1){
        return [self.aryTextFields[2] count];
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"%@",self.aryTextFields[0][section][@"txtFieldSection"]];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"idCellTextFields";
    TextFieldTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(indexPath.section == 0){
        cell.txtFields.placeholder = [NSString stringWithFormat:@"%@",self.aryTextFields[1][indexPath.row][@"txtFieldPlaceholder"]];
        cell.txtFields.text = [NSString stringWithFormat:@"%@",self.aryTextFields[2][indexPath.row]];
        cell.txtFields.tag = 100+indexPath.row;
    }
    else if(indexPath.section == 1){
        cell.txtFields.placeholder = [NSString stringWithFormat:@"%@",self.aryTextFields[3][indexPath.row][@"txtFieldPlaceholder"]];
        cell.txtFields.text = [NSString stringWithFormat:@"%@",self.aryTextFields[4][indexPath.row]];
        cell.txtFields.tag = 105+indexPath.row;
    }
    return cell;
}

#pragma mark - UITextField Delegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField.tag == 102){
        textField.keyboardType = UIKeyboardTypeEmailAddress;
    }
    else if(textField.tag == 103 || textField.tag == 105){
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    else if (textField.tag == 104){
        textField.keyboardType = UIKeyboardTypePhonePad;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *replaced = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    CGPoint point = [textField convertPoint:CGPointZero toView:self.tblTextFields];
    self.currentIndex = [self.tblTextFields indexPathForRowAtPoint:point];
    
    if(self.currentIndex.section == 0)
       [self.aryTextFields[2] replaceObjectAtIndex:textField.tag-100 withObject:replaced];
    else if (self.currentIndex.section == 1)
       [self.aryTextFields[4] replaceObjectAtIndex:textField.tag-105 withObject:replaced];
    
    if(textField.tag == 103){
        return !([replaced length]>3);
    }
    else if (textField.tag == 104){
        return !([replaced length]>10);
    }
    else if (textField.tag == 105){
        return !([replaced length]>6);
    }
    return YES;
}

#pragma mark - Button Action Methods
- (IBAction)onClickSubmitButton:(UIBarButtonItem*)sender{
    [self.view endEditing:YES];
    if([self checkValidation]){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud.bezelView setBackgroundColor:[UIColor blackColor]];
        hud.contentColor = [UIColor whiteColor];
        hud.label.text = @"Validating Form...";
        [self performSelector:@selector(successAlert) withObject:nil afterDelay:2.0];
    }
}

#pragma mark - Success Alert Method
- (void)successAlert{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
    [[[UIAlertView alloc]initWithTitle:@"Text Field Demo" message:@"Form Validation Successful" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
}

#pragma mark - Validation Method
- (BOOL)checkValidation{
    for (int i=0; i<[self.aryTextFields[1] count]; i++) {
        TextFieldTableCell *cell = [self.tblTextFields cellForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        if((cell.txtFields.tag == 100 || cell.txtFields.tag == 101 || cell.txtFields.tag == 102 || cell.txtFields.tag == 103 || cell.txtFields.tag == 104) && [cell.txtFields.text isEqualToString:@""]){
            [[[UIAlertView alloc]initWithTitle:@"Text Field Demo" message:[NSString stringWithFormat:@"Please %@",cell.txtFields.placeholder] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            return NO;
        }
        else if(cell.txtFields.tag == 102){
            NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
            if ([emailTest evaluateWithObject:cell.txtFields.text] == NO){
                [[[UIAlertView alloc]initWithTitle:@"Text Field Demo" message:@"Please enter valid email address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                return NO;
            }
        }
        else if (cell.txtFields.tag == 104 && [cell.txtFields.text length]<10){
            [[[UIAlertView alloc]initWithTitle:@"Text Field Demo" message:@"Please enter 10 digit mobile number" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            return NO;
        }
    }
    for (int i=0; i<[self.aryTextFields[2] count]; i++) {
        TextFieldTableCell *cell = [self.tblTextFields cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:1]];
        if((cell.txtFields.tag == 105 || cell.txtFields.tag == 106 || cell.txtFields.tag == 107 || cell.txtFields.tag == 108 || cell.txtFields.tag == 109) && [cell.txtFields.text isEqualToString:@""]){
            [[[UIAlertView alloc]initWithTitle:@"Text Field Demo" message:[NSString stringWithFormat:@"Please %@",cell.txtFields.placeholder] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            return NO;
        }
        else if (cell.txtFields.tag == 105 && [cell.txtFields.text length]<6){
            [[[UIAlertView alloc]initWithTitle:@"Text Field Demo" message:@"Please enter 6 digit pin code" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            return NO;
        }
    }
    return YES;
}

@end
