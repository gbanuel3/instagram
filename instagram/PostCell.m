//
//  PostCell.m
//  instagram
//
//  Created by Gildardo Banuelos on 7/7/21.
//

#import "PostCell.h"
#import "Post.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    UITapGestureRecognizer *profileTapGestureRecognizer2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.pfpImage addGestureRecognizer:profileTapGestureRecognizer];
    [self.pfpImage setUserInteractionEnabled:YES];
    
    [self.userLabel addGestureRecognizer:profileTapGestureRecognizer2];
    [self.userLabel setUserInteractionEnabled:YES];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    [self.delegate PostCell:self didTap:self.post];
}

@end
