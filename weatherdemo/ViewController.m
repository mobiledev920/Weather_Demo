//
//  ViewController.m
//  weatherdemo
//  http://www.wunderground.com/weather/api/d/docs
//  API key: 5ecd6b933b1f04a5
//  Created by admin on 2/19/16.
//  Copyright © 2016 admin. All rights reserved.
//  a349e783d030385f27e55752c45fb0bc

#import "ViewController.h"
#import "VSDropdown.h"
#import "PolygonAPI.h"
#import "AppDelegate.h"
#import "CollectionViewCell.h"

#import <CoreLocation/CoreLocation.h>
@interface ViewController () <UISearchBarDelegate, UISearchDisplayDelegate, DWTagListDelegate, UICollectionViewDataSource, UICollectionViewDelegate>{
    NSMutableArray *findStrEmotion;
    NSArray *strEmotion;
    NSArray *strTag;
    NSDictionary * check;
    NSDictionary * check_dict;
    NSMutableArray *tagList;
    NSMutableArray *tempArray;
    NSDateFormatter *_dateFormatter;
    CLLocation *location;
    NSString *latitude;
    NSString *longitude;
    BOOL flag;
    CLGeocoder *geoCoder;
    NSString *strTags;
    NSString *moonAge;
    NSString *userID;
    NSString *str1;
    NSString *str2;
    BOOL signUp;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISearchBar *regionSearchBar;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) NSMutableArray *searchResults;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.geocoder = [[CLGeocoder alloc]init];

    geoCoder = [[CLGeocoder alloc] init];
    [self initUI];
    [self initData];
    [self checkingPosition];
    [self createTimer];
}

- (void) initUI{
    flag = NO;
    _popUpView.hidden = true;
    _regionView.hidden = true;
    _tableView3.hidden = YES;
    _txtSearchTag.delegate = self;
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm"];
    _currentTime.text = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter setDateFormat:@"yyyy:MM:dd"];
    _Today.text = [dateFormatter stringFromDate:[NSDate date]];
    signUp = YES;
}

