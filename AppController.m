/*
 Copyright (c) 2011, Stefan Reitshamer http://www.haystacksoftware.com
 
 All rights reserved.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "AppController.h"
#import "FSBrowserCell.h"
#import "FSNode.h"

@implementation AppController
- (void)awakeFromNib {
    [_browser setCellClass:[FSBrowserCell class]];
    [_browser setColumnResizingType:NSBrowserUserColumnResizing];
    _rootNode = [[FSNode alloc] initWithPath:@"/" isDirectory:YES];
}

#pragma mark NSBrowserDelegate
- (id)rootItemForBrowser:(NSBrowser *)browser {
    return _rootNode;    
}
- (NSInteger)browser:(NSBrowser *)browser numberOfChildrenOfItem:(id)item {
    return [[(FSNode *)item children] count];
}
- (id)browser:(NSBrowser *)browser child:(NSInteger)index ofItem:(id)item {
    return [[(FSNode *)item children] objectAtIndex:index];
}
- (BOOL)browser:(NSBrowser *)browser isLeafItem:(id)item {
    return ![(FSNode *)item isDirectory];
}
- (id)browser:(NSBrowser *)browser objectValueForItem:(id)item {
    return [(FSNode *)item displayName];
}
- (void)browser:(NSBrowser *)browser setObjectValue:(id)object forItem:(id)item {
    [(FSNode *)item setState:[object boolValue]];
}
- (void)browser:(NSBrowser *)browser willDisplayCell:(FSBrowserCell *)cell atRow:(NSInteger)row column:(NSInteger)column {
    NSIndexPath *indexPath = [browser indexPathForColumn:column];
    indexPath = [indexPath indexPathByAddingIndex:row];
    FSNode *node = [browser itemAtIndexPath:indexPath];
    [cell setTitle:[node displayName]];
    [cell setState:[node state]];
}
@end
