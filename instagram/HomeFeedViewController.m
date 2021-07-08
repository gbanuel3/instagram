//
//  HomeFeedViewController.m
//  instagram
//
//  Created by Gildardo Banuelos on 7/6/21.
//

#import "HomeFeedViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ComposeViewController.h"
#import "PostCell.h"
#import "Post.h"
#import "DetailViewController.h"
#import "DateTools.h"
@interface HomeFeedViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation HomeFeedViewController

- (IBAction)logoutButton:(id)sender{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [[UIApplication sharedApplication].keyWindow setRootViewController: loginViewController];
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error){
        NSLog(@"User Logged out successfully!");
    }];
    
}

- (IBAction)onClickCompose:(id)sender{
    [self performSegueWithIdentifier:@"postSegue" sender:self.postButton];

}

- (void)onTimer{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey:@"author"];
    [query includeKey:@"caption"];
    [query includeKey:@"image"];
    [query includeKey:@"date"];
    [query orderByDescending:@"createdAt"];
    
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.arrayOfPosts = posts;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onTimer) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrayOfPosts.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];

    Post *post = self.arrayOfPosts[indexPath.row];

    [post[@"image"] getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            cell.postImage.image = nil;
            cell.postImage.image = [UIImage imageWithData:imageData];
        }else{
            cell.postImage.image = nil;
        }
    }];
    cell.captionLabel.text = post[@"caption"];
    cell.userLabel.text = post[@"author"][@"username"];
    
    NSDate *timeAgo = post[@"date"];
    cell.timeAgoLabel.text = timeAgo.shortTimeAgoSinceNow;

    return cell;
}



#pragma mark - Navigation
 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"cellSelectedSegue"]){
        PostCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *post = self.arrayOfPosts[indexPath.row];
        DetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.post = post;
        return;
    }
}



@end
