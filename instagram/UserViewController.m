//
//  UserViewController.m
//  instagram
//
//  Created by Gildardo Banuelos on 7/9/21.
//
 
#import "UserViewController.h"
#import "DateTools.h"
#import "UserProfileCell.h"

@interface UserViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
    self.userNameLabel.text = self.post[@"author"][@"username"];
}
- (void)viewDidAppear:(BOOL)animated{
    [self.post[@"author"][@"profile_picture"] getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            self.profilePicture.image = [UIImage imageWithData:imageData];
//            NSLog(@"PFP UPDATED");
        }
    }];
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"userID" equalTo:self.post[@"author"][@"username"]];
    [query includeKey:@"author"];
    [query includeKey:@"caption"];
    [query includeKey:@"image"];
    [query includeKey:@"date"];
    [query orderByDescending:@"createdAt"];
    
    query.limit = 300;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.arrayOfPosts = posts;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UserProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserProfileCell"];
    Post *post = self.arrayOfPosts[indexPath.row];
    cell.nameLabel.text = post.author[@"username"];
    cell.captionLabel.text = post.caption;
    NSDate *timeAgo = post[@"date"];
    cell.timeAgoLabel.text = timeAgo.shortTimeAgoSinceNow;
    [post.image getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            cell.postImage.image = [UIImage imageWithData:imageData];
        }
    }];



    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
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