- (void) checkingPosition
{
    
    location = [[AppDelegate appDelegate] getLocation];
    if (location == nil) {
        [self performSelector:@selector(checkingPosition) withObject:nil afterDelay:0.5];
        return;
    }else if (!flag) {
        [self performSelector:@selector(checkingPosition) withObject:nil afterDelay:0.5];
        flag = YES;
        return;
    }
    
    CLLocationCoordinate2D coordinate = [location coordinate];
    latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
    NSLog(@"%@ , %@" ,latitude ,longitude);
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError * error) {
        
        if (error == nil) {
            
            CLPlacemark *placeMark = [placemarks lastObject];
            NSString *postCode = placeMark.postalCode;
            NSString *nameNeighborhood = placeMark.subLocality;
            NSString *nameArea = placeMark.administrativeArea;
            NSString *nameCity = placeMark.locality;
            
            NSLog(@"%@ , %@ ,%@ ,%@" , nameNeighborhood , nameArea, nameCity, postCode);
            _cityName.text = [NSString stringWithFormat:@"%@, %@",nameCity, nameArea];
            NSString *weatherUrl = [NSString stringWithFormat:@"conditions/q/%@/%@.json",nameArea, nameCity];
            [[PolygonAPI sharedManager] getWeather:weatherUrl onSuccess:^(id json) {

                check = [[json objectForKey:@"current_observation"] objectForKey:@"icon_url"];
                NSURL *url = [NSURL URLWithString: (NSString *)check];
                NSData *data = [[NSData alloc] initWithContentsOfURL:url]
                ;
                UIImage *image = [UIImage imageWithData:data];
                [_weatherImage setImage:image];
                NSString *str = [[json objectForKey:@"current_observation"] objectForKey:@"icon"];
                _weatherInfo.text = str;
                NSNumber *temp =  [[json objectForKey:@"current_observation"] objectForKey:@"temp_c"];
                _currentTemp.text = [NSString stringWithFormat:@"%.1f", [temp floatValue]];
                _humidity.text = [[json objectForKey:@"current_observation"] objectForKey:@"relative_humidity"];
            } onFailure:^(NSInteger statusCode, id json) {
                NSLog(@"failure");
            }];
            weatherUrl = [NSString stringWithFormat:@"astronomy/q/%@/%@.json",nameArea, nameCity];
            [[PolygonAPI sharedManager] getWeather:weatherUrl onSuccess:^(id json) {
                moonAge = [NSString stringWithFormat:@"%d",[[[json  objectForKey:@"moon_phase"] objectForKey:@"ageOfMoon"] intValue]];
            } onFailure:^(NSInteger statusCode, id json) {
                NSLog(@"failure");
            }];

        }
        
    }];
    
    UIDevice *device = [UIDevice currentDevice];
    userID = [[device identifierForVendor] UUIDString];
    
    
}
- (NSTimer *) createTimer{
    return [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(timerTicked:) userInfo:nil repeats:YES];
}
- (void) timerTicked: (NSTimer *)timer{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm"];
    _currentTime.text = [dateFormatter stringFromDate:[NSDate date]];
}
- (void) initData{

    NSString *tagFile = [[NSBundle mainBundle] pathForResource:@"Taglist" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:tagFile];
     tagList = [[NSMutableArray alloc] initWithArray:array];
    NSString *emotionFile = [[NSBundle mainBundle] pathForResource:@"EmotionList" ofType:@"plist"];
    NSArray *array1 = [NSArray arrayWithContentsOfFile:emotionFile];
    strEmotion = [[NSArray alloc] initWithArray:array1];
    _searchBar.delegate = self;
    _regionSearchBar.delegate = self;
    findStrEmotion = [[NSMutableArray alloc] initWithArray:strEmotion];
    
    _txtSearchTag.delegate = self;
    [_txtSearchTag addTarget:self action:@selector(textFielDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_tagListView setAutomaticResize:YES];
    [_tagListView setTagDelegate:self];
    _array = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnGetWeatherClicked:(id)sender {
    
    _regionView.hidden = NO;
}
- (void)displayWeatherInfo:(id) json {
    NSLog(@"%@", (NSString *)json);
    
    check = [[json objectForKey:@"current_observation"] objectForKey:@"icon_url"];
    NSURL *url = [NSURL URLWithString: (NSString *)check];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url]
    ;
    UIImage *image = [UIImage imageWithData:data];
    [_weatherImage setImage:image];
    NSString *str = [[json objectForKey:@"current_observation"] objectForKey:@"icon"];
    _weatherInfo.text = str;
    NSLog(@"%@", (NSString *)check);
    
}
/////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    int count = 0;
    if (tableView == _tableviewRegion){
        count = [self.searchResults count];
        return  count;
        
    }
    if (tableView == _tableView3) {
        if (tempArray == nil) {
            return 0;
        }else {
            return tempArray.count;
        }
    }
    return 0;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"tableCell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    if (tableView == _tableviewRegion){
        CLPlacemark *placemark = [self.searchResults objectAtIndex:indexPath.row];
        NSString *city = placemark.locality;
        NSString *country = placemark.country;
        NSString *cellText = [NSString stringWithFormat:@"%@, %@", city, country];
        if([[country lowercaseString] isEqualToString:@"united states"]) {
            NSString *state = placemark.administrativeArea;
            cellText = [NSString stringWithFormat:@"%@, %@", city, state];
        }
        cell.textLabel.text = cellText;
    }
    if (tableView == _tableView3) {
        cell.textLabel.text = [tempArray objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if (tableView != _tableviewRegion) {
        _popUpView.hidden = false;
        signUp = NO;
    }
    if (tableView == _tableviewRegion){
        NSString *strName = [_tableviewRegion cellForRowAtIndexPath:indexPath].textLabel.text;
        _cityName.text = strName;
        _regionView.hidden = YES;
        NSArray *strArray = [strName componentsSeparatedByString:@","];
        NSString *cityName;
        NSString *stateName;
        NSString *weatherUrl;
        cityName = [strArray objectAtIndex:0];
        stateName = [strArray objectAtIndex:1];
        weatherUrl = [NSString stringWithFormat:@"conditions/q/%@/%@.json",stateName, cityName];
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"hh:mm"];
        _currentTime.text = [dateFormatter stringFromDate:[NSDate date]];
        [dateFormatter setDateFormat:@"yyyy:mm:dd"];
        _Today.text = [dateFormatter stringFromDate:[NSDate date]];
        [[PolygonAPI sharedManager] getWeather:weatherUrl onSuccess:^(id json) {
            check = [[json objectForKey:@"current_observation"] objectForKey:@"icon_url"];
            NSURL *url = [NSURL URLWithString: (NSString *)check];
            NSData *data = [[NSData alloc] initWithContentsOfURL:url]
            ;
            UIImage *image = [UIImage imageWithData:data];
            [_weatherImage setImage:image];
            NSString *str = [[json objectForKey:@"current_observation"] objectForKey:@"icon"];
            _weatherInfo.text = str;
            NSNumber *temp =  [[json objectForKey:@"current_observation"] objectForKey:@"temp_c"];
            _currentTemp.text = [NSString stringWithFormat:@"%.1f", [temp floatValue]];
            NSString *humidity = [[json objectForKey:@"current_observation"] objectForKey:@"relative_humidity"];
            _humidity.text = humidity;
            NSLog(@"%@", (NSString *)check);
        } onFailure:^(NSInteger statusCode, id json) {
            NSLog(@"failure");
        }];
        weatherUrl = [NSString stringWithFormat:@"astronomy/q/%@/%@.json",stateName, cityName];
        [[PolygonAPI sharedManager] getWeather:weatherUrl onSuccess:^(id json) {
            moonAge = [NSString stringWithFormat:@"%d",[[[json  objectForKey:@"moon_phase"] objectForKey:@"ageOfMoon"] intValue]];
        } onFailure:^(NSInteger statusCode, id json) {
                NSLog(@"failure");
        }];
        _cityName.text = strName;
        _regionView.hidden = YES;
        [_regionSearchBar resignFirstResponder];
        
    }else if (tableView == _tableView3) {
        [_txtSearchTag resignFirstResponder];
        if ([[_txtSearchTag text] length]) {
            [_array addObject:[tempArray objectAtIndex:indexPath.row]];
        }
        _txtSearchTag.placeholder = @"None";
        _txtSearchTag.text = @"";
        [_tagListView setTags:(NSArray*)_array];
        [self tappedAdd];
        tableView.hidden = YES;

    }
}
- (IBAction)tappedDone:(id)sender
{
    [_array removeAllObjects];
    [_tagListView setTags:_array];
    NSDictionary *param = [NSDictionary alloc];
    if (strTags == nil) {
        strTags = @"None";
    }
    param = [NSDictionary dictionaryWithObjects:@[userID, _cityName.text, _weatherInfo.text, _currentTemp.text , _humidity.text, moonAge, _lbEmotion.text , str1, str2,strTags] forKeys:@[@"user_id", @"temp_location", @"temp_weather", @"temp_temperature", @"temp_humidity", @"temp_moonage",  @"temp_emotion", @"temp_suba",@"temp_subb", @"temp_tag"]];

    [self requestUserPosts:param];
    _popUpView.hidden = YES;
}
- (void) requestUserPosts:(id) params {
    NSDictionary *resObj = nil;
    resObj = [commonUtils httpJsonRequest:API_URL_USER_REGISTER withJSON:params];
    
    [commonUtils hideActivityIndicator];
    
    if (resObj != nil) {
        NSDictionary *result = (NSDictionary*)resObj;
        NSDecimalNumber *status = [result objectForKey:@"status"];
        if([status intValue] == 0) {
            NSLog(@"this");
        } else {
            NSLog(@"not");
        }
    } else {
        [commonUtils showVAlertSimple:@"Connection Error" body:@"Please check your internet connection status" duration:1.0];
    }
}
- (IBAction)btnCancel:(id)sender {
    
    [_array removeAllObjects];
    [_tagListView setTags:_array];
    _popUpView.hidden = true;
    
}

