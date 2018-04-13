//
//  ListUserCell.m
//  GripBall
//
//  Created by 贾辰 on 18/3/14.
//  Copyright © 2018年 贾辰. All rights reserved.
//

#import "ListUserCell.h"
@interface ListUserCell()
@property (nonatomic, strong)UIImageView *imvHead;
@property (nonatomic, strong)UILabel     *lblName;
@end

@implementation ListUserCell

//height : 78.f

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        [self setBackgroundColor:[UIColor clearColor]];
        [self setBackgroundColor:[UIColor greenColor]];
        
        self.imvHead = [[UIImageView alloc] initWithFrame:CGRectMake(14, 9, 60, 60)];
        [self.imvHead.layer setCornerRadius:30.f];
        [self.imvHead.layer setMasksToBounds:YES];
        [self.imvHead setImage:[UIImage imageNamed:@"connect_head"]];
        [self addSubview:self.imvHead];
        
        self.lblName = [[UILabel alloc] initWithFrame:CGRectMake(100, 29, 160, 20)];
        [self.lblName setTextColor:[UIColor colorWithRed:75.f/255.f green:76.f/255.f blue:78.f/255.f alpha:1]];
        [self.lblName setFont:[UIFont fontWithName:@"Arial" size:16.f]];
        [self.lblName setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.lblName];
        
    }
    return self;
}
-(void)setHeadPic:(UIImage *)img{
    [self.imvHead setImage:img];
}
-(void)setName:(NSString *)str{
    [self.lblName setText:str];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
