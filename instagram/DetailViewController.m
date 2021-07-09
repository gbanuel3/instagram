//
//  DetailViewController.m
//  instagram
//
//  Created by Gildardo Banuelos on 7/8/21.
//

#import "DetailViewController.h"
#import <Parse/Parse.h>
#import "DateTools.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:[NSString stringWithFormat:@"%@", self.post.date.shortTimeAgoSinceNow]];
    NSMutableArray *temp = PFUser.currentUser[@"posts"];
    [temp insertObject:self.post atIndex:temp.count];
    NSLog(@"%@", temp);
    [self.post.image getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            self.postImage.image = [UIImage imageWithData:imageData];
//            PFFileObject *imageFile = [PFFileObject fileObjectWithName:@"img.png" data:imageData];
//            [imageFile saveInBackground];
//            PFUser *user = [PFUser currentUser];
//            [user setObject:imageFile forKey:@"profilePicture"];
//            [user setObject:temp forKey:@"posts"];
//            [user saveInBackground];
            
//            NSLog(@"%@",PFUser.currentUser[@"profilePicture"]);
        }else{
            self.postImage = nil;
        }
    }];
    self.postCaption.text = self.post.caption;
    


    
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
