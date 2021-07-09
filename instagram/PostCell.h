//
//  PostCell.h
//  instagram
//
//  Created by Gildardo Banuelos on 7/7/21.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeAgoLabel;


@end

NS_ASSUME_NONNULL_END