#pragma  mark - SearchBar Delegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    signUp = YES;
    searchBar.showsCancelButton = YES;
    
    return YES;
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchBar == _searchBar){
        if ([searchText length] == 0) {
            findStrEmotion =[NSMutableArray arrayWithArray:strEmotion];
        
        } else{
            [findStrEmotion removeAllObjects];
            int i;
            i = 0;
            for (NSDictionary *item in strEmotion) {
                i++;
                NSString *strEmotionName = [item objectForKey:@"Emotion"];
                NSRange r = [strEmotionName rangeOfString:searchText options:NSCaseInsensitiveSearch];
                NSString *strEmotionCatea = [item objectForKey:@"Surprised"];
                NSRange range1 = [strEmotionCatea rangeOfString:searchText options:NSCaseInsensitiveSearch];
                NSString *strEmotionCateb = [item objectForKey:@"Amazed"];
                NSRange range2 = [strEmotionCateb rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (r.location != NSNotFound || range1.location != NSNotFound || range2.location != NSNotFound){
                
                    [findStrEmotion addObject:item];
                }
            
            }

        }
        [_collectionView reloadData];
    }
    if (searchBar == _regionSearchBar){
        [self.geocoder geocodeAddressString:searchText completionHandler: ^ (NSArray *placemarks, NSError *error) {
            self.searchResults = [[NSMutableArray alloc] init];
            for(CLPlacemark *placemark in placemarks) {
                if(placemark.locality) {
                    [self.searchResults addObject:placemark];
                }
            }
            [_tableviewRegion reloadData];
        }];

    }
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    searchBar.showsCancelButton = NO;
    findStrEmotion = [NSMutableArray arrayWithArray:strEmotion];
    [_collectionView reloadData];
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    _regionView.hidden = YES;
}

