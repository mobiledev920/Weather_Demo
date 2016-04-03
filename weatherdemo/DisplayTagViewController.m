//
//  DisplayTagViewController.m
//  weatherdemo
//
//  Created by admin on 2/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "DisplayTagViewController.h"
#import "DisplayTableViewCell.h"
@interface DisplayTagViewController (){
    NSMutableArray *displaytag;
}

@end

@implementation DisplayTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    
}
- (void) initUI{
    UIDevice *device = [UIDevice currentDevice];
    NSString *strUUID = [[device identifierForVendor] UUIDString];
    NSDictionary *param = [NSDictionary alloc];
    param = [NSDictionary dictionaryWithObjects:@[strUUID] forKeys:@[@"user_id"]];
    [self requestUserPosts:param];
}
- (void) requestUserPosts:(id) params {
    NSDictionary *resObj = nil;
    resObj = [commonUtils httpJsonRequest:API_URL_TAG_SHOW withJSON:params];
    
    [commonUtils hideActivityIndicator];
   
    
    if (resObj != nil) {
        NSDictionary *result = (NSDictionary*)resObj;
        NSDecimalNumber *status = [result objectForKey:@"status"];
        displaytag = [result objectForKey:@"user_output"];
        if([status intValue] == 0) {
            NSLog(@"this");
        } else {
            NSLog(@"not");
            //            NSString *msg = (NSString *)[resObj objectForKey:@"msg"];
            //            if([msg isEqualToString:@""]) msg = @"Please complete entire form";
            //            [commonUtils showVAlertSimple:@"Warning" body:msg duration:1.4];
        }
    } else {
        [commonUtils showVAlertSimple:@"Connection Error" body:@"Please check your internet connection status" duration:1.0];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _displayTagTableView) {
        
        return [displaytag count];
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    NSLog(@"cellForRowAtIndexPath");
    if (tableView == _displayTagTableView) {
        static NSString *cellID = @"displaytablecell";
        DisplayTableViewCell *cell = (DisplayTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            NSArray *nibarray = [[NSBundle mainBundle] loadNibNamed:@"DisplayTableViewCell" owner:self options:nil
                                 ];
            cell = [nibarray objectAtIndex:0];
        }
        
        cell.lbdateTime.text = [[displaytag objectAtIndex:indexPath.row] objectForKey:@"temp_datetime"];
        cell.lblocation.text = [[displaytag objectAtIndex:indexPath.row] objectForKey:@"temp_location"];
        cell.lbweather.text = [[displaytag objectAtIndex:indexPath.row] objectForKey:@"temp_weather"];
        cell.lbemotion.text = [[displaytag objectAtIndex:indexPath.row] objectForKey:@"temp_emotion"];
        cell.lbtag.text = [[displaytag objectAtIndex:indexPath.row] objectForKey:@"temp_tag"];
        cell.lbMoonAge.text = [[displaytag objectAtIndex:indexPath.row] objectForKey:@"temp_moonage"];
        cell.lbhumidity.text = [[displaytag objectAtIndex:indexPath.row] objectForKey:@"temp_humidity"];
        cell.lbSuba.text = [[displaytag objectAtIndex:indexPath.row] objectForKey:@"temp_suba"];
        cell.lbSubb.text = [[displaytag objectAtIndex:indexPath.row] objectForKey:@"temp_subb"];
        cell.lbtemp.text = [[displaytag objectAtIndex:indexPath.row] objectForKey:@"temp_temperature"];
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    if(tableView == _displayTagTableView){
        
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (IBAction) tappedReturn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
