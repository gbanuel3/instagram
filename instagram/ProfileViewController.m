//
//  ProfileViewController.m
//  instagram
//
//  Created by Gildardo Banuelos on 7/9/21.
//

#import "ProfileViewController.h"
#import "ProfileCell.h"
#import "DateTools.h"

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
    
    self.userNameLabel.text = PFUser.currentUser[@"username"];
    
}
- (void)viewDidAppear:(BOOL)animated{
    if(PFUser.currentUser[@"profile_picture"]){
//        NSLog(@"%@", PFUser.currentUser[@"profilePicture"]);
        [PFUser.currentUser[@"profile_picture"] getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
            if (!error) {
                self.profilePictureImage.image = [UIImage imageWithData:imageData];
                NSLog(@"PFP UPDATED");
            }
        }];
    }
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"userID" equalTo:PFUser.currentUser[@"username"]];
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
- (IBAction)onClickCamera:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    self.profilePictureImage.image = originalImage;
//    PFFileObject *imageFile = [Post getPFFileFromImage:[self resizeImage:originalImage withSize: CGSizeMake(180, 180)]];
//    [imageFile saveInBackground];
    PFUser *user = [PFUser currentUser];
//    [user setObject:imageFile forKey:@"profilePicture"];
    NSData * imageData = UIImagePNGRepresentation(editedImage);
            PFObject * image = [PFFileObject fileObjectWithName:@"image.png" data:imageData];
            user[@"profile_picture"] = image;
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error){
            NSLog(@"Saved PFP success!");
        }else{
            NSLog(@"FAILURE");
        }
    }];

    [self dismissViewControllerAnimated:YES completion:nil];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCell"];
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



@end
