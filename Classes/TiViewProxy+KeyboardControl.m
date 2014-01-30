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
#import "Ti2DMatrix.h"
#import "TiViewProxy.h"
#import "TiViewProxy+KeyboardControl.h"
#import "DAKeyboardControl.h"


@implementation TiViewProxy (KeyboardControl)


DEFINE_DEF_PROP(lockedViews, nil);


- (void)setKeyboardPanning:(id)args
{
    ENSURE_UI_THREAD(setKeyboardPanning, args);

    BOOL oldValue = [self keyboardPanning];
    BOOL newValue = [TiUtils boolValue:args def:NO];

    [self replaceValue:[NSNumber numberWithBool:newValue]
                forKey:@"keyboardPanning"
          notification:NO];

    if (newValue && !oldValue)
    {
        [self setupKeyboardPanning];
    }
    else if (!newValue && oldValue)
    {
        [self teardownKeyboardPanning];
    }
}


- (BOOL)keyboardPanning
{
    id value = [self valueForUndefinedKey:@"keyboardPanning"];
    if (value == nil || value == [NSNull null] || ![value respondsToSelector:@selector(boolValue)])
    {
        return NO;
    }
    else
    {
        return [value boolValue];
    }
}


- (void)setupKeyboardPanning
{
    [self.view addKeyboardPanningWithActionHandler:^(CGRect keyboardFrameInView) {
        [self updateKeyboardPanningLockedViews:keyboardFrameInView];
        [self fireEventForKeyboardFrameInView:keyboardFrameInView];
    }];
}


- (void)teardownKeyboardPanning
{
    [self.view removeKeyboardControl];
}


- (void)fireEventForKeyboardFrameInView:(CGRect)keyboardFrameInView
{
    if (![self _hasListeners:@"keyboardchange"]) {
        return;
    }

    NSNumber * keyboardWidth = [NSNumber numberWithFloat:keyboardFrameInView.size.width];
    NSNumber * keyboardHeight = [NSNumber numberWithFloat:keyboardFrameInView.size.height];
    NSNumber * keyboardX = [NSNumber numberWithFloat:keyboardFrameInView.origin.x];
    NSNumber * keyboardY = [NSNumber numberWithFloat:keyboardFrameInView.origin.y];

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
}


- (void)updateKeyboardPanningLockedViews:(CGRect)keyboardFrameInView
{
    ENSURE_UI_THREAD(updateKeyboardPanningLockedViews, keyboardFrameInView);

    NSArray * lockedViews = [self lockedViews];

    ENSURE_TYPE_OR_NIL(lockedViews, NSArray);

    if (lockedViews == nil || [lockedViews count] == 0)
    {
        return;
    }

    float keyboardHeight = keyboardFrameInView.size.height;
    float keyboardY = keyboardFrameInView.origin.y;
    float height = self.view.frame.size.height;

    float shift = keyboardHeight <= 0 ? 0 : (height - keyboardY);

    for (TiViewProxy * proxy in lockedViews) {
        if (proxy != nil)
        {
            [self updateKeyboardPanningLockedView:proxy with:shift];
        }
    }
}


- (void)updateKeyboardPanningLockedView:(TiViewProxy *)proxy with:(float)shift
{
    TiUIView * proxyView = [proxy view];

    CGAffineTransform transform = CGAffineTransformMakeTranslation(0.0f, -shift);

    Ti2DMatrix * matrix = [[Ti2DMatrix alloc] initWithMatrix:transform];

    [proxy replaceValue:matrix forKey:@"transform" notification:YES];
    [proxyView setTransform_:matrix];
}


- (void)setKeyboardTriggerOffset:(id)args
{
    float offset = [TiUtils floatValue:args def:0.0f];
    self.view.keyboardTriggerOffset = offset;
}


@end
