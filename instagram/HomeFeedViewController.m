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
@interface HomeFeedViewController ()

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - Navigation
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//    }
//}


@end