#pragma  mark - TextView  Method

- (void) textFielDidChange:(UITextField *) textField {
    _tableView3.hidden = NO;
    NSString *strSearchString = _txtSearchTag.text;
    [self updateSearchArray:strSearchString];
}

- (void) updateSearchArray:(NSString *) strSearch {
    if (strSearch.length != 0) {
        tempArray = [NSMutableArray array];
        for (NSString *item in tagList) {
            if ([[item lowercaseString] rangeOfString:[strSearch lowercaseString]].location != NSNotFound) {
                [tempArray addObject:item];
            }
        }
    }else {
        _tableView3.hidden = YES;
    }
    [self.tableView3 reloadData];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    if (textField == _txtSearchTag) {
        _tableView3.hidden = YES;
        _popUpView.hidden = YES;
    }
    return YES;
}

- (void)tappedAdd
{
    NSArray *strTagList = [NSArray arrayWithArray:_tagListView.textArray];
    NSLog(@"%@",strTagList);
    for (int i = 0; i <= strTagList.count - 1 ; i ++) {
        if (i == 0) {
            strTags = [strTagList objectAtIndex:0];
        }else {
            strTags = [NSString stringWithFormat:@"%@, %@", strTags, [strTagList objectAtIndex:i]];
        }
    }
}

#pragma mark - UICollectionView Delegate Method implementation
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return findStrEmotion.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ColloectionViewCell" forIndexPath:indexPath];
    
    cell.lblEmotion.text = [[findStrEmotion objectAtIndex:indexPath.item] objectForKey:@"Emotion"];
    cell.lblAmazed.text = [[findStrEmotion objectAtIndex:indexPath.item] objectForKey:@"Amazed"];
    cell.lblSuprised.text = [[findStrEmotion objectAtIndex:indexPath.item] objectForKey:@"Surprised"];
    
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = [NSString stringWithFormat:@"(%@ %@)", str2, str1];
    _lbAmzed.text = str;
    _lbEmotion.text =  [[findStrEmotion objectAtIndex:indexPath.item] objectForKey:@"Emotion"];
    str1 = [[findStrEmotion objectAtIndex:indexPath.item] objectForKey:@"Amazed"] ;
    str2 = [[findStrEmotion objectAtIndex:indexPath.item] objectForKey:@"Surprised"];
    _lbAmzed.text = [NSString stringWithFormat:@"%@, %@", str1, str2];
    _popUpView.hidden = NO;
}

@end
