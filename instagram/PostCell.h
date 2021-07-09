//
//  PostCell.h
//  instagram
//
//  Created by Gildardo Banuelos on 7/7/21.
//

#import <UIKit/UIKit.h>
#import "PostCell.h"
#import "Post.h"
@protocol PostCellDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (nonatomic, weak) id<PostCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeAgoLabel;
@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UIImageView *pfpImage;


@end

@protocol PostCellDelegate

- (void)PostCell:(PostCell *) postCell didTap: (Post *)post;
@end
NS_ASSUME_NONNULL_END
