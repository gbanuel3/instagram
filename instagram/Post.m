//
//  Post.m
//  instagram
//
//  Created by Gildardo Banuelos on 7/7/21.
//

#import "Post.h"

@implementation Post

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
     
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"EEE MMM dd hh:mm:ss yyyy"];
        
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    newPost.date = [NSDate date];
    newPost.userID = PFUser.currentUser[@"username"];
    newPost.usrPFP = PFUser.currentUser[@"profile_picture"];
    
//    PFUser *user = [PFUser currentUser];
//    NSMutableArray *existingPosts = PFUser.currentUser[@"posts"];
//    NSLog(@"%@", existingPosts);
//    [existingPosts insertObject:newPost atIndex:existingPosts.count];
//    [user setObject:existingPosts forKey:@"posts"];
//    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if(error){
//            NSLog(@"Error Here");
//        }else{
//            NSLog(@"Successfully saved post to user");
//        }
//    }];

    [newPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(error){
            NSLog(@"Error Here in saving post to DB!");
        }else{
            NSLog(@"Successfully saved post to DB!");
        }
    }];
    

}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];

}
@end
 
