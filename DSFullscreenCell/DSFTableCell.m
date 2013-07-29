//
//  DSFTableCell.m
//  DSFullscreenCell
//
//  Created by Diego Serrano on 7/29/13.
//  Copyright (c) 2013 Brounie. All rights reserved.
//

#import "DSFTableCell.h"

@implementation DSFTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
