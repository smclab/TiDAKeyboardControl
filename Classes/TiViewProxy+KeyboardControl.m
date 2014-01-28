/**
 * Copyright (c) 2014 SMC Treviso s.r.l. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */


#import "TiBase.h"
#import "TiComplexValue.h"
#import "TiViewProxy.h"
#import "TiViewProxy+KeyboardControl.h"
#import "DAKeyboardControl.h"


@implementation TiViewProxy (KeyboardControl)


DEFINE_DEF_BOOL_PROP(keyboardPanning, NO);


- (void)setKeyboardPanning:(id)args
{
    BOOL oldValue = [self keyboardPanning];
    BOOL newValue = [TiUtils boolValue:args def:NO];

    if (oldValue == newValue)
    {
        return;
    }

    if (newValue)
    {
        [self.view addKeyboardPanningWithActionHandler:^(CGRect kayboardFrameInView) {

            NSNumber * keyboardWidth = [NSNumber numberWithFloat:kayboardFrameInView.size.width];
            NSNumber * keyboardHeight = [NSNumber numberWithFloat:kayboardFrameInView.size.height];
            NSNumber * keyboardX = [NSNumber numberWithFloat:kayboardFrameInView.origin.x];
            NSNumber * keyboardY = [NSNumber numberWithFloat:kayboardFrameInView.origin.y];

            NSMutableDictionary * event = [NSMutableDictionary dictionary];

            [event setValue:keyboardHeight
                     forKey:@"height"];

            [event setValue:keyboardWidth
                     forKey:@"width"];
            
            [event setValue:keyboardX
                     forKey:@"x"];

            [event setValue:keyboardY
                     forKey:@"y"];
            
            [self fireEvent:@"keyboardchange" withObject:event];
        }];
    }
    else
    {
        [self.view removeKeyboardControl];
    }
}

- (void)setKeyboardTriggerOffset:(id)args
{
    float offset = [TiUtils floatValue:args def:0.0f];
    self.view.keyboardTriggerOffset = offset;
}


@end
